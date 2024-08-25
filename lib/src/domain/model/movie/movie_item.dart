import 'dart:convert';

import 'movie_static.dart';

class MovieItem {
  int id;
  String title;
  int year;
  List<String> genre;
  double rating;
  String director;
  List<String> actors;
  String plot;
  String poster;
  String trailer;
  int runtime;
  String awards;
  String country;
  String language;
  String boxOffice;
  String production;
  String website;

  MovieItem(
      {required this.id,
      required this.title,
      required this.year,
      required this.genre,
      required this.rating,
      required this.director,
      required this.actors,
      required this.plot,
      required this.poster,
      required this.trailer,
      required this.runtime,
      required this.awards,
      required this.country,
      required this.language,
      required this.boxOffice,
      required this.production,
      required this.website});

  static MovieItem fromJson(Map jsonObject) {
    int id = -1;
    String title = "";
    int year = -1;
    List<String> genre = List.empty(growable: true);
    double rating = -1.toDouble();
    String director = "";
    List<String> actors = List.empty(growable: true);
    String plot = "";
    String poster = "";
    String trailer = "";
    int runtime = -1;
    String awards = "";
    String country = "";
    String language = "";
    String boxOffice = "";
    String production = "";
    String website = "";

    if (jsonObject.containsKey("id")) {
      id = int.parse(jsonObject["id"].toString());
    }
    if (jsonObject.containsKey("title")) {
      title = jsonObject["title"];
    }
    if (jsonObject.containsKey("year")) {
      year = int.parse(jsonObject["year"].toString());
    }
    if (jsonObject.containsKey("genre")) {
      var list = jsonObject["genre"] is List
          ? jsonObject["genre"]
          : jsonDecode(jsonObject["genre"].toString());
      for (var item in list) {
        genre.add(item.toString());
      }
    }
    if (jsonObject.containsKey("rating")) {
      rating = double.parse(jsonObject["rating"].toString());
    }
    if (jsonObject.containsKey("director")) {
      director = jsonObject["director"];
    }
    if (jsonObject.containsKey("actors")) {
      var list = jsonObject["actors"] is List
          ? jsonObject["actors"]
          : jsonDecode(jsonObject["actors"].toString());
      for (var item in list) {
        actors.add(item.toString());
      }
    }
    if (jsonObject.containsKey("plot")) {
      plot = jsonObject["plot"];
    }
    if (jsonObject.containsKey("poster")) {
      poster = jsonObject["poster"];
    }
    if (jsonObject.containsKey("trailer")) {
      trailer = jsonObject["trailer"];
    }
    if (jsonObject.containsKey("runtime")) {
      runtime = jsonObject["runtime"];
    }
    if (jsonObject.containsKey("awards")) {
      awards = jsonObject["awards"];
    }
    if (jsonObject.containsKey("country")) {
      country = jsonObject["country"];
    }
    if (jsonObject.containsKey("language")) {
      language = jsonObject["language"];
    }
    if (jsonObject.containsKey("boxOffice")) {
      boxOffice = jsonObject["boxOffice"];
    }
    if (jsonObject.containsKey("production")) {
      production = jsonObject["production"];
    }
    if (jsonObject.containsKey("website")) {
      website = jsonObject["website"];
    }
    return MovieItem(
        id: id,
        title: title,
        year: year,
        genre: genre,
        rating: rating,
        director: director,
        actors: actors,
        plot: plot,
        poster: poster,
        trailer: trailer,
        runtime: runtime,
        awards: awards,
        country: country,
        language: language,
        boxOffice: boxOffice,
        production: production,
        website: website);
  }

  Map<String, Object?> toJson() {
    return {
      filedId: id,
      filedTitle: title,
      filedYear: year,
      filedGenre: jsonEncode(genre),
      filedRating: rating,
      filedDirector: director,
      filedActors: jsonEncode(actors),
      filedPlot: plot,
      filedPoster: poster,
      filedTrailer: trailer,
      filedRuntime: runtime,
      filedAwards: awards,
      filedCountry: country,
      filedLanguage: language,
      filedBoxOffice: boxOffice,
      filedProduction: production,
      filedWebsite: website,
    };
  }
}
