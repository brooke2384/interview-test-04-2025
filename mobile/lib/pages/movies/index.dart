import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmbal_movies_app/controllers/movies_controller.dart';
import 'package:kmbal_movies_app/models/movie.dart';
import 'package:kmbal_movies_app/tokens.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<StatefulWidget> createState() => MoviesPageState();
}

class MoviesPageState extends State<MoviesPage> {
  final MoviesController _moviesController = Get.find();
  late final Future<List<Movie>> _movies = _moviesController.fetchMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: ListView(
            children: [
              const Image(
                image: AssetImage('assets/logo.png'),
                height: 30,
              ),
              Text(
                "Movie Reviews",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              FutureBuilder(
                future: _movies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Error loading movies.");
                  }

                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: snapshot.requireData
                          .map<Widget>((movie) => MovieItem(movie))
                          .toList(),
                    );
                  }

                  return Text("Loading movies...");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  final Movie _movie;

  const MovieItem(this._movie, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: ColorTokens.lightBlue100,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _movie.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 4),
          Text(
            _movie.description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.toNamed("/movies/show",
                    parameters: {"id": _movie.id.toString()}),
                child: Text("View"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
