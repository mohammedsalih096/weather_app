import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:task1/constants.dart' as k;

class WeatherService {
  Future<Map<String, dynamic>?> getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        "${k.apiPath}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}";
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      return decodeData;
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
