import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../const/colors.dart';
import '../const/text_style.dart';
import '../data/location_service.dart';
import '../data/service_weather.dart';
import '../widgets/search.dart';
import '../data/weather_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _weatherService = WeatherService();
  final _locationService = LocationService();
  Position? _position;
  DateTime _date = DateTime.now();
  String? _city = '';
  String? _icon = '';
  String _description = '';
  double _temp = 0;
  double _feelsLike = 0;
  double _minTemp = 0;
  double _maxTemp = 0;
  double _wind = 0;
  int _pressure = 0;
  int _humidity = 0;
  DateTime _sunset = DateTime.now();
  DateTime _sunrise = DateTime.now();

  @override
  void initState() {
    setState(() {
      _getCurrentPositionAndWeather();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/weather.jpeg"),
                    fit: BoxFit.cover),
              ),
              child: _content),
        ),
      ),
    );
  }

  Widget get _content => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchForm(onSearch: _changeCity),
              Text(
                _city!,
                style: titleStyle,
              ),
              if (_city != "")
                Text(
                  DateFormat.MMMMEEEEd().format(_date),
                  style: const TextStyle(fontSize: 16, color: textColor),
                ),
              const SizedBox(height: 15),
              Text(
                _description,
                style: const TextStyle(fontSize: 15, color: textColor),
              ),
              const SizedBox(height: 10),
              WeatherData(
                temp: _temp,
                iconCode: _icon,
                date: _date,
                minTemp: _minTemp,
                maxTemp: _maxTemp,
                title: '',
                feelsLike: _feelsLike,
                pressure: _pressure,
                humidity: _humidity,
                wind: _wind,
                description: _description,
                sunset: _sunset,
                sunrise: _sunrise,
              ),
            ],
          ),
        ),
      );

  void _changeCity(String city) async {
    final dataDecoded = await _weatherService.getWeatherByName(city);
    _updateData(dataDecoded);
    setState(() {
      _city = city;
    });
  }

  Future<void> _getCurrentPositionAndWeather() async {
    await _getCurrentPosition();
    await _getCityAndWeatherFromLatLong();
  }

  Future<void> _getCurrentPosition() async {
    try {
      final position = await _locationService.getCurrentPosition();
      setState(() {
        _position = position;
      });
    } catch (e) {
      print('Current position is not available now');
      _changeCity('Haifa');
    }
  }

  Future<void> _getCityAndWeatherFromLatLong() async {
    if (_position == null) return;
    try {
      final place = await _locationService.getPlace(_position!);
      //get weather info
      final dataDecoded = await _weatherService.getWeatherByCoord(_position!);
      _updateData(dataDecoded);
      setState(() {
        _city = place.locality ?? '';
      });
    } catch (e) {
      print(e);
    }
  }

  void _updateData(weatherData) {
    setState(() {
      if (weatherData != null) {
        _temp = weatherData['main']['temp'];
        _icon = weatherData['weather'][0]['icon'];
        _feelsLike = weatherData['main']['feels_like'];
        _description = weatherData['weather'][0]['description'].toString();
        _date =
            DateTime.fromMillisecondsSinceEpoch(weatherData['dt'] * 1000);
        _minTemp = weatherData['main']['temp_min'];
        _maxTemp = weatherData['main']['temp_max'];
        _pressure = weatherData['main']["pressure"];
        _humidity = weatherData['main']["humidity"];
        _wind = weatherData['wind']['speed'];
        _sunset = DateTime.fromMillisecondsSinceEpoch(
            weatherData['sys']['sunset'] * 1000);
        _sunrise = DateTime.fromMillisecondsSinceEpoch(
            weatherData['sys']['sunrise'] * 1000);
      } else {
        _temp = 0;
        _city = 'In the middle of nowhere';
        _icon = '0';
      }
    });
  }
}
