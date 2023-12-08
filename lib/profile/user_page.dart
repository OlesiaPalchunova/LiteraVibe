import 'package:flutter/material.dart';
import 'package:litera_vibe/db/storage/user_info.dart';

import '../db/storage/token.dart';
import '../models/profile.dart';
import '../style.dart';

class UserPage extends StatefulWidget {
  void Function() updateLogin;
  UserPage({required this.updateLogin});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isUpdating = false;
  late TextEditingController _nameController;
  late TextEditingController _mailController;
  late TextEditingController _uidController;
  late Profile profile;

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();


  @override
  void initState() {
    super.initState();
    profile = Profile(
        uid: UserInfo.uid,
        display_name: UserInfo.name,
        image: UserInfo.image ?? "",
        mail: UserInfo.email
    );
    _nameController = TextEditingController(text: profile.display_name);
    _mailController = TextEditingController(text: profile.mail);
    _uidController = TextEditingController(text: profile.uid);
  }

  Widget EditingField(String text, TextEditingController _noticeController) {
    return Container(
      height: 50,
      width: 200,
      child: TextField(
        controller: _noticeController,
        decoration: InputDecoration(
          hintText: text,
          labelStyle: TextStyle(color: Colors.mycolor5),
          contentPadding: EdgeInsets.all(0),
        ),
        style: TextStyle(
            color: Colors.mycolor5,
            fontSize: 25,
          fontFamily: font
        ),

      ),
    );
  }

  Widget TextPlace(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.mycolor5,
          fontFamily: font,
          fontSize: 30
      ),
    );
  }

  Widget PasswordField(String text, TextEditingController _noticeControlle) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.mycolor5,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "введите старый пароль",
              labelStyle: TextStyle(color: Colors.mycolor5),
              contentPadding: EdgeInsets.all(0),
              border: InputBorder.none,
            ),
            style: TextStyle(
                color: Colors.mycolor0,
                fontSize: 15,
                fontFamily: font
            ),
          ),
        ),
      ),
    );
  }

  void ChangePassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.mycolor4,
          title: Text('Изменение пароля'),
          content: Container(
            height: 200,
            child: Column(
              children: [
                PasswordField("Ввдеите пароль..", _passwordController),
                PasswordField("Придумайте новый пароль..", _newPasswordController),
                PasswordField("Подтвердите пароль..", _confirmPasswordController),
              ],
            ),
          ),
          actions: [
          Container(
            width: 300,
              color: Colors.blue,
              child: Center(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.mycolor3,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Закрыть диалог по нажатию кнопки
                        },
                        child: Text('Закрыть'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.mycolor5,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Закрыть диалог по нажатию кнопки
                        },
                        child: Text('Закрыть'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () async {
                  await Token().deleteAll();
                  print(66666666666);
                  widget.updateLogin();
                  print(66666666666);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.mycolor4,
                  size: 30,
                ),
              ),
            ),
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
                      profile.image != "null" ? profile.image : "https://cs14.pikabu.ru/post_img/big/2023/02/13/8/1676295806139337963.png",
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
                  isUpdating
                      ? EditingField(profile.display_name, _nameController)
                      : TextPlace(profile.display_name)
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
                  isUpdating
                      ? EditingField(profile.mail, _mailController)
                      : TextPlace(profile.mail)
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
                  isUpdating
                      ? EditingField(profile.uid, _uidController)
                      : TextPlace(profile.uid)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 15),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isUpdating = !isUpdating;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.mycolor2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(320, 50),
                ),
                child: Text(
                  isUpdating ?'сохранить данные' : 'изменить данные',
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
                ChangePassword(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.mycolor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                minimumSize: Size(320, 50),
              ),
              child: Text(
                'изменить пароль',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: font,
                    fontSize: 25
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
