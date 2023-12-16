import 'package:flutter/material.dart';
import 'package:litera_vibe/db/collections_db.dart';
import 'package:litera_vibe/db/commentDB.dart';
import 'package:litera_vibe/db/mark_db.dart';
import 'package:litera_vibe/db/storage/token.dart';
import 'package:litera_vibe/db/storage/user_info.dart';
import 'package:litera_vibe/style.dart';

import 'db/notes_db.dart';
import 'models/Note.dart';
import 'models/book.dart';
import 'models/comment.dart';
import 'models/comment_model.dart';
import 'models/stars.dart';
import 'models/stars_panel.dart';

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
  bool isEmpty = true;
  bool isAdding = false;
  int currentButton = 0;
  bool _isInitialized = false;
  static int mark = 0;
  Note note = Note(id: 0, content: "");


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      final Book newBook = ModalRoute.of(context)!.settings.arguments as Book;
      initBook(newBook);
      initComments();
      _isInitialized = true;
      initMark();
      initNote();
    }
  }

  void initBook(Book newBook) {
    setState(() {
      book = newBook;
    });
  }

  void changeMark(int newMark) async {
    var status;
    if (mark == 0) {
      status = await MarkDB().addUserMark(book.id, UserInfo.uid, newMark);
    } else {
      await MarkDB().deleteUserMark(book.id, UserInfo.uid);
      status = await MarkDB().addUserMark(book.id, UserInfo.uid, newMark);
    }
    if (status == 200){
      setState(() {
        mark = newMark;
      });
    }
  }

  void initNote() async {
    Note newNote = await NotesDB().getNote(book.id);
    setState(() {
      print(99999);
      print(note);
      note = newNote;
      isEmpty = note.content == "";
      isNoticed = note.content != "";
      _noticeController.text = note.content;
    });

  }

  void initMark() async {
    var newMark = await MarkDB().getUserMark(book.id, UserInfo.uid);
    print("newMark");

    setState(() {
      mark = newMark;
      print(mark);
    });
  }

  Future<void> initComments() async {
    List<Comment> coms = await CommentDB().getComments(book.id);
    List<CommentModel> loadedComments = coms.map((c) => CommentModel(comment: c, onDelete: initComments,)).toList();
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
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  print(isEmpty);
                  if (isEmpty) NotesDB().addNote(book.id, UserInfo.uid, _noticeController.text);
                  else NotesDB().updateNote(note.id, book.id, UserInfo.uid,_noticeController.text);
                  setState(() {
                    isEmpty = false;
                    isNoticed = !isNoticed;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.mycolor3),
                  minimumSize: MaterialStateProperty.all<Size>(Size(10, 30)), // Установка размера кнопки (ширина x высота)
                ),
                child: Text(
                  "Сохранить",
                  style: TextStyle(
                    color: Colors.mycolor5,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.mycolor5,
                    fontFamily: font,
                  ),
                ),
              ),
              SizedBox(width: 10,),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isNoticed = true;
                    isAdding = false;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.mycolor3),
                  minimumSize: MaterialStateProperty.all<Size>(Size(10, 30)), // Установка размера кнопки (ширина x высота)
                ),
                child: Text(
                  "Вернуться",
                  style: TextStyle(
                    color: Colors.mycolor5,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.mycolor5,
                    fontFamily: font,
                  ),
                ),
              ),
              Spacer()
            ],
          ),

        ],
      ),
    )
    : ElevatedButton(
      onPressed: () {
        setState(() {
          isAdding = !isAdding;
        });
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.mycolor3),
        minimumSize: MaterialStateProperty.all<Size>(Size(10, 30)), // Установка размера кнопки (ширина x высота)
      ),
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
      isEmpty = true;
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
              color: Colors.mycolor5,
            fontFamily: font,
            fontSize: 15
          ),
        ),
      );
    }
    else if (current_button == 1) {
      return  isNoticed ?
      Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              width: 320,
              decoration: BoxDecoration(
                // color: Colors.mycolor3,
                // borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  textAlign: TextAlign.left,
                  '"' + _noticeController.text + '"',
                  style: TextStyle(
                      color: Colors.mycolor5,
                    fontSize: 15,
                    fontFamily: font,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isAdding = true;
                      isNoticed = false;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.mycolor3),
                    minimumSize: MaterialStateProperty.all<Size>(Size(10, 30)), // Установка размера кнопки (ширина x высота)
                  ),
                  child: Text(
                    "Изменить",
                    style: TextStyle(
                      color: Colors.mycolor5,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.mycolor5,
                      fontFamily: font,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                  onPressed: () {
                    ConfirmDeleting(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.mycolor3),
                    minimumSize: MaterialStateProperty.all<Size>(Size(90, 30)), // Установка размера кнопки (ширина x высота)
                  ),
                  child: Text(
                    "Удалить",
                    style: TextStyle(
                      color: Colors.mycolor5,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.mycolor5,
                      fontFamily: font,
                    ),
                  ),
                ),
                Spacer(),
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
                    child: Image.network("${book.imageUrl}")
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
                          width: 200,
                          child: StarsPanel(stars_count: mark, onUpdate: changeMark,)
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
                  CollectionsDB().readBook(book.id);
                  Navigator.of(context).pushNamed(
                      '/reading_book',
                    arguments: book,
                  );
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
              // padding: EdgeInsets.only(bottom: 10),
              margin: EdgeInsets.only(bottom: 40),
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

