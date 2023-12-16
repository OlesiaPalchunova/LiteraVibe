import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:litera_vibe/db/storage/token.dart';
import '../api/api_field.dart';
import '../models/comment.dart';
import 'auth_db.dart';

class CommentDB {
  Future<List<Comment>> getComments(int id) async {
    final Map<String, String> headers = {
      'Custom-Header': 'Custom Value',
    };
    var commentUrl = Uri.parse('${apiUrl}comments/$id');

    var response = await http.get(commentUrl, headers: headers);

    print("comments");
    print(response.statusCode);
    if (response.statusCode != 200) {
      return [];
    }
    var decodedBody = utf8.decode(response.body.codeUnits);
    var commentsJson = jsonDecode(decodedBody);
    print("((((commentsJson))))");
    print(commentsJson);
    List<Comment> comments = await commentsFromJson(commentsJson);
    // recipesCache[recipeId] = recipe;
    return comments;
  }

  Future<List<Comment>> commentsFromJson(dynamic commentsJson) async {
    List<Comment> comments = [];
    for (var c in commentsJson) {
      comments.add(Comment(
          id: c[id],
          login: c[login],
          book_id: c[bookId],
          post_time: c[postTime] ?? "999",
          content: c[content]
      ));
    }
    return comments;
  }

  Future<int> tryAddComment(Comment comment) async{
    print("(((comment.login)))");
    print(comment.login);
    var reqBody = {
      "id": comment.id,
      "login": comment.login,
      "book_id": comment.book_id,
      // "post_time": comment.post_time,
      "post_time": "2017-07-21T17:32:28Z",
      "content": comment.content
    };

    var accessToken = await Token.getAccessToken();

    var response = await http.post(Uri.parse('${apiUrl}comments?id=${comment.book_id}'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reqBody)
    );
    print(response.body);
    print(response.statusCode);

    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //   var accessToken = jsonResponse["accessToken"];
    //   var refreshToken = jsonResponse["refreshToken"];
    //
    //   Token.setAccessToken(accessToken);
    //   Token.setRefreshToken(refreshToken);
    //
    //   UserInfo.addUser(nickname, "user", password);
    // }

    return response.statusCode;
  }

  Future addComment(Comment comment) async {
    var status = await tryAddComment(comment);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryAddComment(comment);
      if (status_access == 401) {
        print("need auth");
        // int status_refresh = await Authorization.refreshTokens();
        // if (status_refresh == 200) return await tryAddComment(comment);
      }
    }
    return status;
  }

  Future<int> tryEditComment(Comment comment) async{
    print("(((comment.login)))");
    print(comment.login);
    var reqBody = {
      "id": comment.id,
      "login": comment.login,
      "book_id": comment.book_id,
      // "post_time": comment.post_time,
      "post_time": "2017-07-21T17:32:28Z",
      "content": comment.content
    };

    var accessToken = await Token.getAccessToken();

    var response = await http.put(Uri.parse('${apiUrl}comments?book_id=${comment.book_id}&comment_id=${comment.id}'),
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

  Future editComment(Comment comment) async {
    var status = await tryEditComment(comment);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryEditComment(comment);
      if (status_access == 401) {
        print("need auth");
        // int status_refresh = await Authorization.refreshTokens();
        // if (status_refresh == 200) return await tryAddComment(comment);
      }
    }
    return status;
  }

  Future<int> tryDeleteComment(Comment comment) async{
    print("(((comment.login)))");
    print(comment.login);
    var reqBody = {
      "id": comment.id,
      "login": comment.login,
      "book_id": comment.book_id,
      // "post_time": comment.post_time,
      "post_time": "2017-07-21T17:32:28Z",
      "content": comment.content
    };

    var accessToken = await Token.getAccessToken();

    var response = await http.delete(Uri.parse('${apiUrl}comments/${comment.id}'),
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

  Future deleteComment(Comment comment) async {
    var status = await tryDeleteComment(comment);

    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryDeleteComment(comment);
      if (status_access == 401) {
        print("need auth");
        // int status_refresh = await Authorization.refreshTokens();
        // if (status_refresh == 200) return await tryAddComment(comment);
      }
    }
    return status;
  }

}