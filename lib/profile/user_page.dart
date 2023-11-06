import 'package:flutter/material.dart';

import '../style.dart';

class UserPage extends StatefulWidget {

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 40,),
          Container(
            height: 230,
            width: 320,
            decoration: BoxDecoration(
              color: Colors.mycolor4,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                    "https://cs14.pikabu.ru/post_img/big/2023/02/13/8/1676295806139337963.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.mycolor3,
                  size: 50,
                ),
                SizedBox(width: 20,),
                Text(
                  "Рината",
                  style: TextStyle(
                    color: Colors.mycolor5,
                    fontFamily: font,
                    fontSize: 30
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.mail_outline,
                  color: Colors.mycolor3,
                  size: 50,
                ),
                SizedBox(width: 20,),
                Text(
                  "rinata@g.nsu.ru",
                  style: TextStyle(
                      color: Colors.mycolor5,
                      fontFamily: font,
                      fontSize: 30
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 10.0),
            child: Row(
              children: [
                Icon(
                  Icons.alternate_email,
                  color: Colors.mycolor3,
                  size: 50,
                ),
                SizedBox(width: 20,),
                Text(
                  "@coolgirl_45",
                  style: TextStyle(
                      color: Colors.mycolor5,
                      fontFamily: font,
                      fontSize: 30
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 15),
            child: ElevatedButton(
              onPressed: () {
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.mycolor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(320, 50),
              ),
              child: Text(
                'изменить данные',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: font,
                    fontSize: 25
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.mycolor2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(320, 50),
            ),
            child: Text(
              'изменить данные',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: font,
                  fontSize: 25
              ),
            ),
          )
        ],
      ),
    );
  }
}
