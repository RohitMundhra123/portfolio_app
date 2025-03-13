import 'package:flutter/material.dart';
import 'package:my_portfolio/services/weather_api_services.dart';
import 'package:my_portfolio/utils/widgets/appbar_widget.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Widget _body() {
    return Container();
  }

  final WeatherApiService _weatherApiService = WeatherApiService();
  @override
  void initState() {
    super.initState();
    _weatherApiService.getWeatherData('28.7041', '77.1025');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: customAppBar('Weather'), body: _body());
  }
}
