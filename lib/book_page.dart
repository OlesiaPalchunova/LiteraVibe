import 'package:flutter/material.dart';
import 'package:litera_vibe/db/commentDB.dart';
import 'package:litera_vibe/db/storage/token.dart';
import 'package:litera_vibe/db/storage/user_info.dart';
import 'package:litera_vibe/style.dart';

import 'models/book.dart';
import 'models/comment.dart';
import 'models/comment_model.dart';
import 'models/stars.dart';

class BookPage extends StatefulWidget {
  BookPage();
  // BookPage({required this.book});
  //
  // Book book;

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {


  int current_button = 0;
  late Book book;
  TextEditingController _noticeController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  List<CommentModel> comments = [];
  bool isNoticed = false;
  bool isAdding = false;
  int currentButton = 0;
  bool _isInitialized = false;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final Book newBook = ModalRoute.of(context)!.settings.arguments as Book;
      initBook(newBook);
      initComments();
      _isInitialized = true;
    }
  }
  void initBook(Book newBook) {
    setState(() {
      book = newBook;
    });
  }

  Future<void> initComments() async {
    List<Comment> coms = await CommentDB().getComments(book.id);
    List<CommentModel> loadedComments = coms.map((c) => CommentModel(comment: c)).toList();
    setState(() {
      comments = loadedComments;
    });
  }

  Widget Add() {
    return isAdding ?
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            cursorColor: Colors.mycolor5,
            maxLines: null,
            controller: _noticeController,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.mycolor5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.mycolor5), // Цвет выделения при фокусе
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.mycolor4), // Цвет выделения при неактивном состоянии
              ),
            ),
            style: TextStyle(color: Colors.mycolor5), // Цвет вводимого текста
          ),
          TextButton(
            onPressed: () {
              setState(() {
                isNoticed = !isNoticed;
              });
            },
            child: Text(
              "Сохранить заметку",
              style: TextStyle(
                color: Colors.mycolor5,
                decoration: TextDecoration.underline,
                decorationColor: Colors.mycolor5,
                fontFamily: font,
              ),
            ),
          )
        ],
      ),
    )
    : TextButton(
      onPressed: () {
        setState(() {
          isAdding = !isAdding;
        });
      },
      child: Text(
        "Добавить заметку",
        style: TextStyle(
          color: Colors.mycolor5,
          decoration: TextDecoration.underline,
          decorationColor: Colors.mycolor5,
          fontFamily: font,
        ),
      ),
    );
  }

  void Delete() {
    setState(() {
      isNoticed = false;
      isAdding = false;
      _noticeController.text = "";
    });
  }


  void ConfirmDeleting(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.mycolor5,
          title: Text('Вы точно хотите удалить Заметку?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Delete();
                Navigator.of(context).pop();
              },
              // style: ButtonStyle(
              //   backgroundColor: MaterialStateProperty.all<Color>(Colors.mycolor4),
              // ),
              child: Center(
                  child: Text(
                      'Удалить',
                    style: TextStyle(
                      color: Colors.mycolor2,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.mycolor2,
                      fontFamily: font,
                    ),
                  )
              ),
            ),
          ],
        );
      },
    );
  }


  Widget Content(){
    if (current_button == 0) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          book.info,
          style: TextStyle(
              color: Colors.mycolor4,
            fontFamily: font,
          ),
        ),
      );
    }
    else if (current_button == 1) {
      return  isNoticed ?
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.left,
              _noticeController.text,
              style: TextStyle(
                  color: Colors.mycolor5
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isAdding = true;
                      isNoticed = false;
                    });
                  },
                  child: Text(
                    "Изменить заметку",
                    style: TextStyle(
                      color: Colors.mycolor5,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.mycolor5,
                      fontFamily: font,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ConfirmDeleting(context);
                  },
                  child: Text(
                    "Удалить заметку",
                    style: TextStyle(
                      color: Colors.mycolor5,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.mycolor5,
                      fontFamily: font,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
      : Add();
    } else {
      return Column(
        children: [
          Container(
            height: 300,
            child: ListView(
              children: <Widget>[
                for (var s in comments) s,
              ],
            ),
          ),
          Container(
            height: 50,
            // color: Colors.red,
            child: Row(
              children: [
                // Icon(Icons.message_sharp),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.mycolor4,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Добавить комментарий..',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (Token.is_token) {
                      Comment comment = Comment(
                          id: 0,
                          login: UserInfo.uid,
                          book_id: book.id,
                          post_time: DateTime.now().toString(),
                          content: _commentController.text
                      );
                      await CommentDB().addComment(comment);
                      initComments();
                    }
                  },
                  color: Colors.mycolor1,
                  icon: Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.mycolor1,
      appBar: AppBar(
        backgroundColor: Colors.mycolor0,
        title: Text('LiteraVibe', style: TextStyle(color: Colors.mycolor5, fontFamily: font),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU")
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 200,
                        child: Text(
                            book.name,
                          style: TextStyle(
                            color: Colors.mycolor5,
                            fontSize: 22,
                            fontFamily: font,

                          )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 200,
                        child: Text(
                            "страниц: ${book.countPages}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.mycolor4,
                              fontSize: 15,
                              fontFamily: font,
                            )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 200,
                        child: Text(
                            "автор: @${book.publisherId}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.mycolor4,
                              fontSize: 15,
                              fontFamily: font,
                            )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        width: 200,
                        child: Text(
                            "год: ${book.year}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.mycolor4,
                              fontSize: 15,
                              fontFamily: font,
                            )
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10),
                          width: 200,
                          child: Stars(stars_count: book.mark.round(), isDark: false,)
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: 350,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/reading_book');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.mycolor2, // Задайте желаемый цвет фона
                ),
                child: Text(
                  'Читать книгу',
                  style: TextStyle(
                      color: Colors.mycolor5,
                      fontFamily: font,
                      fontSize: 20
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 350,
              // height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.mycolor2
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: (){
                          setState(() {
                            current_button = 0;
                          });
                        },
                        child: Text(
                          "Сюжет",
                          style: TextStyle(
                              color: current_button == 0 ? Colors.mycolor5 : Colors.mycolor4,
                            fontSize: 22,
                            fontFamily: font
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: Colors.mycolor5),
                      ),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            current_button = 1;
                          });
                        },
                        child: Text(
                          "Заметка",
                          style: TextStyle(
                              color: current_button == 1 ? Colors.mycolor5 : Colors.mycolor4,
                              fontSize: 22,
                              fontFamily: font
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: Colors.mycolor5),
                      ),
                      TextButton(
                        onPressed: (){
                          setState(() {
                            current_button = 2;
                          });
                        },
                        child: Text(
                          "Оценки",
                          style: TextStyle(
                              color: current_button == 2 ? Colors.mycolor5 : Colors.mycolor4,
                              fontSize: 22 ,
                              fontFamily: font
                          ),
                        ),
                      )
                    ],
                  ),
                  Content()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
