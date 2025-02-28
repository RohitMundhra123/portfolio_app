import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:my_portfolio/constants/theme.dart';
import 'package:my_portfolio/controllers/time_controller.dart';
import 'package:my_portfolio/screens/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rohit Mundhra',
      debugShowCheckedModeBanner: false,
      theme: CustomThemeData.getThemeData(),
      darkTheme: CustomThemeData.getDarkThemeData(),
      home: HomeScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put(TimeController());
      }),
    );
  }
}

