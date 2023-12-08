import 'package:flutter/material.dart';
import 'package:litera_vibe/models/author.dart';

class Book {
  int id;
  String name;
  String imageUrl;
  int countPages;
  String info;
  List<Author> authors;
  int? year;
  int publisherId;
  double mark;

  Book({required this.id, required this.name, required this.imageUrl, required this.countPages,
    required this.info, required this.authors, required this.year, required this.publisherId, required this.mark});
}
