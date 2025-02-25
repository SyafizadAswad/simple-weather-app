import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('7c6c708450c569ddc36d2731d2c97a5e');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/cloudy.json';
      case 'mist':
        return 'assets/cloudy.json';
      case 'smoke':
        return 'assets/cloudy.json';
      case 'haze':
        return 'assets/cloudy.json';
      case 'dust':
        return 'assets/cloudy.json';
      case 'fog':
        return 'assets/cloudy.json';
      case 'snow':
        return 'assets/snowy.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'drizzle':
        return 'assets/rainy.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'shower rain':
        return 'assets/rainy.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Color.fromARGB(255, 255, 114, 114),
              size: 40,
            ),
            Text(
              _weather?.cityName ?? "Loading city..",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              "${_weather?.temperature.round()}°C",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
