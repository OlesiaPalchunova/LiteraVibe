import 'package:flutter/material.dart';
import 'package:litera_vibe/style.dart';

class ReadingBook extends StatefulWidget {
  const ReadingBook({super.key});

  @override
  State<ReadingBook> createState() => _ReadingBookState();
}

class _ReadingBookState extends State<ReadingBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.mycolor1,
      appBar: AppBar(
        backgroundColor: Colors.mycolor0,
        title: Text('LiteraVibe', style: TextStyle(color: Colors.mycolor5, fontFamily: font),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 650,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Название',
                      style: TextStyle(
                        color: Colors.mycolor5,
                        fontSize: 30
                      ),
                    ),
                  ),
                  Text(
                      'dfvdfvdv sefvd sdf',
                    style: TextStyle(
                        color: Colors.mycolor5,
                        fontSize: 15
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Row(
              children: [
                SizedBox(width: 140,),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_back_ios, color: Colors.mycolor4,)
                ),
                Text(' 3 ', style: TextStyle(color: Colors.mycolor4,),),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_forward_ios_rounded, color: Colors.mycolor4,)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
