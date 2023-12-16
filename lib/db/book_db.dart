import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:litera_vibe/db/mark_db.dart';
import 'package:litera_vibe/db/storage/token.dart';
import 'package:litera_vibe/models/author.dart';

import '../api/api_field.dart';
import '../models/book.dart';
import 'auth_db.dart';

class BookDB {
  String getImageUrl(int id) {
    return "${apiUrl}media/$id";
  }

  Future<List<Book>> getBooksByName(String name) async {
    var response = await fetchBookSearch(name);
    print(response.statusCode);
    if (response.statusCode != 200) {
      return [];
    }
    var decodedBody = utf8.decode(response.body.codeUnits);
    var recipeJson = jsonDecode(decodedBody);
    print(recipeJson);
    List<Book> books = await booksFromJson(recipeJson);
    return books;
  }

  Future<List<Book>> getBook() async {
    var response = await fetchBook("books");
    print(response.statusCode);
    if (response.statusCode != 200) {
      return [];
    }
    var decodedBody = utf8.decode(response.body.codeUnits);
    var recipeJson = jsonDecode(decodedBody);
    print(recipeJson);
    List<Book> books = await booksFromJson(recipeJson);
    // recipesCache[recipeId] = recipe;
    return books;
  }

  // Future<int> tryGetLikedBook(List<Book> books) async {
  //   var response = await fetchLikedBook();
  //   print("liked");
  //   print(response.statusCode);
  //   if (response.statusCode != 200) return response.statusCode;
  //   var decodedBody = utf8.decode(response.body.codeUnits);
  //   var booksJson = jsonDecode(decodedBody);
  //   books = await booksFromJson(booksJson);
  //   return response.statusCode;
  // }

  Future<List<Book>> getLikedBook() async {
    List<Book> books = [];
    // var content = await tryGetLikedBook(books);
    var response = await fetchBook("books/liked");

    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.body.codeUnits);
      var booksJson = jsonDecode(decodedBody);
      books = await booksFromJson(booksJson);
      return books;
    }

    if (response.statusCode == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) {
        response = await fetchBook("books/liked");
        var decodedBody = utf8.decode(response.body.codeUnits);
        var booksJson = jsonDecode(decodedBody);
        books = await booksFromJson(booksJson);
        return books;
      }
      if (status_access == 401) {
        print("need auth");
      }
    }
    return books;
  }

  Future<List<Book>> getReadBook() async {
    List<Book> books = [];
    // var content = await tryGetLikedBook(books);
    var response = await fetchBook("books/read");

    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.body.codeUnits);
      var booksJson = jsonDecode(decodedBody);
      books = await booksFromJson(booksJson);
      print("books[0].mark");
      print(books[0].mark);
      return books;
    }

    if (response.statusCode == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) {
        response = await fetchBook("books/read");
        var decodedBody = utf8.decode(response.body.codeUnits);
        var booksJson = jsonDecode(decodedBody);
        books = await booksFromJson(booksJson);
        return books;
      }
      if (status_access == 401) {
        print("need auth");
      }
    }
    return books;
  }

  Future<List<Book>> booksFromJson(dynamic booksJson) async {
    List<Book> books = [];
    MarkDB mark = MarkDB();
    for (var b in booksJson) {
      books.add(Book(
        id: b[id],
        name: b[name],
        imageUrl: getImageUrl(b[faceMedia]),
        countPages: b[pages],
        info: b[info],
        authors: authorsFromJson(b[authors]),
        year: b[year],
        publisherId: b[publisherId],
        mark: await mark.getMark(b[id])
      ));
    }
    return books;
  }

  List<Author> authorsFromJson(dynamic authorsJson) {
    List<Author> authors = [];
    for (var a in authorsJson) {
      authors.add(Author(
        firstName: a[firstName],
        secondName: a[secondName],
        imageUrl: a[faceMedia] != null ? getImageUrl(a[faceMedia]) : null,
        info: a[info],
      ));
    }
    return authors;
  }

  Future<http.Response> fetchBookSearch(String name) async {
    final Map<String, String> headers = {
      'Custom-Header': 'Custom Value',
      // Add more custom headers as needed
    };
    var bookUrl = Uri.parse('${apiUrl}books/search/$name');
    return http.get(bookUrl, headers: headers);
  }

  Future<http.Response> fetchBook(String request) async {
    var accessToken = await Token.getAccessToken();
    // print(accessToken);
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Custom-Header': 'Custom Value',
      // Add more custom headers as needed
    };
    // var bookUrl = Uri.parse('${apiUrl}books');
    var bookUrl = Uri.parse('${apiUrl}$request');
    return http.get(bookUrl, headers: headers);
  }

  // Future<http.Response> fetchLikedBook() async {
  //   var accessToken = await Token.getAccessToken();
  //   print(accessToken);
  //   final Map<String, String> headers = {
  //     'Authorization': 'Bearer $accessToken',
  //     'Custom-Header': 'Custom Value',
  //     // Add more custom headers as needed
  //   };
  //   var bookUrl = Uri.parse('${apiUrl}books/liked');
  //   return http.get(bookUrl, headers: headers);
  // }
}