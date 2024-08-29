import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/network/weather_api.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherApi _weatherApi = WeatherApi(); // Use final for immutability
  Weather? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    _isLoading = true; // Start loading
    _errorMessage = null;
    notifyListeners();

    try {
      _weather = await _weatherApi.fetchWeather(city);
    } catch (e) {
      _errorMessage =
          "Error fetching weather data: $e"; // Handle errors properly
    } finally {
      _isLoading = false; // Stop loading
      notifyListeners(); // Notify listeners after loading or error
    }
  }
}
