import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stage3_task_hng/country_details.dart';
import 'package:stage3_task_hng/country_model.dart';
import 'api_service.dart';
import 'widget.dart';

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

  String searchParameter = "";

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: FutureBuilder<List<CountryModel>>(
            future: countries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
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
                              fontSize: 23, fontWeight: FontWeight.w700),
                        ),
                        const Icon(CupertinoIcons.sun_max)
                      ],
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          searchParameter = _searchController.text;
                        });
                      },
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                        ),
                        hintText: "Search Country",
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.globe),
                          label: const Text("EN"),
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return const Contains();
                                  });
                            },
                            icon: const Icon(Icons.filter),
                            label: const Text("Filter"))
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Flexible(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data?[index].name?.common!
                                    .toLowerCase()
                                    .contains(
                                        _searchController.text.toLowerCase()) ==
                                true) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 26),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CountryDetails(
                                                  index: index,
                                                  countryName: snapshot
                                                      .data?[index]
                                                      .name
                                                      ?.common!,
                                                )));
                                  },
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          "${snapshot.data?[index].flags?.png}",
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data?[index].name?.common}",
                                            style: const TextStyle(
                                                fontFamily: "Axiforma",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "${snapshot.data?[index].capital == null ? "" : snapshot.data?[index].capital[0]}",
                                            style: const TextStyle(
                                                fontFamily: "Axiforma",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const Text("error");
            }),
      ),
    ));
  }
}
