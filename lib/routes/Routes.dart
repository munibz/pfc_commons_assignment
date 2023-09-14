import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfc_assignment/features/moviedetail/bloc/ui/movie_detail.dart';
import 'package:pfc_assignment/features/movielist/ui/movie_list.dart';

import '../common/constants/route_constants.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => MovieList());
      case RouteList.movieList:
        return MaterialPageRoute(builder: (context) => MovieList());
      case RouteList.movieDetail:
        final movieId = args as int;
        return MaterialPageRoute(
            builder: (context) => MovieDetailPage(
                  movieId: movieId,
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('ERROR'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Page Not Found'),
        ),
      );
    });
  }
}
