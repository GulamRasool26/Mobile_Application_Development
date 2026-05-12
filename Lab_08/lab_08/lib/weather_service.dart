import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = 'dfbff7546be7949189b4b4afed248bcc';

  //  City to Latitude & Longitude
  Future<Map<String, double>> getLatLon(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/geo/1.0/direct'
      '?q=$city&limit=1&appid=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.isEmpty) {
        throw Exception("City not found");
      }

      return {
        "lat": data[0]["lat"],
        "lon": data[0]["lon"],
      };
    } else {
      throw Exception("Failed to fetch geocoding data");
    }
  }
}