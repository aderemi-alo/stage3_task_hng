import 'package:flutter/material.dart';
import 'package:stage3_task_hng/country_model.dart';
import 'country_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CountryModel>? countryModel;
  var isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}
