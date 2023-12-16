import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../profile_db.dart';

class UserInfo{
  static String uid = "root";
  static String name = "User";
  static String image = "null";
  static String email = "mail";
  static String? password = "Password";

  static final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future init() async{
    var profile = await ProfileDB().getProfile();

    uid = profile.uid;
    name = profile.display_name;
    image = profile.image;
    email = profile.mail;

    // uid = await storage.read(key: 'uid') ?? "user";
    // name = await storage.read(key: 'name') ?? "name";
    // image = await storage.read(key: 'image') ?? "image";
    // email = await storage.read(key: 'email') ?? "email";
    //
    // password = await storage.read(key: 'password');
    // uid = await storage.read(key: 'uid');
    // name = await storage.read(key: 'name');
    // password = await storage.read(key: 'password');
  }

  static Future addUser(String login, String display_name, String user_password, String email, String image) async {
    print("ooooooooooooo");
    storage.write(key: 'uid', value: login);
    storage.write(key: 'name', value: display_name);
    storage.write(key: 'password', value: user_password);
    storage.write(key: 'email', value: email);
    storage.write(key: 'image', value: image);
    await init();
  }

  static Future getUserUid() {
    return storage.read(key: 'uid');
  }

  static Future getName() {
    return storage.read(key: 'name');
  }

  static Future getPassword() {
    return storage.read(key: 'password');
  }

  static void deleteUid() async {
    await storage.delete(key: 'uid');
    uid = "";
  }

  static void deleteName() async {
    await storage.delete(key: 'name');
    name = "";
  }

  static void deletePassword() async {
    await storage.delete(key: 'password');
    password = "";
  }

  static void deleteAll() async {
    await storage.deleteAll();
  }

}