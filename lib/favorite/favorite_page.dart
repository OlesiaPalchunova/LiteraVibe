import 'package:flutter/material.dart';

import '../models/report_model.dart';

class FavoritePage extends StatefulWidget {

  @override
  _FavoritePageState createState() => _FavoritePageState();


}

class _FavoritePageState extends State<FavoritePage>{

  int current_button = 0;
  List<ReportModel> saved = [
    ReportModel(
        image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
        name: "Book night holly black",
        description: "Очень крутая книга! Только жалко главного героя.",
        mark: 4.0
    ),
    ReportModel(
        image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
        name: "Book night holly black",
        description: "Очень крутая книга! Только жалко главного героя.",
        mark: 4.0
    ),
    ReportModel(
        image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
        name: "Book night holly black",
        description: "Очень крутая книга! Только жалко главного героя.",
        mark: 4.0
    ),
  ];

  List<ReportModel> started = [
    ReportModel(
        image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
        name: "Book night holly black",
        description: "Очень крутая книга! Только жалко главного героя.",
        mark: 4.0
    ),
  ];

  List<ReportModel> read = [
    ReportModel(
        image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
        name: "Book night holly black",
        description: "Очень крутая книга! Только жалко главного героя.",
        mark: 4.0
    ),
    ReportModel(
        image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
        name: "Book night holly black",
        description: "Очень крутая книга! Только жалко главного героя.",
        mark: 4.0
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: Container(
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                color: Colors.mycolor2,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                children: [
                  TextButton(
                      onPressed: (){
                        setState(() {
                          current_button = 0;
                        });
                      },
                      child: Text(
                        "Сохраненные",
                        style: TextStyle(color: current_button == 0 ? Colors.mycolor5 : Colors.mycolor4),
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
                      "Начатое",
                      style: TextStyle(color: current_button == 1 ? Colors.mycolor5 : Colors.mycolor4),
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
                      "Прочитанное",
                      style: TextStyle(color: current_button == 2 ? Colors.mycolor5 : Colors.mycolor4),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 570,
          width: 340,
          child: ListView(
            children: <Widget>[
              if (current_button == 0) for (var s in saved) s,
              if (current_button == 1) for (var s in started) s,
              if (current_button == 2) for (var s in read) s,
              // ReportModel(
              //     image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
              //     name: "Book night holly black",
              //     description: "Очень крутая книга! Только жалко главного героя.",
              //     mark: 4.0
              // ),
              // ReportModel(
              //     image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
              //     name: "Book night holly black",
              //     description: "Очень крутая книга! Только жалко главного героя.",
              //     mark: 4.0
              // ),

              // ReportModel(),
              // ReportModel(),
              // ReportModel(),
            ],
          ),
        )
      ],
    );
  }
}
