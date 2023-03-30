import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

  final response = await http.get(url, headers: {
    'key': '3f7e1ce98f309f0acc807d018a341f48',
  });

  print(response.body);
}
