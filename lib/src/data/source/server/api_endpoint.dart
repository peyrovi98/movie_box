class ApiEndpoint {
  static String base_url = "https://freetestapi.com/api/";
  static String movieList = "v1/movies";
  static String searchMovieList(int query) => "v1/movies?search=$query";
}
