import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_connect.dart';

class WeatherApiService extends GetConnect {
  factory WeatherApiService() {
    return _instance;
  }

  WeatherApiService._internal() {
    httpClient.baseUrl =
        'https://pro.openweathermap.org/data/2.5/forecast/hourly';
    httpClient.timeout = Duration(seconds: 20);
  }

  static final WeatherApiService _instance = WeatherApiService._internal();

  Future<Response?> getWeatherData(String lat, String lon) async {
    print('Getting weather data');
    String apiKey;
    if (dotenv.isInitialized) {
      apiKey = dotenv.env['WEATHER_API_KEY'].toString();
    } else {
      await dotenv.load(fileName: '.env');
      apiKey = dotenv.env['WEATHER_API_KEY'].toString();
    }
    print('API Key: $apiKey');
    // ?lat={lat}&lon={lon}&appid={API key}
    try {
      final response = await get(
        '?lat=$lat&lon=$lon&appid=f79a047bec8d8b877d482a3cbc9aa86d',
      );
      return _handleResponse(response);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Response? _handleResponse(Response response) {
    if (response.isOk) {
      print('Response: ${response.body}');
      return response;
    } else {
      print('Error: ${response.body}');
      return null;
    }
  }
}
