import 'package:flutter/material.dart';
import 'package:litera_vibe/db/commentDB.dart';
import 'package:litera_vibe/models/stars.dart';

import '../db/storage/user_info.dart';
import '../style.dart';
import 'comment.dart';

class CommentModel extends StatefulWidget {
  Comment comment;
  void Function() onDelete;

  CommentModel({required this.comment, required this.onDelete});

  @override
  State<CommentModel> createState() => _CommentModelState();
}

class _CommentModelState extends State<CommentModel> {
  int count_stars = 5;
  bool isMyComment = false;
  bool isEditing = false;
  Comment get comment => widget.comment;
  void Function() get onDelete => widget.onDelete;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    isMyComment = comment.login == UserInfo.uid;
    controller.text = widget.comment.content;
    super.initState();
  }

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
                    width: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.comment.login != null ? '@${widget.comment.login}' : 'user_${widget.comment.id}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Row(
                            children: [
                              Stars(stars_count: count_stars),
                              isMyComment
                                ? Container(
                                  width: 30,
                                  height: 30,
                                  child: PopupMenuButton<int>(
                                    onSelected: (value) async {
                                      if (value == 1) {
                                        setState(() {
                                          isEditing = true;
                                        });
                                      } else {
                                        await CommentDB().deleteComment(comment);
                                        onDelete();
                                      }
                                    },
                                    itemBuilder: (context) => [
                                      const PopupMenuItem(
                                        value: 1,
                                        child: Text('Изменить'),
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Text('Удалить'),
                                      ),
                                    ],
                                    icon: Icon(Icons.more_vert),
                                  )
                                )
                                : SizedBox(width: 30,)
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                  Container(
                      width: 270,
                      child: isEditing ?
                          Column(
                            children: [
                              TextField(
                                controller: controller,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      comment.content = controller.text;
                                      CommentDB().editComment(comment);
                                      setState(() {
                                        isEditing = false;
                                      });
                                    },
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all<Size>(Size(60, 35)),
                                    ),
                                    child: Text(
                                      "Изменить",
                                      style: TextStyle(
                                        color: Colors.mycolor1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditing = false;
                                      });
                                    },
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all<Size>(Size(60, 35)),
                                    ),
                                    child: Text(
                                      "Вернуться",
                                      style: TextStyle(
                                        color: Colors.mycolor1,
                                      ),
                                    ),
                                  ),

                                ],
                              )
                            ],
                          )
                      : Text(
                          widget.comment.content
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

  Widget onChange(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: (value) {
        // Действие при выборе элемента из меню
        print('Выбран пункт меню: $value');
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text('Элемент 1'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('Элемент 2'),
        ),
        PopupMenuItem(
          value: 3,
          child: Text('Элемент 3'),
        ),
      ],
      icon: Padding(
        padding: EdgeInsets.all(2.0), // Регулирование отступов вокруг иконки
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
