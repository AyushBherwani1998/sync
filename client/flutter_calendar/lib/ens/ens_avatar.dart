import 'dart:convert';

import 'package:http/http.dart' as http;

mixin EnsAvatar {
  static Future<String?> getENSAvatar(String ens) async {
    var response = await http.get(
      Uri.parse('http://34.125.213.154:8000/get_avatar/$ens'),
    );

    int statusCode = response.statusCode;

    if (statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['data']['uri']?.toString();
    } else {
      return null;
    }
  }
}
