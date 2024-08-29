import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherApi {
  final http.Client client = http.Client();
  final String baseUrl = 'api.openweathermap.org';
  final String apiKey = 'bf40ad3b431216b9cf9ee42f8d329d96';

  Future<Weather> fetchWeather(String city) async {
    try {
      final uri = Uri.https(
        baseUrl,
        '/data/2.5/weather',
        {
          'q': city,
          'appid': apiKey,
          'units': 'metric' // Add 'units' if you want temperature in Celsius
        },
      );

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
      throw Exception("Error fetching weather data");
    }
  }
}
