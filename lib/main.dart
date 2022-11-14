import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:stage3_task_hng/country_details.dart';
import 'package:stage3_task_hng/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: HexColor("#000F24"),
              titleTextStyle: TextStyle(
                  fontFamily: "Axiforma",
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 25)),
          scaffoldBackgroundColor: HexColor("#000F24"),
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              decorationColor: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          inputDecorationTheme: InputDecorationTheme(
              prefixIconColor: HexColor("#EAECF0"),
              hintStyle: TextStyle(
                  color: HexColor("#EAECF0"),
                  fontFamily: "Axiforma",
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              fillColor: Color.fromRGBO(152, 162, 179, 0.2))),
      home: const HomePage(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(
                fontFamily: "Axiforma",
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 25),
          ),
          primarySwatch: Colors.blue,
          iconTheme: IconThemeData(color: Colors.black),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
                color: Colors.black,
                fontFamily: "Axiforma",
                fontSize: 16,
                fontWeight: FontWeight.w300),
            fillColor: Colors.white,
          )),
    );
  }
}
