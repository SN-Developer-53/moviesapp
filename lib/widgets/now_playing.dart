import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:moviesapp/bloc/get_now_playing_bloc.dart';
import 'package:moviesapp/model/movies.dart';
import 'package:moviesapp/model/movie_response.dart';
import 'package:moviesapp/style/theme.dart' as Style;
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);

  @override
  void initState() {
    super.initState();
    nowPlayingMoviesBloc..getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieResponse>(
      stream: nowPlayingMoviesBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null && snapshot.data!.error.length > 0) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildHomeWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text(
                  "No More Movies",
                  style: TextStyle(color: Colors.black45),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Text(
          //   "Now Playing",
          //   style: TextStyle(
          //       fontSize: 25,
          //       fontStyle: FontStyle.italic,
          //       fontWeight: FontWeight.bold,
          //       fontFamily: "Ultra",
          //       decoration: TextDecoration.underline,
          //       decorationThickness: 2),
          // ),
          Column(
            children: [
              Container(
                height: 200,
                child: PageIndicatorContainer(
                  align: IndicatorAlign.bottom,
                  length: movies.take(5).length,
                  indicatorSpace: 8.0,
                  padding: const EdgeInsets.all(5.0),
                  indicatorColor: Style.Colors.titleColor,
                  indicatorSelectorColor: Style.Colors.secondColor,
                  shape: IndicatorShape.circle(size: 6.5),
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.take(5).length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: <Widget>[
                            Hero(
                              tag: movies[index].id,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 260,
                                decoration: BoxDecoration(
                                  //borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/original/" +
                                              movies[index].backPoster)),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [
                                      0.0,
                                      0.9
                                    ],
                                    colors: [
                                      Style.Colors.mainColor.withOpacity(1.0),
                                      Style.Colors.mainColor.withOpacity(0.0)
                                    ]),
                              ),
                            ),
                            // const Positioned(
                            //   bottom: 0.0,
                            //   top: 0.0,
                            //   left: 0.0,
                            //   right: 0.0,
                            //   child: Icon(
                            //     FontAwesomeIcons.playCircle,
                            //     color: Style.Colors.secondColor,
                            //     size: 40.0,
                            //   ),
                            // ),
                            Positioned(
                              bottom: 30.0,
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                width: 250.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      movies[index].title,
                                      style: const TextStyle(
                                          height: 1.5,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
}
