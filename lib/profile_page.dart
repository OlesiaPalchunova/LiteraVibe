import 'package:flutter/material.dart';
import 'package:litera_vibe/profile/user_page.dart';

import 'db/storage/token.dart';
import 'home/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLogin = Token.isToken();

  void _Update() {
    setState(() {
      isLogin = Token.isToken();
      print("888888");
      print(isLogin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ?
    UserPage(updateLogin: _Update,)
    : LoginPage(updateLogin: _Update,);
  }
}

