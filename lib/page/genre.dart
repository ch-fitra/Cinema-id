import 'package:cinema_id_v1/page/detail_film.dart';
import 'package:cinema_id_v1/provider/provider_film.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Genre extends StatelessWidget {
  const Genre({Key? key});

  List<Tab> tab() {
    // Filter hanya kategori tayang
    List<Tab> filteredTabs = Kategori.values
        .where((k) =>
            k == Kategori.action ||
            k == Kategori.comedy ||
            k == Kategori.romance)
        .map((k) {
      return Tab(
        text: k.toString().split('.').last.toUpperCase(),
      );
    }).toList();

    return filteredTabs;
  }

  List<Movie> cek(List<Movie> movies, Kategori kategori) {
    return movies.where((m) => m.kategori == kategori).toList();
  }

  List<Widget> hasil(List<Movie> movies) {
    return Kategori.values.map((k) {
      List<Movie> cari = cek(movies, k);
      return ListView.builder(
        itemCount: cari.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
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
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${cari[index].posterPath}',
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
                              cari[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      14.0), // Adjust font size if necessary
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              cari[index].overview,
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
                                  cari[index].rating.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize:
                                          14.0), // Adjust font size if necessary
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tab().length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Genre"),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: tab(),
          ),
        ),
        body: Consumer<FilmProv>(builder: (_, provider, __) {
          return TabBarView(children: hasil(provider.movies));
        }),
      ),
    );
  }
}
