import 'dart:convert';

import 'package:litera_vibe/db/storage/token.dart';

import 'package:http/http.dart' as http;

import '../api/api_field.dart';
import '../models/dropped_file.dart';
import '../models/profile.dart';
import 'auth_db.dart';

class ProfileDB{

  Future tryUpdateProfile({required String userUid, required String displayName, required DroppedFile? imageFile,
    required String info, required String tgLink, required String vkLink}) async {
    String? markJson = await changedProfileToJson(userUid, displayName, imageFile, info, tgLink, vkLink);
    if (markJson == null) {
      return -1;
    }
    var accessToken = await Token.getAccessToken();
    var response = await http.put(Uri.parse("${apiUrl}profile"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: markJson);

    print(response.statusCode);
    print(response.body);
    return response.statusCode;
  }

  Future updateProfile({
    required String userUid, required String displayName, required DroppedFile? imageFile,
    required String info, required String tgLink, required String vkLink}) async {
    var status = await tryUpdateProfile(userUid: userUid, displayName: displayName, imageFile: imageFile,
        info: info, tgLink: tgLink, vkLink: vkLink);
    if (status == 200) return status;

    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) {
        return await tryUpdateProfile(userUid: userUid, displayName: displayName, imageFile: imageFile,
            info: info, tgLink: tgLink, vkLink: vkLink);
      }
      if (status_access == 401) {
        int status_refresh = await Authorization.refreshTokens();
        if (status_refresh == 200) {
          return await tryUpdateProfile(userUid: userUid, displayName: displayName, imageFile: imageFile,
              info: info, tgLink: tgLink, vkLink: vkLink);
        }
      }
    }
    return status;
  }

  Future<String?> changedProfileToJson(String userUid, String displayName, DroppedFile? imageFile, String info, String tgLink, String vkLink) async {

    var imageId = null;
    if (imageFile != null) imageId = await Authorization().sendImage(imageFile);

    Map<String, dynamic> commentDto;
    commentDto = {
      "uid": userUid,
      "display_name": displayName,
      "media_id": imageId,
      "info": info,
      "tg_link": tgLink,
      "vk_link": vkLink,
    };
    var commentJson = jsonEncode(commentDto);
    return commentJson;
  }

  static Future tryUpdatePassword({required String login, required String password}) async {

    String? passwordJson = await changedPasswordToJson(login, password);

    var accessToken = await Token.getAccessToken();
    var response = await http.put(Uri.parse("${apiUrl}profile/password/mobile"),
        headers: {
          'Authorization': 'Bearer $accessToken',
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: passwordJson);
    return response.statusCode;
  }

  static Future updatePassword({
    required String login, required String password}) async {
    var status = await tryUpdatePassword(login: login, password: password);
    if (status == 200) return status;
    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) return await tryUpdatePassword(login: login, password: password);
      if (status_access == 401) {
        int status_refresh = await Authorization.refreshTokens();
        if (status_refresh == 200) return await tryUpdatePassword(login: login, password: password);
      }
    }
    return status;
  }

  static Future<String?> changedPasswordToJson(String login, String password) async {
    Map<String, dynamic> passwordDto;
    passwordDto = {
      "login": login,
      "password": password,
      "display_name": "null",
    };
    var passworJson = jsonEncode(passwordDto);
    return passworJson;
  }

  Future tryGetProfile() async {
    var accessToken = await Token.getAccessToken();
    final Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Custom-Header': 'Custom Value',
    };
    var profileUri = Uri.parse('${apiUrl}profile');
    var response = await http.get(profileUri, headers: headers);
    return response;
  }

  Future getProfile() async {
    var response = await tryGetProfile();
    var status = response.statusCode;
    if (status == 401) {
      int status_access = await Authorization.refreshAccessToken();
      if (status_access == 200) response = await tryGetProfile();
      else if (status_access == 401) {
        int status_refresh = await Authorization.refreshTokens();
        if (status_refresh == 200) response = await tryGetProfile();
      }
    }
    if (response.statusCode == 200){
      var decodedBody = utf8.decode(response.body.codeUnits);
      var profileJson = jsonDecode(decodedBody);

      Profile profile;
      profile = Profile(
        uid: profileJson["uid"],
        display_name: profileJson["display_name"],
        image: profileJson[faceMedia] != null ? getImageUrl(profileJson[faceMedia]) : defaultProfileUrl,
        info: profileJson["info"] ?? " ",
        tg_link: profileJson["tg_link"] ?? " ",
        vk_link: profileJson["vk_link"] ?? " ",
      );

      return profile;
    }
    return null;
  }

  static String getImageUrl(int id) {
    return "${apiUrl}media/$id";
  }
}