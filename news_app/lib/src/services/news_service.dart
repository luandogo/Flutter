import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/src/models/models.dart';

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = '85dd9c1a35b7430eb16ea8d3c3e14477';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.futbol, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    getTopHeadlines();
    for (var item in categories) {
      categoryArticles[item.name] = [];
    }

    getArticlesByCategory(_selectedCategory);
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getArticlesSelectedCategory =>
      categoryArticles[selectedCategory] as List<Article>;

  getTopHeadlines() async {
    const url = '$_urlNews/top-headlines?apiKey=$_apiKey&country=mx';
    final urlUri = Uri.parse(url);
    final response = await http.get(urlUri);

    final newsResponse = newsResponseFromJson(response.body);

    headlines.addAll(newsResponse.articles!);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.length > 0) {
      return categoryArticles[category];
    }

    final url =
        '$_urlNews/top-headlines?apiKey=$_apiKey&country=mx&category=$category';
    final urlUri = Uri.parse(url);
    final response = await http.get(urlUri);

    final newsResponse = newsResponseFromJson(response.body);

    categoryArticles[category]!.addAll(newsResponse.articles!);

    notifyListeners();
  }
}
