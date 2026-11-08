import 'package:cinema_id_v1/page/detail_film.dart';
import 'package:cinema_id_v1/provider/provider_film.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Rekomendasi extends StatelessWidget {
  const Rekomendasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<FilmProv>(builder: (_, provider, __) {
        if (provider.movies.isNotEmpty) {
          // Limit to the first 8 movies
          final moviesToShow = provider.movies
              .where((movie) => movie.kategori == Kategori.rekomendasi)
              .toList();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.vertical,
            itemBuilder: (_, index) {
              return SizedBox(
                width: 140, // Ensuring the fixed width for the movie item
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Details(
                              rating: moviesToShow[index].rating,
                              image: moviesToShow[index].posterPath,
                              title: moviesToShow[index].title,
                              jadwalTayang: moviesToShow[index].releaseDate,
                              overview: moviesToShow[index].overview)));
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${moviesToShow[index].posterPath}',
                            height: 200,
                            width: 140,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                moviesToShow[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        14.0), // Adjust font size if necessary
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                moviesToShow[index].overview,
                                maxLines: 5,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16.0, // Adjust size if necessary
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    moviesToShow[index].rating.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            14.0), // Adjust font size if necessary
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(
              width: 8.0,
            ),
            itemCount: moviesToShow.length,
          );
        }

        return Container();
      }),
    );
  }
}
