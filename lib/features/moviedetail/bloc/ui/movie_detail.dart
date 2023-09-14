import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/moviedetail/bloc/ui/movie_prod_detail.dart';
import '../../../../data/core/api_constants.dart';
import '../../../../di/get_it.dart';
import '../../../../shared_components/app_error_widget.dart';
import '../movie_detail_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailBloc movieDetailBloc;

  @override
  void initState() {
    super.initState();
    movieDetailBloc = getIT.get<MovieDetailBloc>();
    movieDetailBloc.add(MovieDetailInitialEvent(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MovieDetail'),
      ),
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        bloc: movieDetailBloc,
        buildWhen: (previous, current) => current is! MovieDetailActionState,
        builder: (context, state) {
          if (state is MovieDetailLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailErrorState) {
            return Center(
              child: AppErrorWidget(
                onPressed: () => movieDetailBloc
                    .add(MovieDetailInitialEvent(movieId: widget.movieId)),
                errorType: state.errorType,
              ),
            );
          } else if (state is MovieDetailLoadedState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.sizeOf(context).width,
                      fit: BoxFit.fitHeight,
                      imageUrl:
                          '${ApiConstants.BASE_IMAGE_URL}${state.movieDetail.backdropPath!}',
                    ),
                  ],
                ),
                Flexible(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          state.movieDetail.title!,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          flex: 2,
                          child: Text(
                            state.movieDetail.overview!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Production Companies',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          flex: 4,
                          child: SingleChildScrollView(
                            child: ProductionCompanyDetail(
                                productionCompanies:
                                    state.movieDetail.productionCompanies!),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
