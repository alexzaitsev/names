import 'dart:convert';
import 'package:http/http.dart' as http;
import '../keys.dart';
import '../model/name.dart';

Future<List<Name>> fetchNames() async {
  final response = await http.get(Uri.parse(googleScriptURL));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body).toList().map((json) => Name.fromJson(json)).toList().cast<Name>();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load names');
  }
}
