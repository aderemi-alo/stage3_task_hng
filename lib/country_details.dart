import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'country_model.dart';
import 'api_service.dart';

class CountryDetails extends StatefulWidget {
  const CountryDetails(
      {super.key, required this.index, required this.countryName});

  final int index;
  final String? countryName;

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
        ),
        title: FutureBuilder<List<CountryModel>>(
          future: countries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Text("List is empty");
              }
              // if(snapshot.data[widget.index])
              return Text(
                "${snapshot.data?[widget.index].name?.common}",
                style: TextStyle(
                    fontFamily: "Axiforma",
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    fontSize: 25),
              );
            } else {
              return Text("error");
            }
          },
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: EdgeInsets.only(top: 15),
          // child: Text("${widget.index}"),
          child: FutureBuilder<List<CountryModel>>(
            future: countries,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Text("List is empty");
                }
                // if(snapshot.data[widget.index])
                return Column(
                  children: [],
                );
              } else {
                return Text("error");
              }
            },
          ),
        ),
      ),
    );
  }
}
