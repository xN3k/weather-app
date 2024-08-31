import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/widgets/weather_animation.dart';

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
            icon: Icon(
              themeProvider.isDarkTheme
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Wrap Column in SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Search City',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    weatherProvider.fetchWeather(value);
                  }
                },
              ),
              const SizedBox(height: 40),
              if (weatherProvider.isLoading)
                const CircularProgressIndicator()
              else if (weatherProvider.errorMessage != null)
                Text(
                  weatherProvider.errorMessage!,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                )
              else if (weatherProvider.weather != null)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      weatherProvider.weather!.city,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 20),
                    Lottie.asset(
                        weatherAnimation(weatherProvider.weather!.condition)),
                    const SizedBox(height: 40),
                    Text(
                      '${weatherProvider.weather!.temperature}°C',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      'Weather: ${weatherProvider.weather!.condition}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                )
              else
                Text(
                  'No City Selected',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
