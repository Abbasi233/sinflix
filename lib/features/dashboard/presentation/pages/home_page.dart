import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../bloc/movie_bloc.dart';
import '../mixin/home_page_mixin.dart';
import '/core/widgets/refresh_indicator.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const FetchMoviesEvent());
  }

  Future<void> _onRefresh() async {
    context.read<MovieBloc>().add(const FetchMoviesEvent(page: 1));
  }

  Future<bool> _onLoading() async {
    final bloc = context.read<MovieBloc>();
    final state = bloc.state;

    if (state is! MoviesLoaded) return false;

    bloc.add(LoadMoreMoviesEvent(state.page + 1));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('dashboard.home'.tr())),
      body: AppRefreshIndicator(
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (previous, current) {
            switch (current) {
              case MovieLoading():
              case MovieError():
              case MoviesLoaded():
              case MovieFavorited():
                return true;
              default:
                return false;
            }
          },
          builder: (context, state) {
            if (state is MovieLoading) return buildMovieShimmer();

            if (state is MovieError) {
              return Center(
                child: Text(
                  state.message.tr(),
                  textAlign: TextAlign.center,
                ),
              );
            }

            switch (state) {
              case MoviesLoaded(:final movies):
                return buildMovieList(context, movies);
              case MovieFavorited(:final movies, :final movieId, :final isFavorited):
                return buildMovieList(context, movies, movieId: movieId, isFavorited: isFavorited);
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
