class ApiEndpoint {
  static String base_url = "https://freetestapi.com/api/";
  static String movieList = "${base_url}v1/movies";
  static String searchMovieList(String query) => "${base_url}v1/movies?search=$query";
}
