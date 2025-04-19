import 'package:informer/Data%20Fetching/api_response.dart';
import 'package:informer/Models/categories_model.dart';
import 'package:informer/Models/general_news_model.dart';
import 'package:informer/Models/top_headlines_model.dart';

class News_View_Model {
  final _get_api_response = api_response();
  var current_country;

  Future<top_headlines_model> get_top_head_response(String channel) async {
    final response = await _get_api_response.get_top_head_response(channel);

    return response;
  }

 

  Future<categories_model> get_categories(String category_name) async {
    final category_response =
        await _get_api_response.get_categories(category_name);

    return category_response;
  }

// Country Location Location

  Future<String> get_current_location() async {
    current_country = await _get_api_response.get_current_country();
    print(current_country.toString());
    return current_country;
  }

  Future<general_news_model> get_location_news() async {
    final location_news =
        await _get_api_response.get_general_news(current_country);

    print(location_news.articles!.length);

    return location_news;
  }
}
