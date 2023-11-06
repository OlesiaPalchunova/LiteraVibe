import 'package:flutter/material.dart';

import '../book_page.dart';
import '../home/login_page.dart';
import '../style.dart';

class ReportModel extends StatefulWidget {
  String image_url;
  String name;
  String description;
  double mark;

  ReportModel({required this.image_url, required this.name, required this.description, required this.mark});

  @override
  State<ReportModel> createState() => _ReportModelState();
}

class _ReportModelState extends State<ReportModel> {

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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BookPage(),
          ));
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
                child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width:200,
                      child: Text(
                        "Book night holly black",
                        style: TextStyle(
                          color: Colors.mycolor1,
                          fontFamily: font,
                          fontSize: 17
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.mycolor5,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          "Очень крутая книга! Только жалко главного героя.",
                          style: TextStyle(
                            fontFamily: font,
                            color: Colors.mycolor1
                          ),
                        ),
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star),
                            Text(
                                "4.0",
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
                            Icon(Icons.favorite),
                            Icon(Icons.favorite),
                            Icon(Icons.favorite),
                            Icon(Icons.favorite),
                            Icon(Icons.favorite),
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

