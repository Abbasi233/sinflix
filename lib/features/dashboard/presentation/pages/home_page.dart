import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../features/theme/presentation/bloc/theme_cubit.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/refresh_indicator.dart';
import '../../domain/entities/movie_entity.dart';
import '../bloc/movie_bloc.dart';
import '../../../theme/presentation/bloc/theme_cubit.dart';
import '../widgets/movie_item.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieBloc>().add(const FetchMoviesEvent());
  }

  Future<void> _onRefresh() async {
    context.read<MovieBloc>().add(const FetchMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anasayfa'),
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.brightness_6),
            onSelected: (ThemeMode themeMode) {
              context.read<ThemeCubit>().changeTheme(themeMode);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ThemeMode.light,
                child: Text('Açık Tema'),
              ),
              const PopupMenuItem(
                value: ThemeMode.dark,
                child: Text('Koyu Tema'),
              ),
              const PopupMenuItem(
                value: ThemeMode.system,
                child: Text('Sistem'),
              ),
            ],
          ),
        ],
      ),
      body: BlocProvider<MovieBloc>(
        create: (context) => BlocProvider.of<MovieBloc>(context),
        child: AppRefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MoviesLoaded) {
                final movies = state.movies;
                if (movies.isEmpty) {
                  return const Center(child: Text('Film bulunamadı.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return MovieItem(
                      movie: movie,
                      onTap: () {
                        // Film detay sayfasına yönlendirme
                      },
                      onFavoriteTap: () {
                        // Favori ekleme/çıkarma işlemi
                        context.read<MovieBloc>().add(
                          FavoriteMovieEvent(movie.id),
                        );
                      },
                    );
                  },
                );
              } else if (state is MovieError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
