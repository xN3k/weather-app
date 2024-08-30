import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search City',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) => weatherProvider.fetchWeather(value),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          if (weatherProvider.isLoading)
            const CircularProgressIndicator()
          else if (weatherProvider.errorMessage != null)
            Text(weatherProvider.errorMessage!)
          else if (weatherProvider.weather != null)
            Column(
              children: [
                Text(weatherProvider.weather!.city),
                Lottie.asset('assets/animations/sunny.json'),
                Text('Temperature: ${weatherProvider.weather!.temperature}°C'),
                Text('Weather: ${weatherProvider.weather!.condition}'),
              ],
            )
          else
            Text('Enter a city to get weather data'),
        ],
      ),
    );
  }
}
