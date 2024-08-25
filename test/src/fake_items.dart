import 'package:faker/faker.dart';
import 'package:movie_box/src/domain/model/movie/movie_item.dart';

MovieItem getFakeMovieItem() {
  var faker = Faker();
  MovieItem movieItem = MovieItem(
      id: faker.lorem.random.integer(1000),
      title: faker.lorem.sentence(),
      year: faker.lorem.random.integer(2023, min: 1990),
      genre: faker.lorem.sentences(2),
      rating: faker.lorem.random.integer(100, min: 1) / 5.toDouble(),
      director: faker.lorem.sentence(),
      actors: faker.lorem.sentences(5),
      plot: faker.lorem.sentence(),
      poster: faker.lorem.sentence(),
      trailer: faker.lorem.sentence(),
      runtime: faker.lorem.random.integer(300, min: 60),
      awards: faker.lorem.sentence(),
      country: faker.lorem.sentence(),
      language: faker.lorem.sentence(),
      boxOffice: faker.lorem.sentence(),
      production: faker.lorem.sentence(),
      website: faker.lorem.sentence());
  return movieItem;
}
