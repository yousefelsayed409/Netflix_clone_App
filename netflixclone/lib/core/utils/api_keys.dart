class ApiKeys {
  static String baseUrl = 'https://api.themoviedb.org/3/';

  static String apikey = 'ecbfd8c2cb561d47ba463c010fb0eba1';
  static String trandingdayUrl =
      'https://api.themoviedb.org/3/trending/all/day?api_key=$apikey';
  static String trandingweekUrl =
      'https://api.themoviedb.org/3/trending/all/week?api_key=$apikey';

  ///todo__________________________________________________
  static String popularTvserieslUrl =
      'https://api.themoviedb.org/3/tv/popular?api_key=$apikey';
  static String tobratedtvSeriesUrl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=$apikey';
  static String ontheairtvSeriesUrl =
      'https://api.themoviedb.org/3/tv/on_the_air?api_key=$apikey';

  ///todo__________________________________________________
  static String popularmoviesUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';
  static String nowplayigmoviesUrl =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';
  static String tobratedmoviesUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey';
  static String latestmovuewUrl =
      'https://api.themoviedb.org/3/movie/latest?api_key=$apikey';

  ///todo__________________________________________________

  static String upcommingmoviesUrl =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$apikey';
}
