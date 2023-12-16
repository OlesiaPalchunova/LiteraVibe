import 'package:flutter/material.dart';
import 'package:litera_vibe/db/notes_db.dart';
import 'package:litera_vibe/models/stars.dart';
import 'package:litera_vibe/models/stars_panel.dart';

import '../book_page.dart';
import '../db/mark_db.dart';
import '../db/storage/user_info.dart';
import '../home/login_page.dart';
import '../style.dart';
import 'Note.dart';
import 'book.dart';

class ReportModel extends StatefulWidget {

  Book book;

  ReportModel({required this.book});

  @override
  State<ReportModel> createState() => _ReportModelState();
}

class _ReportModelState extends State<ReportModel> {
  Book get book => widget.book;
  String notice = "";
  int userMark = 0;

  @override
  void initState() {
    initNotice();
    initMark();
    super.initState();
  }

  @override
  void didUpdateWidget(ReportModel oldWidget) {
    if (oldWidget.book != widget.book) {
      initNotice();
      initMark();
    }
    super.didUpdateWidget(oldWidget);
  }

  void initMark() async {
    int newUserMark = await MarkDB().getUserMark(book.id, UserInfo.uid);
    setState(() {
      userMark = newUserMark;
    });
  }

  void changeMark(int newMark) async {
    var status;
    if (userMark == 0) {
      status = await MarkDB().addUserMark(book.id, UserInfo.uid, newMark);
    } else {
      status = await MarkDB().updateUserMark(book.id, UserInfo.uid, newMark);
    }
    if (status == 200){
      setState(() {
        userMark = newMark;
      });
    }
  }

  void initNotice() async {
    print(book.name);
    Note newNotice = await NotesDB().getNote(book.id);
    setState(() {
      notice = newNotice.content;
    });
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Заголовок Alert'),
          content: Text('Это текст Alert.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть диалог по нажатию кнопки
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(
            '/book_page',
            arguments: widget.book,
          );
          // _showAlertDialog(context);
        },
        child: Container(
          height: 170,
          width: 340,
          decoration: BoxDecoration(
            color: Colors.mycolor4,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 15),
                child: Image.network(widget.book.imageUrl),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      width:200,
                      child: Text(
                        book.name,
                        style: TextStyle(
                          color: Colors.mycolor1,
                          fontFamily: font,
                          fontSize: widget.book.name.length < 19 ? 20 : 15,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.mycolor5,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          notice,
                          style: TextStyle(
                            fontFamily: font,
                            color: Colors.mycolor1,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star),
                            Text(
                              widget.book.mark.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                        SizedBox(width: 30,),
                        Row(
                          children: [
                            Stars(stars_count: userMark),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

