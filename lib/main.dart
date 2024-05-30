import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controllers/theme_controller.dart';
import 'package:task1/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffB0BCC8),
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Color(0xffB0BCC8)),
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: Color(0xff303030),
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Color(0xff303030)),
        ),
        themeMode: themeController.theme,
        home: WeatherScreen(),
      );
    });
  }
}
