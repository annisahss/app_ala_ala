import 'package:flutter/gestures.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/";
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather({required String? longitude,
    required String? latitude}) async {
    final url = "weather?lat=$latitude&lon=$longitude&appid=b38484b8aab97fe2666f840aafb3c191";
    final response = await http.get(Uri.parse(BASE_URL+url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Position> getPosition() async {
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );


 

    //extract the city name from the first placemarks

    return position;
  }
}
