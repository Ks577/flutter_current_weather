import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../const/components_style.dart';

class WeatherData extends StatelessWidget {
  final DateTime? date;
  final String? title;
  final String? iconCode;
  final String description;
  final double temp;
  final double feelsLike;
  final double minTemp;
  final double maxTemp;
  final double wind;
  final int pressure;
  final int humidity;
  final DateTime sunset;
  final DateTime sunrise;

  const WeatherData({
    Key? key,
    required this.title,
    required this.temp,
    required this.iconCode,
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.wind,
    required this.description,
    required this.sunset,
    required this.sunrise,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        bigContainer(
            '$temp°',
            "http://openweathermap.org/img/wn/$iconCode@4x.png",
            'Feels like $feelsLike°',
            '⇩$minTemp°',
            '⇧$maxTemp°'),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            smallContainer('🌬\n$wind\nm/s'),
            smallContainer('hPa\n$pressure'),
            smallContainer(
              '💧\n$humidity%',
            ),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sunContainer(
              DateFormat.j().format(sunrise),
              DateFormat.j().format(sunset),
            ),
          ],
        ),
      ],
    );
  }
}
