import 'package:flutter/material.dart';

import '../models/post.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 15, bottom: 10),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.mycolor4,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.mycolor0,
                        size: 40,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Поиск книги',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
          Container(
            height: 550,
            child: CustomScrollView(
              slivers: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => Post()
                  ),
                ),
              ]

            )
            ),
        ],
      ),
    );
  }
}