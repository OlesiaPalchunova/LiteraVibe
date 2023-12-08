import 'package:flutter/material.dart';

import '../db/auth_db.dart';
import '../models/text_place.dart';
import '../style.dart';

class LoginPage extends StatefulWidget {

  void Function() updateLogin;
  LoginPage({required this.updateLogin});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  int _currentIndex = 0;
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  TextEditingController _nameRegisterController = TextEditingController();
  TextEditingController _loginRegisterController = TextEditingController();
  TextEditingController _passwordRegisterController = TextEditingController();
  TextEditingController _emailRegisterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_currentIndex == 0) return Login(context);
    if (_currentIndex == 1) return Register(context);
    if (_currentIndex == 2) return AddImage(context);
    else return Final(context);
  }

  Widget Login(BuildContext context){
    return SingleChildScrollView(
      child: Container(
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
            TextPlace(text: "Введите логин", controller: _loginController),
            TextPlace(text: "Введите пароль", controller: _passwordController),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                await Authorization.loginUser(_loginController.text, _passwordController.text);
                print(7777);
                widget.updateLogin();
                print(7777);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.mycolor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(300, 40),
              ),
              child: Text(
                'Войти',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: font,
                    fontSize: 20
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              child: Text(
                'Зарегистрироваться',
                style: TextStyle(
                    color: Colors.mycolor4,
                    fontFamily: font,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Register(BuildContext context){
    return SingleChildScrollView(
      child: Container(
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
            TextPlace(text: "Введите имя", controller: _nameRegisterController),
            TextPlace(text: "Введите логин", controller: _loginRegisterController),
            TextPlace(text: "Введите пароль", controller: _passwordRegisterController),
            TextPlace(text: "Введите email", controller: _emailRegisterController),
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
      ),
    );
  }

  Widget AddImage(BuildContext context){
    return SingleChildScrollView(
      child: Container(
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
      ),
    );
  }

  void failedToLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Не получилось войти в систему, попробуйте еше раз'),
          // actions: [
          //   TextButton(
          //       onPressed: (){
          //         setState(() {
          //           _currentIndex = 2;
          //         });
          //         Navigator.of(context).pop();
          //       },
          //       child: Text("Хорошо(")
          //   )
          // ],
        );
      },
    );
  }

  void tryLogin(BuildContext context) async {
    int status = await Authorization.registerUser(_loginRegisterController.text, _passwordRegisterController.text, _nameRegisterController.text, _emailRegisterController.text, "");
    if (status == 200) {
      Future.delayed(const Duration(seconds: 2), () async {
        widget.updateLogin();
      });
    } else {
      failedToLogin(context);
      setState(() {
        _currentIndex = 2;
      });
    }
  }

  Widget Final(BuildContext context){

    tryLogin(context);

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
          // Container(
          //   height: 200,
          //   child: Image(
          //       image: AssetImage("lib/assets/image/books.png")
          //   ),
          // ),
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
