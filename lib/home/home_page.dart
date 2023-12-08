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

  void initBooks() async {
    books = await BookDB().getBook();
    setState(() {});
  }

  @override
  void initState() {
    initBooks();
    super.initState();
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
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[
                      Tooltip(
                        message: 'Change brightness mode',
                        child: IconButton(
                          isSelected: isDark,
                          onPressed: () {
                            setState(() {
                              isDark = !isDark;
                            });
                          },
                          icon: const Icon(Icons.wb_sunny_outlined),
                          selectedIcon: const Icon(Icons.brightness_2_outlined),
                        ),
                      )
                    ],
                  );
                }, suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
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
                    childAspectRatio: 0.75,
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