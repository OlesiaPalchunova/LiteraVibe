import 'package:flutter/material.dart';
import 'package:litera_vibe/models/stars.dart';

import '../style.dart';

class CommentModel extends StatefulWidget {
  int count_stars;
  String login;
  String profile_url;
  String content;

  CommentModel({required this.count_stars, required this.login, required this.profile_url, required this.content});

  @override
  State<CommentModel> createState() => _CommentModelState();
}

class _CommentModelState extends State<CommentModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        // height: 70,
        decoration: BoxDecoration(
          color: Colors.mycolor4,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.account_circle,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Container(
                    width: 220,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '@${widget.login}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Stars(stars_count: widget.count_stars, isDark: true,),
                      ],
                    ),
                  ),
                  Container(
                      width: 220,
                      child: Text(
                          widget.content
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
