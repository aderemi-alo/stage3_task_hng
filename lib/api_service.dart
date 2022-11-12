import 'country_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  Future<List<CountryModel>> getCountries() async {
    var client = http.Client();

    var url = Uri.parse("https://restcountries.com/v3.1/all");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final json1 = json.decode(response.body);
      final List<CountryModel> services =
          json1.map<CountryModel>((e) => CountryModel.fromJson(e)).toList();
      services.sort(
        (a, b) => a.name!.common!.compareTo(b.name!.common!),
      );
      return services;
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<CountryModel> getCountry(int index) async {
    var client = http.Client();

    var url = Uri.parse("https://restcountries.com/v3.1/all");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      final json1 = json.decode(response.body);
      final List<CountryModel> services =
          json1.map<CountryModel>((e) => CountryModel.fromJson(e)).toList();
      services.sort(
        (a, b) => a.name!.common!.compareTo(b.name!.common!),
      );
      return services[index];
    } else {
      throw Exception("Failed to load");
    }
  }
}
