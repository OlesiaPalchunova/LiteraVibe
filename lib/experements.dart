import 'package:flutter/material.dart';
import 'package:litera_vibe/db/book_db.dart';

import 'models/book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Field Example',
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  List<Book> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = [];
  }

  void filterSearchResults(String query) async {
    // List<String> searchList = items.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();
    List<Book> searchList = await BookDB().getBooksByName(query);
    setState(() {
      filteredItems = searchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.mycolor5,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextField(
              cursorColor: Colors.black,
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                hintText: 'Поиск...',
                prefixIcon: IconButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_sharp),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent), // Устанавливаем цвет подчеркивания при фокусе
                ),
              ),
            ),
          ),
          Container(
            height: 1.0,
            color: Colors.black, // Цвет линии
            margin: EdgeInsets.symmetric(horizontal: 0.0), // Отступы справа и слева
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(
                        '/book_page',
                        arguments: filteredItems[index],
                      );
                    },
                    child: Text(
                        filteredItems[index].name,
                      style: TextStyle(
                        color: Colors.black
                      ),
                    ),
                    style: ButtonStyle(
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  // title: Text(filteredItems[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
