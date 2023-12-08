import 'package:flutter/cupertino.dart';

class Comment{
  int id;
  String? login;
  int book_id;
  String post_time;
  String content;

  Comment({required this.id, required this.login, required this.book_id, required this.post_time, required this.content});
}

