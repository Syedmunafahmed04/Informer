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


        //GET YOUR API KEY AND ADD INTO YOUR URL


      final response = await http.get(Uri.parse(

        // ADD URL WITH API KEY

      ));

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

//GET YOUR API KEY AND ADD INTO YOUR URL

      final response = await http.get(Uri.parse(

// ADD URL WITH API KEY

      ));
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


//GET YOUR API KEY AND ADD INTO YOUR URL
      final response = await http.get(Uri.parse(
        
        //ADD URL WITH API KEY


      ));

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
//If Denied Again, Return PAKISTAN by Default
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
