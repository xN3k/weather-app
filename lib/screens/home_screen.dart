import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final weatherProvider = Provider.of<WeatherProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherApp'),
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: themeProvider.isDarkTheme
                ? const Icon(Icons.light_mode_outlined)
                : const Icon(Icons.dark_mode_outlined),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Enter City",
              ),
              onSubmitted: (value) => weatherProvider.fetchWeather(value),
            ),
            const SizedBox(height: 20),
            if (weatherProvider.isLoading)
              const CircularProgressIndicator()
            else if (weatherProvider.errorMessage != null)
              Text(weatherProvider.errorMessage!)
            else if (weatherProvider.weather != null)
              Column(
                children: [
                  Text('City: ${weatherProvider.weather!.city}'),
                  Text('Temperature: ${weatherProvider.weather!.condition}°C'),
                  Text('Description: ${weatherProvider.weather!.temperature}'),
                ],
              )
            else
              const Text('Enter a city to get weather data'),
          ],
        ),
      ),
    );
  }
}
