class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final int humidity; // Added humidity field

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.humidity, // Added to constructor
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'], // Extracting humidity
    );
  }
}
