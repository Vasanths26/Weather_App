import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:weather_app/utils/custom_color.dart';
import 'package:weather_app/widget/comfort_level.dart';
import 'package:weather_app/widget/current_weather_widget.dart';
import 'package:weather_app/widget/daily_widget.dart';
import 'package:weather_app/widget/header_widget.dart';
import 'package:weather_app/widget/hourly_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkloading().isTrue
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/clouds.png",
                        height: 200,
                        width: 100,
                      ),
                      const CircularProgressIndicator()
                    ],
                  ),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      HeaderWidget(),
                      CurrentWeatherWidget(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HourlyWidget(
                        weatherDataHourly: globalController
                            .getWeatherData()
                            .getHourlyWeather(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DailyWidget(
                        weatherDataDaily:
                            globalController.getWeatherData().getDailyWeather(),
                      ),
                      Container(
                        height: 1,
                        color: CustomColor.dividerLine,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ComfortLevel(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather(),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
