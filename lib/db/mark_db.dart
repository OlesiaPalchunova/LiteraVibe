import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api/api_field.dart';

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
}