import 'package:geolocator/geolocator.dart';
import 'fetch_helper.dart';

class WeatherService {
  Future<dynamic> getWeatherByCoord(Position position) async {
    final lat = position.latitude;
    final lon = position.longitude;
    FetchHelper fetchData = FetchHelper(parameters: 'lat=$lat&lon=$lon');
    var decodedData = await fetchData.getData();
    return decodedData;
  }

  Future<dynamic> getWeatherByName(String cityName) async {
    FetchHelper fetchData = FetchHelper(parameters: 'q=$cityName');
    var decodedData = await fetchData.getData();
    return decodedData;
  }
}
