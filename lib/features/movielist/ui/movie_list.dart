import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pfc_assignment/common/constants/route_constants.dart';
import 'package:pfc_assignment/data/model/movie_model.dart';
import 'package:pfc_assignment/di/get_it.dart';
import 'package:pfc_assignment/features/movielist/ui/movie_list_tile.dart';
import 'package:pfc_assignment/shared_components/app_error_widget.dart';

import '../bloc/movie_list_bloc.dart';

class MovieList extends StatefulWidget {
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late MovieListBloc movieListBloc;
  final pageSize = 20;

  PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    movieListBloc = getIT.get<MovieListBloc>();

    _pagingController.addPageRequestListener((pageKey) {
      movieListBloc.add(MovieListInitialEvent(
          page: pageKey, pageController: _pagingController));
    });

    movieListBloc.add(MovieListInitialEvent(
        page: _pagingController.firstPageKey,
        pageController: _pagingController));
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieList'),
        actions: [
          IconButton(
            onPressed: () {
              movieListBloc.add(MovieListTileClickedNavigateEvent());
            },
            icon: Icon(Icons.abc),
          )
        ],
      ),
      body: BlocBuilder<MovieListBloc, MovieListState>(
        bloc: movieListBloc,
        buildWhen: (previous, current) => current is! MovieListActionState,
        builder: (context, state) {
          if (state is MovieListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieListErrorState) {
            return Center(
              child: AppErrorWidget(
                onPressed: () => movieListBloc.add(MovieListInitialEvent(
                    page: _pagingController.firstPageKey,
                    pageController: _pagingController)),
                errorType: state.errorType,
              ),
            );
          } else if (state is MovieListLoadedState) {
            return PagedListView<int, MovieModel>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<MovieModel>(
                itemBuilder: (context, item, index) => MovieListTile(
                  movieid: item.id!,
                  title: item.title!,
                  description: item.overview!,
                  posterPath: item.posterPath!,
                ),
              ),
            );
            // ListView.builder(
            //   itemCount: state.movies.length,
            //   itemBuilder: (context, index) => MovieListTile(
            //     movieid: state.movies[index].id!,
            //     title: state.movies[index].title!,
            //     description: state.movies[index].overview!,
            //     posterPath: state.movies[index].posterPath!,
            //   ),
            // );
          }

          return const SizedBox.shrink();
        },
      ),
    );
    // return BlocConsumer<MovieListBloc, MovieListState>(
    //   bloc: movieListBloc,
    //   listenWhen: (previous, current) => current is MovieListActionState,
    //   buildWhen: (previous, current) => current is! MovieListActionState,
    //   // buildWhen: (previous, current) {

    //   // },
    //   listener: (context, state) {
    //     if (state is MovieListNavigateToDetailPageState) {
    //       Navigator.pushNamed(context, RouteList.movieDetail);
    //     }
    //   },
    //   builder: (context, state) {

    //   }

    //               );
    //     if (state is MovieListLoadingState) {
    //       return const Scaffold(
    //         body: CircularProgressIndicator(),
    //       );
    //     } else if (state is MovieListError) {

    //       Scaffold(
    //         body: CircularProgressIndicator(),
    //       );
    //     }
    //       switch (state.runtimeType) {
    //         case MovieListLoadingState:
    //         case MovieListLoadedState:
    //           return Scaffold(
    //             appBar: AppBar(
    //               title: const Text('MovieList'),
    //               actions: [
    //                 IconButton(
    //                     onPressed: () {
    //                       movieListBloc
    //                           .add(MovieListTileClickedNavigateEvent());
    //                     },
    //                     icon: Icon(Icons.abc))
    //               ],
    //             ),
    //             body: ListView.builder(
    //               itemBuilder: (context, index) =>
    //                   MovieListTile(title: title, posterPath: posterPath),
    //             ),
    //           );
    //       }
    //   }}
  }
}
