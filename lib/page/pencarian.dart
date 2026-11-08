import 'package:cinema_id_v1/page/detail_film.dart';
import 'package:cinema_id_v1/provider/provider_dark_mode.dart';
import 'package:cinema_id_v1/provider/provider_film.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Movies";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final seting = Provider.of<DarkMode>(context, listen: false).isDarkMode;

    return ThemeData(
      appBarTheme: AppBarTheme(
          elevation: 0.5,
          backgroundColor: seting ? Colors.black : Colors.white,
          foregroundColor: seting ? Colors.white : Colors.black),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = context.read<FilmProv>();
    final results = provider.movies
        .where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final movie = results[index];
        return ListTile(
          onTap: () {
            close(context, null);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Details(
                    rating: movie.rating,
                    image: movie.posterPath,
                    title: movie.title,
                    jadwalTayang: movie.releaseDate,
                    overview: movie.overview)));
          },
          leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
          title: Text(movie.title),
          subtitle: Text(
            movie.overview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text("Search Movies"));
  }
}
