import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print("latitude:" + location.latitude.toString());
    print("longitude:" + location.longitude.toString());
  }

  getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02');

//    print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      double temperature = decodedData['main']['temp'];
      print("temperature:" + temperature.toString());

      int condition = decodedData['weather'][0]['id'];
      print("condition:" + condition.toString());

      String cityName = decodedData['name'];
      print("cityName:" + cityName.toString());

      double longitude = decodedData['coord']['lon'];
      print(longitude);
      String weatherDescription = decodedData['weather'][0]['description'];
      print(weatherDescription);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
