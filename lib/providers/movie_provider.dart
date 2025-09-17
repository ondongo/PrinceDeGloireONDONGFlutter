import 'package:flutter/foundation.dart';
import '../models/Movie.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  List<Result> _movies = [];
  bool _isLoading = false;
  String? _error;
  int _currentPage = 1;
  bool _hasMoreData = true;

  List<Result> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasMoreData => _hasMoreData;

  Future<void> loadMovies({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _movies.clear();
      _hasMoreData = true;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final movieData = await MovieService.getMovies(page: _currentPage);

      if (refresh) {
        _movies = movieData.results;
      } else {
        _movies.addAll(movieData.results);
      }

      _hasMoreData = _currentPage < movieData.totalPages;
      _currentPage++;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreMovies() async {
    if (!_hasMoreData || _isLoading) return;
    await loadMovies();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
