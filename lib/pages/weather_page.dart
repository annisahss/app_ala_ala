import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(
    apiKey: 'b38484b8aab97fe2666f840aafb3c191',
  );
  Weather? _weather;

  _fetchWeatherData() async {
    try {
      final Position positioned = await _weatherService.getPosition();
      String latitude = positioned.latitude.toString();
      String longitude = positioned.longitude.toString();
      final Weather weather = await _weatherService.getWeather(
        latitude: latitude,
        longitude: longitude,
      );
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
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? 'Loading city...',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            Text(
              _weather != null
                  ? '${(_weather!.temperature - 273.15).toStringAsFixed(1)}°C'
                  : 'Loading temperature...',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
            ),

            Text(
              _weather?.mainCondition ?? "",
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),

            // Displaying Humidity
            Text(
              _weather != null
                  ? 'Humidity: ${_weather!.humidity}%'
                  : 'Loading humidity...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
