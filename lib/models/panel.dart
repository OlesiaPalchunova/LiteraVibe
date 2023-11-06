import 'package:flutter/material.dart';

class Panel extends StatefulWidget {
  int currentIndex;

  Panel({required this.currentIndex});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      onTap: (index) {
        setState(() {
          widget.currentIndex = index;
        });
      },
      backgroundColor: Colors.mycolor0,
      selectedItemColor: Colors.mycolor5,
      unselectedItemColor: Colors.mycolor4,

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_outlined),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Понравившиеся',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Профиль',
        ),
      ],
    );
  }
}
