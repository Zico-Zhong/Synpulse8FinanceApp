import 'package:http/http.dart' as http;
import 'dart:convert';

class DataRetriever {
  DataRetriever({required this.url});
  late String url;

  void serUrl(String url) {
    this.url = url;
  }

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    }
  }
}
