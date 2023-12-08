import 'package:http/http.dart' as http;
import 'package:litera_vibe/db/storage/token.dart';
import 'package:litera_vibe/db/storage/user_info.dart';
import 'dart:convert';
import '../api/api_field.dart';
import '../models/dropped_file.dart';

class Authorization {

  final Token token = Token();

  static Future loginUser(String nickname, String password) async{

    var reqBody = {
      "login":nickname,
      "password":password,
    };

    var response = await http.post(Uri.parse('${apiUrl}login/mobile'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody)
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var accessToken = jsonResponse["accessToken"];
      var refreshToken = jsonResponse["refreshToken"];

      await Token.setAccessToken(accessToken);
      await Token.setRefreshToken(refreshToken);

      await UserInfo.addUser(nickname, "user", password, "", "");
    }

    return response.statusCode;
  }

  static Future registerUser(String nickname, String password, String displayName, String email, String image) async{

    var reqBody = {
      "login": nickname,
      "password": password,
      "display_name": displayName,
      "email": email,
      "media_id": image,
    };

    var response = await http.post(Uri.parse('${apiUrl}registration/mobile'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody)
    );

    print(response.statusCode);
    print(response.body);
    print(jsonEncode(reqBody));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var accessToken = jsonResponse["accessToken"];
      var refreshToken = jsonResponse["refreshToken"];


      await Token.setAccessToken(accessToken);
      await Token.setRefreshToken(refreshToken);
      await UserInfo.addUser(nickname, displayName, password, email, image);
      // UserInfo.addUser(nickname, displayName, password);
    }

    return response.statusCode;
  }

  static Future refreshTokens() async{
    String oldRefreshToken = await Token.getRefreshToken();

    var reqBody = {
      "refreshToken": oldRefreshToken,
    };

    var response = await http.post(Uri.parse('${apiUrl}auth/refresh/mobile'),
        headers: {
          "Content-Type": "application/json"},
        body: jsonEncode(reqBody)
    );
    print(response.statusCode);
    print(response.body);


    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var accessToken = jsonResponse["accessToken"];
      var refreshToken = jsonResponse["refreshToken"];

      Token.setAccessToken(accessToken);
      Token.setRefreshToken(refreshToken);

    } else {
      print("555555555555555555");
    }

    return response.statusCode;
  }

  static Future refreshAccessToken() async {

    String oldRefreshToken = await Token.getRefreshToken() ?? " ";

    var reqBody = {
      "refreshToken": oldRefreshToken,
    };

    final response = await http.post(
        Uri.parse('${apiUrl}auth/token'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody)
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      String newAccessToken = responseData['accessToken'];
      Token.setAccessToken(newAccessToken);
    }
    return response.statusCode;
  }

  Future<int> sendImage(DroppedFile file) async {
    print(file.mime);
    print(file.size.toString());
    print(file.bytes);
    var accessToken = await Token.getAccessToken();
    var response = await http.post(
      Uri.parse('${apiUrl}media'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        "Content-Type": file.mime,
        "Content-Length": file.size.toString()
      },
      body: file.bytes,
    );
    if (response.statusCode != 200) {
      print(response.body);
      print(response.statusCode);

      return -1;
    }
    var idJson = jsonDecode(response.body);
    print("ID JSON: $idJson");
    int? imageId = idJson[id];
    if (imageId == null) {
      return -1;
    }
    return imageId;
  }

}