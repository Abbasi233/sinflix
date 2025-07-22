import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sinflix/features/dashboard/presentation/bloc/movie_bloc.dart';

import '/core/colors.dart';
import '/core/extensions.dart';
import '/core/asset_paths.dart';
import '/core/widgets/app_back_button.dart';
import '../../domain/entities/movie_entity.dart';
import 'package:easy_localization/easy_localization.dart';

@RoutePage()
class MovieDetailPage extends StatefulWidget {
  final MovieEntity movie;
  final String moviePoster;

  const MovieDetailPage({
    required this.movie,
    required this.moviePoster,
    super.key,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool? isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.movie.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: context.height * .8,
            leading: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: AppBackButton(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: Image.asset(AssetPaths.logoImg),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.movie.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.movie.plot,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                ],
              ),
              expandedTitleScale: 1,
              background: widget.moviePoster.isNotEmpty
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.moviePoster,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const SizedBox.shrink(),
                          errorWidget: (context, url, error) => const SizedBox.shrink(),
                        ),
                        Positioned(
                          bottom: 100,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              context.read<MovieBloc>().add(FavoriteMovieEvent(widget.movie.id));
                              setState(() {
                                isFavorite = !isFavorite!;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                              decoration: BoxDecoration(
                                color: AppColors.darkInputFill,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: isFavorite == true ? AppColors.accent : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              collapseMode: CollapseMode.parallax,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text('${widget.movie.year} • ${widget.movie.genre} • ${widget.movie.runtime}'),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dashboard.movie_detail.imdb'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: widget.movie.imdbRating,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dashboard.movie_detail.metascore'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: widget.movie.metascore,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.people, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dashboard.movie_detail.imdb_votes'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: widget.movie.imdbVotes,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.shield, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dashboard.movie_detail.age_rating'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: widget.movie.rated,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.event, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dashboard.movie_detail.release_date'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: widget.movie.released,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.movie_creation, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dashboard.movie_detail.director'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: widget.movie.director,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.edit, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'dashboard.movie_detail.writer'.tr(),
                                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                              ),
                              const TextSpan(text: '  '),
                              TextSpan(
                                text: widget.movie.writer,
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.theater_comedy, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'dashboard.movie_detail.actors'.tr(),
                                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                              ),
                              const TextSpan(text: '  '),
                              TextSpan(
                                text: widget.movie.actors,
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text('dashboard.movie_detail.description'.tr(), style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 26.0),
                    child: Text(widget.movie.plot, style: context.textTheme.bodyMedium),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.language, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dashboard.movie_detail.language'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: widget.movie.language,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.flag, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'dashboard.movie_detail.country'.tr(),
                              style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                            ),
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: widget.movie.country,
                              style: context.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.emoji_events, color: Colors.grey, size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'dashboard.movie_detail.awards'.tr(),
                                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                              ),
                              const TextSpan(text: '  '),
                              TextSpan(
                                text: widget.movie.awards,
                                style: context.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (widget.movie.comingSoon == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'dashboard.movie_detail.coming_soon'.tr(),
                        style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold),
                      ),
                    ),
                  const SizedBox(height: 16),
                  if (widget.movie.images != null && widget.movie.images!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('dashboard.movie_detail.extra_images'.tr(), style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 8),
                        Scrollbar(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            height: 300,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.movie.images!.length,
                              separatorBuilder: (_, _) => const SizedBox(width: 8),
                              itemBuilder: (context, index) => ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  widget.movie.images![index],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
