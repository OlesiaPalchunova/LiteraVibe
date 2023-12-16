import 'package:flutter/material.dart';
import 'package:litera_vibe/db/auth_db.dart';
import 'package:litera_vibe/db/book_db.dart';

import '../models/book.dart';
import '../models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];
  bool isDark = false;
  String currentInput = '';
  List<String> suggestions = [];
  final SearchController controller = SearchController();

  void initBooks() async {
    books = await BookDB().getBook();
    setState(() {});
  }

  @override
  void initState() {
    initBooks();
    super.initState();
  }

  void updateSuggestions(String input) {
    // Ваш код для обновления списка подсказок на основе ввода
    // Например, можно фильтровать данные или делать запросы
    setState(() {
      suggestions = ["8"];
    });
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData(
        useMaterial3: true,
        brightness: isDark ? Brightness.dark : Brightness.light);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Padding(
          //     padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 10),
          //     child: Container(
          //       height: 50,
          //       decoration: BoxDecoration(
          //         color: Colors.mycolor4,
          //         borderRadius: BorderRadius.all(Radius.circular(30)),
          //       ),
          //       child: Row(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(left: 8.0),
          //             child: Icon(
          //               Icons.search,
          //               color: Colors.mycolor0,
          //               size: 40,
          //             ),
          //           ),
          //           Expanded(
          //             child: TextField(
          //               decoration: InputDecoration(
          //                 hintText: 'Поиск книги',
          //                 border: InputBorder.none,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     )
          // ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchAnchor(

                searchController: controller,
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (states) => Colors.mycolor5,
                    ),
                    hintText: "Найти книгу",
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/search',
                      );
                    },
                    leading: const Icon(Icons.search),
                  );
                },

                suggestionsBuilder:
                (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                  );
                });
            }),
          ),
          Container(
            height: 550,
            child: CustomScrollView(
              slivers: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.55,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => Post(book: books[index]),
                    childCount: books.length,
                  ),
                ),
              ]

            )
          ),
        ],
      ),
    );
  }
}
