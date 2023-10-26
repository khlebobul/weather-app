import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';

import '../models/weather_models.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
// api key

  final _weatherService = WeatherServices('23474f85c62936815d08f2d30942d65e');
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
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_weather?.cityName ?? "loading city..."),
        Text(
          '${_weather?.temperature.round()}C',
        )
      ],
    ));
  }
}
