import 'package:flutter/material.dart';

import '../models/text_place.dart';
import '../style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 0) return Login(context);
    if (_currentIndex == 1) return Register(context);
    if (_currentIndex == 2) return AddImage(context);
    else return Final(context);
  }

  Widget Login(BuildContext context){
    return Container(
      child: Column(
        children: [
          SizedBox(height: 120,),
          Text("Вход",
            style: TextStyle(
                fontFamily: font,
                fontSize: 40,
                color: Colors.mycolor5
            ),
          ),
          TextPlace(text: "Введите логин"),
          TextPlace(text: "Введите пароль"),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.mycolor2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: Size(300, 40),
            ),
            child: Text(
              'Зарегистрироваться',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: font,
                  fontSize: 20
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget Register(BuildContext context){
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
                        setState(() {
                          _currentIndex = 0;
                        });
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
                        setState(() {
                          _currentIndex = 2;
                        });
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

  Widget AddImage(BuildContext context){
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
          Center(
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                color: Colors.mycolor4,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                width: 200,
                height: 150,
                color: Colors.mycolor4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.mycolor2, // Задайте желаемый цвет фона
                      ),
                      child: Text(
                        'Добавить фото',
                        style: TextStyle(
                          color: Colors.mycolor5,
                          fontFamily: font,
                          fontSize: 17
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: 300,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _currentIndex = 1;
                        });
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
                        setState(() {
                          _currentIndex = 3;
                        });
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

  Widget Final(BuildContext context){
    return Container(
      child: Column(
        children: [
          SizedBox(height: 120,),
          Center(
            child: Text("Регистрация\nпрошла успешно!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 30,
                  color: Colors.mycolor5,
              ),
            ),
          ),
          Container(
            height: 200,
            child: Image(
                image: AssetImage("lib/assets/image/books.png")
            ),
          ),
          Center(
            child: Text("Спасибо, что выбрали\nименно нас!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: font,
                  fontSize: 20,
                  color: Colors.mycolor5
              ),
            ),
          ),
        ],
      ),
    );
  }
}
