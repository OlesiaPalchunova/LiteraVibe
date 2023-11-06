import 'package:flutter/material.dart';

class TextPlace extends StatelessWidget {
  final String text;

  TextPlace ({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10.0),
        width: 300,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), // Установите радиус углов
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: text,
            fillColor: Colors.mycolor4,
            filled: true,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black, // Желаемый цвет выделения
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), // Устанавливаем радиус границы
            ),
          ),
        ),
      ),
    );
  }
}