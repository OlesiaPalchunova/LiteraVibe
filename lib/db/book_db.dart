import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:litera_vibe/db/mark_db.dart';
import 'package:litera_vibe/db/storage/token.dart';
import 'package:litera_vibe/models/author.dart';

import '../api/api_field.dart';
import '../models/book.dart';

class BookDB {
  String getImageUrl(int id) {
    return "${apiUrl}media/$id";
  }

  Future<List<Book>> getBook() async {

    // if (recipesCache.containsKey(recipeId)) {
    //   return recipesCache[recipeId];
    // }
    var response = await fetchBook();
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

  Future<List<Book>> booksFromJson(dynamic booksJson) async {
    List<Book> books = [];
    MarkDB mark = MarkDB();
    for (var b in booksJson) {
      print(getImageUrl(b[faceMedia]));
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

  Future<http.Response> fetchBook() async {
    var accessToken = await Token.getAccessToken();
    print(accessToken);
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Custom-Header': 'Custom Value',
      // Add more custom headers as needed
    };
    var bookUrl = Uri.parse('${apiUrl}books');
    return http.get(bookUrl, headers: headers);
  }
}