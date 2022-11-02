import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

class HeaderWidget extends StatefulWidget {
  HeaderWidget({Key? key}) : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = '';
  String date = DateFormat("yMMMMd").format(DateTime.now());
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLatitude().value,
        globalController.getLongitude().value);
    super.initState();
  }

  getAddress(lat, lon) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemarks[0];
    setState(() {
      city = place.locality!;
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 30, color: Colors.black),
              ),
            ),
            const SizedBox(width: 230),
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu, size: 30, color: Colors.black),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(
            city,
            style: const TextStyle(fontSize: 30, height: 2),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            date,
            style:
                TextStyle(fontSize: 19, color: Colors.grey[700], height: 1.5),
          ),
        )
      ],
    );
  }
}
