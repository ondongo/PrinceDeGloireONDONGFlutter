import 'package:flutter/foundation.dart';
import 'package:mon_premier_projet/models/Movie.dart';

class FavoriteProvider with ChangeNotifier {
  List<Movie> _favorites = [];

  List<Movie> get favorites => _favorites;

  void addFavorite(Movie movie) {
    _favorites.add(movie);
    notifyListeners();
  }

  void removeFavorite(Movie movie) {
    _favorites.remove(movie);
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}
