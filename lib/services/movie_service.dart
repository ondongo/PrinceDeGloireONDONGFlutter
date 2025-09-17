import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/Movie.dart';

class MovieService {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static Future<Movie> getMovies({int page = 1}) async {
    try {
      final apiKey = dotenv.env['API_KEY'];
      final token = dotenv.env['TOKEN'];
      if (apiKey == null || apiKey.isEmpty) {
        throw Exception('API_KEY non trouvée dans le fichier .env');
      }

      final url = Uri.parse(
        '$baseUrl/discover/movie?api_key=$apiKey&page=$page',
      );

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception(
          'Erreur lors de la récupération des films: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Erreur lors de la récupération des films: $e');
    }
  }

  static Future<Movie> getMovieById(int id) async {
    final apiKey = dotenv.env['API_KEY'];
    final token = dotenv.env['TOKEN'];
    final url = Uri.parse('$baseUrl/movie/$id?api_key=$apiKey');
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception(
        'Erreur lors de la récupération du film: ${response.statusCode}',
      );
    }
  }

  static String getImageUrl(String? posterPath) {
    if (posterPath == null || posterPath.isEmpty) {
      return 'https://via.placeholder.com/300x450?text=No+Image';
    }
    return '$imageBaseUrl$posterPath';
  }
}
