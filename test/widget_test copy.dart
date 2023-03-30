import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ongkir/app/data/models/user_model.dart';

void main() async {
  Uri url = Uri.parse("https://reqres.in/api/users/2");

  final response = await http.get(url);

  // print(data["first_name"]);

  final user =
      UserModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

  print(user.data!.firstName);
}
