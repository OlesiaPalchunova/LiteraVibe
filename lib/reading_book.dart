import 'package:flutter/material.dart';
import 'package:litera_vibe/style.dart';

import 'models/book.dart';

class ReadingBook extends StatefulWidget {
  const ReadingBook({super.key});

  @override
  State<ReadingBook> createState() => _ReadingBookState();
}

class _ReadingBookState extends State<ReadingBook> {
  bool _isInitialized = false;
  Book book = Book(id: 0, name: "", imageUrl: "", countPages: 0, info: "", authors: [], year: 0, publisherId: 0, mark: 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final Book newBook = ModalRoute.of(context)!.settings.arguments as Book;
      initBook(newBook);
      _isInitialized = true;
    }
  }

  void initBook(Book newBook) {
    setState(() {
      book = newBook;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.mycolor1,
      appBar: AppBar(
        backgroundColor: Colors.mycolor0,
        title: Text(
          'LiteraVibe',
          style: TextStyle(color: Colors.mycolor5, fontFamily: font),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Container(
                height: 650,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      book.name,
                      style: TextStyle(
                        color: Colors.mycolor5,
                        fontSize: 60,
                        fontFamily: font
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_back_ios, color: Colors.mycolor4),
                ),
                Text(
                  '1/${book.countPages}',
                  style: TextStyle(color: Colors.mycolor4),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.mycolor4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
