import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_network/image_network.dart';
import '../../providers/movie_provider.dart';
import '../../services/movie_service.dart';
import '../../models/Movie.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieProvider>().loadMovies(refresh: true);
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<MovieProvider>().loadMoreMovies();
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films Populaires'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<MovieProvider>().loadMovies(refresh: true);
            },
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur: ${movieProvider.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      movieProvider.clearError();
                      movieProvider.loadMovies(refresh: true);
                    },
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          if (movieProvider.movies.isEmpty && movieProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (movieProvider.movies.isEmpty) {
            return const Center(
              child: Text('Aucun film trouvé', style: TextStyle(fontSize: 18)),
            );
          }

          return RefreshIndicator(
            onRefresh: () => movieProvider.loadMovies(refresh: true),
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount:
                  movieProvider.movies.length +
                  (movieProvider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == movieProvider.movies.length) {
                  return const Center(child: CircularProgressIndicator());
                }

                final movie = movieProvider.movies[index];
                return _buildMovieCard(movie);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMovieCard(Result movie) {
    bool isFavorite = false;

    return Card(
      elevation: 8,
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: ImageNetwork(
                image: MovieService.getImageUrl(movie.posterPath),
                height: double.infinity,
                width: double.infinity,
                onLoading: const Center(child: CircularProgressIndicator()),
                onError: const Center(
                  child: Icon(Icons.movie, size: 50, color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // display the title ellipsis of the movie
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      movie.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          movie.releaseDate.year.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          color: isFavorite ? Colors.red : Colors.grey[600],
                          tooltip: 'Ajouter aux favoris',
                          onPressed: () {
                            setState(() {
                              //_volume += 10;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          movie.voteAverage.toStringAsFixed(1),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
