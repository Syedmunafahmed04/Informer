import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:informer/Models/categories_model.dart';
import 'package:informer/Models/general_news_model.dart';
import 'package:informer/Models/top_headlines_model.dart';
import 'package:http/http.dart' as http;

class api_response {
 
  Future<top_headlines_model> get_top_head_response(String channel) async {
    try {
      String Munaf_Api =
          'https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=0c900ad00c9a47348c3a6b67c3436eda';

      String Laiba_Api =
          'https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=19e0e92cb8ad4dd99d4bdd728f4b40ec';

      String Naveel_Api =
          "https://newsapi.org/v2/top-headlines?sources=$channel&apiKey=11070884658c451da1c1d09dd2c0cb67";

      final response = await http.get(Uri.parse(Naveel_Api));

      if (response.statusCode == 200) {
        var decoded_data = jsonDecode(response.body);

        return top_headlines_model.fromJson(decoded_data);
      }
    } catch (e) {
      print('Caught Exception: $e');
    }

    throw Exception('Error in Getting Response');
  }

// GENERAL NEWS API

  Future<general_news_model> get_general_news(var country) async {
    try {
// MUNAF API
      String Munaf_Api =
          'https://newsapi.org/v2/everything?q=$country&apiKey=0c900ad00c9a47348c3a6b67c3436eda';
// LAIBA API
      String Laiba_Api =
          'https://newsapi.org/v2/everything?q=$country&apiKey=19e0e92cb8ad4dd99d4bdd728f4b40ec';
// NAVEEL API
      String Naveel_Api =
          "https://newsapi.org/v2/everything?q=$country&apiKey=11070884658c451da1c1d09dd2c0cb67";

      final response = await http.get(Uri.parse(Naveel_Api));
      var decode_general_news_data = jsonDecode(response.body);

      return general_news_model.fromJson(decode_general_news_data);
    } catch (e) {
      print('Exception in Category Response $e');
    }

    throw Exception('Error in Location News');
  }

//  CATEGORIES API

  Future<categories_model> get_categories(String category) async {
    try {
// MUNAF API
      String Munaf_Api =
          'https://newsapi.org/v2/everything?q=${category.toLowerCase()}&apiKey=0c900ad00c9a47348c3a6b67c3436eda';
// LAIBA API
      String Laiba_Api =
          'https://newsapi.org/v2/everything?q=${category.toLowerCase()}&apiKey=19e0e92cb8ad4dd99d4bdd728f4b40ec';
// NAVEEL API
      String Naveel_Api =
          "https://newsapi.org/v2/everything?q=${category.toLowerCase()}&apiKey=11070884658c451da1c1d09dd2c0cb67";

      final response = await http.get(Uri.parse(Naveel_Api));

      var decode_category_data = jsonDecode(response.body);

      return categories_model.fromJson(decode_category_data);
    } catch (e) {
      print('Exception in Category Response $e');
    }

    throw Exception('Error in Getting Categories');
  }

// Getting Current Location

  Future<String> get_current_country() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      // If Denied, Req Again

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
//If Denied Again, Return Karachi by Default
        if (permission == LocationPermission.denied) {
          return 'Pakistan';
        }
      }
//Define Location Accuracy
      LocationSettings locationSettings =
          LocationSettings(accuracy: LocationAccuracy.high);

      //User Position
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      // List of PlaceMarks

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Extract Country

     String country = placemarks[0].country ?? 'Pakistan';
      return country;
    } catch (e) {
      return 'Failed to get location ${e.toString()}';
    }
  }
}
