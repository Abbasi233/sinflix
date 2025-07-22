import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import '../../domain/entities/movie_entity.dart';

@RoutePage()
class MovieDetailPage extends StatelessWidget {
  final MovieEntity movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.poster.isNotEmpty)
              Center(
                child: Image.network(
                  movie.poster,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(movie.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('${movie.year} • ${movie.genre} • ${movie.runtime}'),
            const SizedBox(height: 8),
            Text('IMDB: ${movie.imdbRating}'),
            const SizedBox(height: 16),
            Text('Yönetmen: ${movie.director}'),
            const SizedBox(height: 4),
            Text('Oyuncular: ${movie.actors}'),
            const SizedBox(height: 16),
            Text('Açıklama:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(movie.plot),
            const SizedBox(height: 16),
            Text('Dil: ${movie.language}'),
            Text('Ülke: ${movie.country}'),
            Text('Ödüller: ${movie.awards}'),
            const SizedBox(height: 16),
            if (movie.images != null && movie.images!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ek Görseller:', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie.images!.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.images![index],
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
