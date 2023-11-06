import 'package:flutter/material.dart';
import 'package:litera_vibe/profile/user_page.dart';
import 'package:litera_vibe/reading_book.dart';
import 'package:litera_vibe/style.dart';
import '../home/home_page.dart';
import 'book_page.dart';
import 'favorite/favorite_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // MaterialApp(
  //   routes: {
  //   '/your_route_name': (context) => YourNextPage()
  //   // Define other routes here
  //   },
  // // The rest of your app configuration
  // )

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    // BookPage(),
    FavoritePage(),
    // LoginPage(),
    UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/book_page': (context) => BookPage(),
        '/reading_book': (context) => ReadingBook(),
      },
      title: 'LiteraVibe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.mycolor1,
        appBar: AppBar(
          backgroundColor: Colors.mycolor0,
          title: Text('LiteraVibe', style: TextStyle(color: Colors.mycolor5, fontFamily: font),),
          centerTitle: true,
        ),
        body:_pages[_currentIndex],
        bottomNavigationBar: Panel(context)
      ),
    );
  }

  Widget Panel(BuildContext context){
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
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

