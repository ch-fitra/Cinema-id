import 'package:cinema_id_v1/page/detail_film.dart';
import 'package:cinema_id_v1/provider/provider_film.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieBanner extends StatefulWidget {
  const MovieBanner({super.key});

  @override
  State<MovieBanner> createState() => _MovieBannerState();
}

class _MovieBannerState extends State<MovieBanner> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmProv>(
      builder: (_, provider, __) {
        if (provider.movies.isNotEmpty) {
          // Shuffle and limit to 5 movies
          final movies = provider.movies
              .where((movie) => movie.kategori == Kategori.tayang)
              .toList();

          return Column(
            children: [
              CarouselSlider.builder(
                carouselController: _controller,
                itemCount: movies.length,
                itemBuilder: (context, index, realIndex) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Details(
                                  rating: movies[index].rating,
                                  image: movies[index].posterPath,
                                  title: movies[index].title,
                                  jadwalTayang: movies[index].releaseDate,
                                  overview: movies[index].overview)));
                        },
                        child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movies[index].posterPath}'),
                      ),
                      Positioned(
                          top: 3,
                          right: 3,
                          child: Banner(
                              message: "Sedang Tayang",
                              location: BannerLocation.topEnd)),
                    ],
                  );
                },
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  viewportFraction: 0.95,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: movies.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 9.0,
                      height: 9.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(
                                _currentIndex == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }

        return Center(child: Text('No movies found'));
      },
    );
  }
}
