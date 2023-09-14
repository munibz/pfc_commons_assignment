import 'package:flutter/material.dart';

import '../../../../di/get_it.dart' as getit;
import '../../../../features/movielist/ui/movie_list.dart';

import 'routes/Routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getit.init();
  await getit.getIT.allReady();

  // ApiClient apiClient = ApiClient(Client());
  // MovieRemoteDataSource movieRemoteDataSource =
  //     MovieRemoteDataSource(apiClient);
  // await movieRemoteDataSource.getTrending();

  // await movieRemoteDataSource.getMovieDetail(335977);

  // await movieRemoteDataSource.getTrendingAccordingToPage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MovieList(),
      onGenerateRoute: (settings) => Routes.generateRoute(settings),
    );
  }
}
