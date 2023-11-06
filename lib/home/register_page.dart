import 'package:flutter/material.dart';

import '../models/text_place.dart';
import '../style.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 120,),
          Text("Регистрация",
            style: TextStyle(
                fontFamily: font,
                fontSize: 40,
                color: Colors.mycolor5
            ),
          ),
          TextPlace(text: "Введите имя"),
          TextPlace(text: "Введите логин"),
          TextPlace(text: "Введите пароль"),
          TextPlace(text: "Введите email"),
          SizedBox(height: 20,),
          Container(
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.mycolor2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    minimumSize: Size(50, 40),
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.mycolor4,)
                ),
                ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.mycolor2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      minimumSize: Size(50, 40),
                    ),
                    child: Icon(Icons.arrow_forward_sharp, color: Colors.mycolor4,)
                ),
              ]
            ),
          )
        ],
      ),
    );
  }
}
