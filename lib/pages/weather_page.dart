import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
// api key

  final _weatherService = WeatherServices('68f44b107937641cdd955e3b4072439c');
  Weather? _weather;

// fetch weather

  _fetchWeather() async {
    // get weather current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

// weather animations

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/showe.json';
      case 'thunder':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

// initial state
  @override
  void initState() {
    super.initState();

    // fetch weather

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 133, 132, 132),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _weather?.cityName ?? "loading city...",
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 23, 23, 23),
                ),
              ),

              // animation
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

              Text(
                '${_weather?.temperature.round()}°C',
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 18, 18, 18),
                ),
              ),

              // weather condition
              Text(
                _weather?.mainCondition ?? "",
                style: const TextStyle(
                  fontSize: 40,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
        ));
  }
}
