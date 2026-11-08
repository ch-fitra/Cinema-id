import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String overview;
  final double rating;
  final String posterPath;
  final Kategori kategori;
  final String releaseDate;

  Movie({
    required this.kategori,
    required this.title,
    required this.overview,
    required this.rating,
    required this.posterPath,
    required this.releaseDate,
  });
}

enum Kategori {
  action,
  comedy,
  romance,
  rekomendasi,
  tayang,
}

class FilmProv extends ChangeNotifier {
  List<Movie> _movie = [
    // Action movies
    Movie(
      title: "Furiosa: A Mad Max Saga",
      overview:
          "As the world fell, young Furiosa is snatched from the Green Place of Many Mothers...",
      rating: 7.699,
      kategori: Kategori.action,
      posterPath: "/iADOJ8Zymht2JPMoy3R7xceZprc.jpg",
      releaseDate: "2024-05-22",
    ),
    Movie(
      title: "Bad Boys: Ride or Die",
      overview:
          "After their late former Captain is framed, Lowrey and Burnett try to clear his name...",
      rating: 7.029,
      kategori: Kategori.action,
      posterPath: "/nP6RliHjxsz4irTKsxe8FRhKZYl.jpg",
      releaseDate: "2024-06-15",
    ),
    Movie(
      title: "Kingdom of the Planet of the Apes",
      overview:
          "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
      rating: 6.866,
      kategori: Kategori.action,
      posterPath: "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
      releaseDate: "2024-05-08",
    ),
    Movie(
      title: "Trigger Warning",
      overview:
          "A Special Forces commando uncovers a dangerous conspiracy when she returns to her hometown looking for answers into her beloved father's death.",
      rating: 5.77,
      kategori: Kategori.action,
      posterPath: "/6XJM3C47iGOK9nFU6yLFCSf4U5c.jpg",
      releaseDate: "2024-06-20",
    ),
    Movie(
      title: "Under Paris",
      overview:
          "In the Summer of 2024, Paris is hosting the World Triathlon Championships on the Seine for the first time. Sophia, a brilliant scientist, learns from Mika, a young environmental activist, that a large shark is swimming deep in the river. To avoid a bloodbath at the heart of the city, they have no choice but to join forces with Adil, the Seine river police commander.",
      rating: 6.033,
      kategori: Kategori.action,
      posterPath: "/qZPLK5ktRKa3CL4sKRZtj8UlPYc.jpg",
      releaseDate: "2024-06-05",
    ),
    // Comedy movies
    Movie(
      title: "Inside Out 2",
      overview:
          "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
      rating: 7.703,
      kategori: Kategori.comedy,
      posterPath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
      releaseDate: "2024-06-11",
    ),
    Movie(
      title: "Despicable Me 4",
      overview:
          "Gru and Lucy and their girls — Margo, Edith and Agnes — welcome a new member to the Gru family, Gru Jr., who is intent on tormenting his dad. Gru faces a new nemesis in Maxime Le Mal and his femme fatale girlfriend Valentina, and the family is forced to go on the run.",
      rating: 8.407,
      kategori: Kategori.comedy,
      posterPath: "/wWba3TaojhK7NdycRhoQpsG0FaH.jpg",
      releaseDate: "2024-06-20",
    ),
    Movie(
      title: "The Infallibles",
      overview:
          "When a gang of robbers provokes chaos in Paris and humiliates the police, the Minister of the Interior wants new blood at the helm of the investigation: Alia is from Marseille, fiery-tempered and unmanageable, Hugo is Parisian, valedictorian and meticulous. In short, they have every reason to hate each other. A forced alliance, for better or for worse, or maybe blossoming into something else?",
      rating: 5.8,
      kategori: Kategori.comedy,
      posterPath: "/7PoIAvL3Io5v0HyBliXfXZruQTi.jpg",
      releaseDate: "2024-06-20",
    ),
    Movie(
      overview:
          "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
      posterPath: "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg",
      kategori: Kategori.comedy,
      releaseDate: "2024-03-02",
      title: "Kung Fu Panda 4",
      rating: 7.129,
    ),
    Movie(
      overview:
          "The only thing worse than being the assistant to a high-maintenance movie star who doesn't take you seriously? Finding out he's smitten with your mom.",
      kategori: Kategori.comedy,
      posterPath: "/l0CaVyqnTsWwNd4hWsrLNEk1Wjd.jpg",
      releaseDate: "2024-06-27",
      title: "A Family Affair",
      rating: 6.196,
    ),
    // Romantis movies
    Movie(
      overview:
          "The only thing worse than being the assistant to a high-maintenance movie star who doesn't take you seriously? Finding out he's smitten with your mom.",
      posterPath: "/l0CaVyqnTsWwNd4hWsrLNEk1Wjd.jpg",
      kategori: Kategori.romance,
      releaseDate: "2024-06-27",
      title: "A Family Affair",
      rating: 6.196,
    ),
    Movie(
      overview:
          "Noah must leave her city, boyfriend, and friends to move into William Leister's mansion, the flashy and wealthy husband of her mother Rafaela. As a proud and independent 17 year old, Noah resists living in a mansion surrounded by luxury. However, it is there where she meets Nick, her new stepbrother, and the clash of their strong personalities becomes evident from the very beginning.",
      posterPath: "/w46Vw536HwNnEzOa7J24YH9DPRS.jpg",
      kategori: Kategori.romance,
      releaseDate: "2023-06-08",
      title: "My Fault",
      rating: 8,
    ),
    Movie(
      overview:
          "A mild-mannered professor moonlighting as a fake hit man in police stings ignites a chain reaction of trouble when he falls for a potential client.",
      kategori: Kategori.romance,
      posterPath: "/1126gjlBf4hTm9Sgf0ox3LGVEBt.jpg",
      releaseDate: "2024-05-16",
      title: "Hit Man",
      rating: 7.051,
    ),
    Movie(
      overview:
          "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common.",
      posterPath: "/4Y1WNkd88JXmGfhtWR7dmDAo1T2.jpg",
      releaseDate: "2023-06-14",
      title: "Elemental",
      rating: 7.653,
      kategori: Kategori.romance,
    ),
    Movie(
      kategori: Kategori.romance,
      overview:
          "40-year-old single mom Solène begins an unexpected romance with 24-year-old Hayes Campbell, the lead singer of August Moon, the hottest boy band on the planet. As they begin a whirlwind romance, it isn't long before Hayes' superstar status poses unavoidable challenges to their relationship, and Solène soon discovers that life in the glare of his spotlight might be more than she bargained for.",
      posterPath: "/zDi2U7WYkdIoGYHcYbM9X5yReVD.jpg",
      releaseDate: "2024-05-02",
      title: "The Idea of You",
      rating: 7.393,
    ),
    // tayang movies
    Movie(
      kategori: Kategori.tayang,
      posterPath: "/xg27NrXi7VXCGUr7MG75UqLl6Vg.jpg",
      overview:
          "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
      releaseDate: "2024-06-11",
      title: "Inside Out 2",
      rating: 7.7,
    ),
    Movie(
      kategori: Kategori.tayang,
      overview:
          "As the world fell, young Furiosa is snatched from the Green Place of Many Mothers and falls into the hands of a great Biker Horde led by the Warlord Dementus. Sweeping through the Wasteland they come across the Citadel presided over by The Immortan Joe. While the two Tyrants war for dominance, Furiosa must survive many trials as she puts together the means to find her way home.",
      posterPath: "/wNAhuOZ3Zf84jCIlrcI6JhgmY5q.jpg",
      releaseDate: "2024-05-22",
      title: "Furiosa: A Mad Max Saga",
      rating: 7.697,
    ),
    Movie(
      kategori: Kategori.tayang,
      posterPath: "/gRApXuxWmO2forYTuTmcz5RaNUV.jpg",
      overview:
          "After their late former Captain is framed, Lowrey and Burnett try to clear his name, only to end up on the run themselves.",
      releaseDate: "2024-06-05",
      title: "Bad Boys: Ride or Die",
      rating: 7.029,
    ),
    // rekomendasi movies
    Movie(
      title: "Inside Out 2",
      overview:
          "Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
      rating: 7.703,
      kategori: Kategori.rekomendasi,
      posterPath: "/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
      releaseDate: "2024-06-11",
    ),
    Movie(
      title: "Furiosa: A Mad Max Saga",
      overview:
          "As the world fell, young Furiosa is snatched from the Green Place of Many Mothers...",
      rating: 7.699,
      kategori: Kategori.rekomendasi,
      posterPath: "/iADOJ8Zymht2JPMoy3R7xceZprc.jpg",
      releaseDate: "2024-05-22",
    ),
    Movie(
      title: "Despicable Me 4",
      overview:
          "Gru and Lucy and their girls — Margo, Edith and Agnes — welcome a new member to the Gru family, Gru Jr., who is intent on tormenting his dad. Gru faces a new nemesis in Maxime Le Mal and his femme fatale girlfriend Valentina, and the family is forced to go on the run.",
      rating: 8.407,
      kategori: Kategori.rekomendasi,
      posterPath: "/wWba3TaojhK7NdycRhoQpsG0FaH.jpg",
      releaseDate: "2024-06-20",
    ),
    Movie(
      overview:
          "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common.",
      posterPath: "/4Y1WNkd88JXmGfhtWR7dmDAo1T2.jpg",
      releaseDate: "2023-06-14",
      title: "Elemental",
      rating: 7.653,
      kategori: Kategori.rekomendasi,
    ),
    Movie(
      overview:
          "Po is gearing up to become the spiritual leader of his Valley of Peace, but also needs someone to take his place as Dragon Warrior. As such, he will train a new kung fu practitioner for the spot and will encounter a villain called the Chameleon who conjures villains from the past.",
      posterPath: "/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg",
      kategori: Kategori.rekomendasi,
      releaseDate: "2024-03-02",
      title: "Kung Fu Panda 4",
      rating: 7.129,
    ),
  ];

  List<Movie> get movies => _movie;

  void addMovie(Movie movie) {
    _movie.add(movie);
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    _movie.remove(movie);
    notifyListeners();
  }
}
