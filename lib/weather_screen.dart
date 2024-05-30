import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:task1/controllers/theme_controller.dart';
import 'package:task1/weather_sevices.dart';
import 'package:task1/widgets/drawer.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Position? position;
  bool isLoading = true;
  Map<String, dynamic>? weatherData;
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      position = currentPosition;
      await fetchWeatherData(currentPosition);
    }
  }

  fetchWeatherData(Position position) async {
    var data = await _weatherService.getCurrentCityWeather(position);
    setState(() {
      weatherData = data;
      isLoading = false;
    });
  }

  void _openSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Search City'),
          content: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter city name',
            ),
            onSubmitted: (value) {
              _performSearch(value);
            },
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Search'),
              onPressed: () {
                _performSearch(_searchController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _performSearch(String cityName) {
    print('Searching for city: $cityName');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;
      double? temperatureCelsius;
      int? humidity;
      double? windSpeed;
      String? description;
      if (weatherData != null) {
        double temperatureKelvin = weatherData!['main']['temp'];
        temperatureCelsius = temperatureKelvin - 273.15;
        humidity = weatherData!['main']['humidity'];
        windSpeed = weatherData!['wind']['speed'];
        description = weatherData!['weather'][0]['description'];
      }

      return Scaffold(
        backgroundColor: isDarkMode ? Color(0xff303030) : Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xffFFCA2D)),
          centerTitle: true,
          title: Text(
            "WeatherApp",
            style: TextStyle(
              color: Color(0xffFFCA2D),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _openSearchDialog,
              icon: Icon(
                Icons.search,
                color: Color(0xffFFCA2D),
                size: 28,
              ),
            ),
          ],
        ),
        drawer: DrawerWidget(),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "IN",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: isDarkMode
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff245B82),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "|",
                                style: TextStyle(
                                  fontSize: 41,
                                  color: isDarkMode
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff245B82),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                weatherData?['name'] ?? '',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: isDarkMode
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff245B82),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            description ?? '',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDarkMode
                                  ? Color(0xffFFFFFF)
                                  : Color(0xff245B82),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          temperatureCelsius != null
                              ? "${temperatureCelsius.toStringAsFixed(0)}°"
                              : "Loading",
                          style: TextStyle(
                            fontSize: 100,
                            color: isDarkMode
                                ? Color(0xffFFFFFF)
                                : Color(0xff245B82),
                          ),
                        ),
                        Image.asset(
                          "assets/image/cloud.png",
                          width: 110,
                          height: 88,
                          color: isDarkMode
                              ? Color(0xffFFFFFF)
                              : Color(0xff245B82),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 237,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Color(0xff23282B)
                              : Color(0xffB0BCC8),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/thermo.png",
                                    width: 64,
                                    height: 64,
                                    color: isDarkMode
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff245B82),
                                  ),
                                  Text(
                                    humidity != null
                                        ? "${humidity}%"
                                        : "Loading",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: isDarkMode
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff245B82),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/drops.png",
                                    width: 107.72,
                                    height: 107.32,
                                    color: isDarkMode
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff245B82),
                                  ),
                                  Text(
                                    humidity != null
                                        ? "${humidity}%"
                                        : "Loading",
                                    style: TextStyle(
                                      fontSize: 40,
                                      color: isDarkMode
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff245B82),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/image/person.png",
                                    width: 55,
                                    height: 70,
                                    color: isDarkMode
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff245B82),
                                  ),
                                  Text(
                                    windSpeed != null
                                        ? "${windSpeed} Km/h"
                                        : "Loading",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: isDarkMode
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff245B82),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Today",
                        style:
                            TextStyle(color: Color(0xffFFCA2D), fontSize: 19),
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        height: 170,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 35),
                          itemBuilder: (context, index) => Container(
                            width: 162,
                            height: 170,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Color(0xff23282B)
                                  : Color(0xffB0BCC8),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "09:00AM",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: isDarkMode
                                        ? Color(0xffFFFFFF)
                                        : Color(0xff245B82),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      temperatureCelsius != null
                                          ? "${temperatureCelsius.toStringAsFixed(0)}°"
                                          : "Loading",
                                      style: TextStyle(
                                        fontSize: 33,
                                        color: isDarkMode
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff245B82),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/image/cloud.png",
                                      width: 41,
                                      height: 26,
                                      color: isDarkMode
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff245B82),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/image/drops.png",
                                            width: 27.72,
                                            height: 27.62,
                                            color: isDarkMode
                                                ? Color(0xffFFFFFF)
                                                : Color(0xff245B82),
                                          ),
                                          Text(
                                            humidity != null
                                                ? "${humidity}%"
                                                : "Loading",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: isDarkMode
                                                  ? Color(0xffFFFFFF)
                                                  : Color(0xff245B82),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/image/person.png",
                                            width: 27.72,
                                            height: 27.62,
                                            color: isDarkMode
                                                ? Color(0xffFFFFFF)
                                                : Color(0xff245B82),
                                          ),
                                          Text(
                                            windSpeed != null
                                                ? "${windSpeed} Km/h"
                                                : "Loading",
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: isDarkMode
                                                  ? Color(0xffFFFFFF)
                                                  : Color(0xff245B82),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "5 Day Forecast",
                        style:
                            TextStyle(color: Color(0xffFFCA2D), fontSize: 19),
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 77,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Color(0xff23282B)
                              : Color(0xffB0BCC8),
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Wed",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: isDarkMode
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff245B82),
                                    ),
                                  ),
                                  Text(
                                    "9 PM",
                                    style: TextStyle(
                                      fontSize: 19,
                                      color: isDarkMode
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff245B82),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Image.asset(
                                "assets/image/cloudsm.png",
                                width: 41,
                                height: 26,
                                color: isDarkMode
                                    ? Color(0xffFFFFFF)
                                    : Color(0xff245B82),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                temperatureCelsius != null
                                    ? "${temperatureCelsius.toStringAsFixed(0)}°"
                                    : "Loading",
                                style: TextStyle(
                                  fontSize: 38,
                                  color: isDarkMode
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff245B82),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                temperatureCelsius != null
                                    ? "${temperatureCelsius.toStringAsFixed(0)}°"
                                    : "Loading",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: isDarkMode
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff245B82),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
