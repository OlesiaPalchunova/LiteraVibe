import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:litera_vibe/db/storage/token.dart';

import '../api/api_field.dart';
import '../models/collection.dart';
import 'auth_db.dart';

class CollectionsDB {
  Future<int> tryGetCollections(int login, List<Collection> collections) async {
    var accessToken = await Token.getAccessToken();
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Custom-Header': 'Custom Value',
    };
    var response = await http.get(Uri.parse('${apiUrl}collections/$login'), headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) return response.statusCode;

    var decodedBody = utf8.decode(response.body.codeUnits);
    var collectionsJson = jsonDecode(decodedBody);

    for (var collectionJson in collectionsJson) {
      collections.add(
        Collection(id: collectionJson["id"], name: collectionJson["name"])
      );
    }
    return response.statusCode;
  }

  Future<int> getCollections(int login, List<Collection> collections) async {
    var status = await tryGetCollections(login, collections);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryGetCollections(login, collections);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }

  Future<int> tryLikeBook(int book_id) async{

    var accessToken = await Token.getAccessToken();

    var response = await http.post(Uri.parse('${apiUrl}collections/liked?book_id=$book_id'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    print("likes");
    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> likeBook(int book_id) async {
    var status = await tryLikeBook(book_id);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryLikeBook(book_id);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }

  Future<int> tryDeleteLikedBook(int book_id) async{

    var accessToken = await Token.getAccessToken();

    var response = await http.delete(Uri.parse('${apiUrl}collections/liked?book_id=$book_id'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    print("delete_likes");
    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> deleteLikedBook(int book_id) async {
    var status = await tryDeleteLikedBook(book_id);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryDeleteLikedBook(book_id);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }

  Future<int> tryReadBook(int book_id) async{

    var accessToken = await Token.getAccessToken();

    var response = await http.post(Uri.parse('${apiUrl}collections/read?book_id=$book_id'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    print("read");
    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> readBook(int book_id) async {
    var status = await tryReadBook(book_id);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryReadBook(book_id);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }

  Future<int> tryDeleteReadBook(int book_id) async{

    var accessToken = await Token.getAccessToken();

    var response = await http.delete(Uri.parse('${apiUrl}collections/read?book_id=$book_id'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    print("delete_read");
    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> deleteReadBook(int book_id) async {
    var status = await tryDeleteReadBook(book_id);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryDeleteReadBook(book_id);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }
}