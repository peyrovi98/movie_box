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
      this.id,
      this.title,
      this.year,
      this.genre,
      this.rating,
      this.director,
      this.actors,
      this.plot,
      this.poster,
      this.trailer,
      this.runtime,
      this.awards,
      this.country,
      this.language,
      this.boxOffice,
      this.production,
      this.website);

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
      var list = jsonObject["genre"] is List ? jsonObject["genre"] : jsonDecode(jsonObject["genre"].toString());
      for(var item in list) {
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
      var list = jsonObject["actors"] is List ? jsonObject["actors"] : jsonDecode(jsonObject["actors"].toString());
      for(var item in list) {
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
        id,
        title,
        year,
        genre,
        rating,
        director,
        actors,
        plot,
        poster,
        trailer,
        runtime,
        awards,
        country,
        language,
        boxOffice,
        production,
        website);
  }

  Map<String, Object?> toJson() {
    return {
      filedId : id,
      filedTitle : title,
      filedYear : year,
      filedGenre : jsonEncode(genre),
      filedRating : rating,
      filedDirector : director,
      filedActors : jsonEncode(actors),
      filedPlot : plot,
      filedPoster : poster,
      filedTrailer : trailer,
      filedRuntime : runtime,
      filedAwards : awards,
      filedCountry : country,
      filedLanguage : language,
      filedBoxOffice : boxOffice,
      filedProduction : production,
      filedWebsite : website,
    };
  }
}
