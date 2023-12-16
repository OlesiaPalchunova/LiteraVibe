import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:litera_vibe/db/storage/token.dart';

import '../api/api_field.dart';
import '../models/Note.dart';
import 'auth_db.dart';

class NotesDB {
  Future<int> tryAddNote(int book_id, String login, String content) async{
    var reqBody = {
      "id": 0,
      "login": login,
      "book_id": book_id,
      "content": content
    };

    var accessToken = await Token.getAccessToken();

    var response = await http.post(Uri.parse('${apiUrl}notes'),
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

  Future<int> addNote(int book_id, String login, String content) async {
    var status = await tryAddNote(book_id, login, content);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryAddNote(book_id, login, content);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }

  Future<int> tryUpdateNote(int note_id, int book_id, String login, String content) async{
    var reqBody = {
      "id": note_id,
      "login": login,
      "book_id": book_id,
      "content": content
    };

    var accessToken = await Token.getAccessToken();

    var response = await http.put(Uri.parse('${apiUrl}notes'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reqBody)
    );
    print("put");
    print('{apiUrl}notes');
    print(jsonEncode(reqBody));
    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  Future<int> updateNote(int note_id, int book_id, String login, String content) async {
    var status = await tryUpdateNote(note_id, book_id, login, content);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryUpdateNote(note_id, book_id, login, content);
      if (status_access == 401) {
        print("need auth");
      }
    }
    return status;
  }

  Future<http.Response> fetchNote(int book_id) async {
    var accessToken = await Token.getAccessToken();
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Custom-Header': 'Custom Value',
    };
    return await http.get(Uri.parse('${apiUrl}notes/$book_id'), headers: headers);
    // print("notice");
    // print(response.statusCode);
    // print(response.body);
    // if (response.statusCode == 401) return "401";
    // if (response.statusCode != 200) return "";
    //
    // var decodedBody = utf8.decode(response.body.codeUnits);
    // var markJson = jsonDecode(decodedBody);
    // return markJson["content"];
  }

  Future<Note> getNote(int book_id) async {
    var response = await fetchNote(book_id);

    if (response.statusCode == 200) {
      var decodedBody = utf8.decode(response.body.codeUnits);
      var noteJson = jsonDecode(decodedBody);
      Note note = Note(
        id: noteJson["id"],
        content: noteJson["content"],
      );
      return note;
    }

    if (response.statusCode == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) {
        if (response.statusCode == 200) {
          var decodedBody = utf8.decode(response.body.codeUnits);
          var noteJson = jsonDecode(decodedBody);
          Note note = Note(
            id: noteJson["id"],
            content: noteJson["content"],
          );
          return note;
        }
      }
      if (status_access == 401) {
        print("need auth");
      }
    }
    return Note(id: 0, content: "");
  }
}