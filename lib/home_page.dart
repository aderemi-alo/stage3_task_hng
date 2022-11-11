import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stage3_task_hng/country_model.dart';
import 'api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CountryModel>> countries;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    countries = APIService().getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 24),
      child: FutureBuilder<List<CountryModel>>(
          future: countries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Text("List is empty");
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore",
                        style: GoogleFonts.elsieSwashCaps(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                      const Icon(CupertinoIcons.sun_max)
                    ],
                  ),
                  Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.network(
                                  "${snapshot.data?[index].flags?.png}",
                                  width: 40,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data?[index].name?.common}",
                                    style: const TextStyle(
                                        fontFamily: "Axiforma",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "${snapshot.data?[index].capital == null ? "" : snapshot.data?[index].capital[0]}",
                                    style: const TextStyle(
                                        fontFamily: "Axiforma",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  )
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const Text("error");
          }),
    ));
  }
}
