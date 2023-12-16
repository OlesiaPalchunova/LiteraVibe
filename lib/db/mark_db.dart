import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:litera_vibe/db/storage/token.dart';

import '../api/api_field.dart';
import 'auth_db.dart';

class MarkDB {

  Future<double> getMark(int id) async {
    final Map<String, String> headers = {
      'Custom-Header': 'Custom Value',
    };
    var response = await http.get(Uri.parse('${apiUrl}marks/$id'), headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode != 200) return -1;

    var decodedBody = utf8.decode(response.body.codeUnits);
    var markJson = jsonDecode(decodedBody);
    return markJson;
  }


  Future<int> tryGetUserMark(int book_id, String login) async {
    var accessToken = await Token.getAccessToken();
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Custom-Header': 'Custom Value',
    };
    var response = await http.get(Uri.parse('${apiUrl}marks?book_id=$book_id&login=$login'), headers: headers);
    print('${apiUrl}marks?book_id=$book_id&login=$login');
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 404) return 0;
    if (response.statusCode != 200) return -1;

    var decodedBody = utf8.decode(response.body.codeUnits);
    var markJson = jsonDecode(decodedBody);
    return markJson["mark"];
  }

  Future<int> getUserMark(int book_id, String login) async {
    var mark = await tryGetUserMark(book_id, login);

    if (mark != -1 && mark != 0) return mark;

    if (mark == 0) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryGetUserMark(book_id, login);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return mark;
  }

  Future<int> tryAddUserMark(int book_id, String login, int mark) async{
    var reqBody = {
      "login": login,
      "book_id": book_id,
      "mark": mark
    };

    print(jsonEncode(reqBody));

    var accessToken = await Token.getAccessToken();

    var response = await http.post(Uri.parse('${apiUrl}marks'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reqBody)
    );
    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> addUserMark(int book_id, String login, int mark) async {
    var status = await tryAddUserMark(book_id, login, mark);

    if (status == 200) return mark;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryAddUserMark(book_id, login, mark);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return mark;
  }

  Future<int> tryUpdateUserMark(int book_id, String login, int mark) async{
    print("mark: $mark");
    print("mark: $login");
    var reqBody = {
      "login": login,
      "book_id": book_id,
      "mark": mark
    };

    var accessToken = await Token.getAccessToken();

    var response = await http.put(Uri.parse('${apiUrl}marks'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reqBody)
    );
    print("update");
    print('${apiUrl}marks');
    print(jsonEncode(reqBody));
    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> updateUserMark(int book_id, String login, int mark) async {
    var status = await tryUpdateUserMark(book_id, login, mark);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryUpdateUserMark(book_id, login, mark);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }

  Future<int> tryDeleteUserMark(int book_id, String login) async{
    var accessToken = await Token.getAccessToken();

    var response = await http.delete(Uri.parse('${apiUrl}marks?book_id=$book_id&login=$login'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    print("delete mark");
    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> deleteUserMark(int book_id, String login) async {
    var status = await tryDeleteUserMark(book_id, login);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryDeleteUserMark(book_id, login);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }
}