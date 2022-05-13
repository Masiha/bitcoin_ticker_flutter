import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future<String> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      // Converting jsonData
      var decodedData = jsonDecode(data);
      double lastPrice = decodedData['rate'];
      // Round and convert a double to String
      return lastPrice.round().toString();
    } else {
      // Handle any errors that occur during the request.
      print(response.statusCode);
      throw 'Problem with the get request. Status code: ${response.statusCode}';
    }
  }
}
