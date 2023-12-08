import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:litera_vibe/db/storage/user_info.dart';


class Token{
  static final FlutterSecureStorage storage = FlutterSecureStorage();
  static bool is_token = false;

  static void init() async{
    if (await storage.containsKey(key: 'access_token')) is_token = true;
  }

  static bool isToken(){
    print(is_token);
    return is_token;
  }

  static Future<void> setAccessToken(String newAccessToken) async {
    await storage.write(key: 'access_token', value: newAccessToken);
    is_token = true;
    print(33333333333);
  }

  static Future setRefreshToken(String newRefreshToken) async {
    await storage.write(key: 'refresh_token', value: newRefreshToken);
  }

  static Future getAccessToken() async {
    return await storage.read(key: 'access_token');
  }

  static Future getRefreshToken() async {
    return await storage.read(key: 'refresh_token');
  }

  static void deleteAccessToken() async {
    await storage.delete(key: 'access_token');
    is_token = false;
    UserInfo.deleteUid();
    UserInfo.deleteName();
    UserInfo.deletePassword();
  }

  static void deleteRefreshToken() async {
    await storage.delete(key: 'refresh_token');
  }

  Future deleteAll() async {
    await storage.deleteAll();
    is_token = false;
  }

}