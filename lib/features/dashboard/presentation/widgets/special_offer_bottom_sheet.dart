import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinflix/core/colors.dart';
import 'package:sinflix/core/extensions.dart';
import 'package:sinflix/core/widgets/app_main_button.dart';
import 'package:sinflix/core/asset_paths.dart';

class SpecialOfferBottomSheet extends StatelessWidget {
  final ScrollController? scrollController;
  const SpecialOfferBottomSheet({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.theme.brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(32),
        gradient: RadialGradient(
          colors: [
            const Color(0xFF6F060B),
            context.theme.scaffoldBackgroundColor,
          ],
          stops: [0.0, 0.2],
          radius: 2,
          focal: Alignment.topCenter,
          focalRadius: .15,
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Stack(
          children: [
            // Container(
            //   height: 200,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     gradient: RadialGradient(
            //       colors: [
            //         const Color(0xFF6F060B),
            //         context.theme.scaffoldBackgroundColor,
            //       ],
            //       stops: [0.0, 0.7],
            //       radius: 3,
            //       focal: Alignment.topCenter,
            //       focalRadius: .6,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sınırlı Teklif',
                    style: context.theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const Gap(12),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.width * 0.15),
                    child: Text(
                      'Jeton paketin’ni seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(12),
                  Container(
                    height: 173,
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkInputFill.withValues(alpha: .1) : AppColors.lightInputFill.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: isDarkMode ? AppColors.darkBorder : AppColors.lightBorder),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Gap(10),
                          Text(
                            'Alacağınız Bonuslar',
                            style: context.theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(14),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildBonus(context, AssetPaths.gemImg, 'Premium Hesap'),
                                _buildBonus(context, AssetPaths.heartImg, 'Daha Fazla Eşleşme'),
                                _buildBonus(context, AssetPaths.doubleHeartImg, 'Öne Çıkarma'),
                                _buildBonus(context, AssetPaths.arrowImg, 'Daha Fazla Beğeni'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(22),
                  Text(
                    "Kilidi açmak için bir jeton paketi seçin",
                    style: context.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  SizedBox(
                    height: 235,
                    child: Row(
                      spacing: 16,
                      children: [
                        _buildOffer(
                          context,
                          percent: 10,
                          oldJeton: 200,
                          newJeton: 330,
                          price: 99.99,
                        ),
                        _buildOffer(
                          context,
                          percent: 70,
                          oldJeton: 2000,
                          newJeton: 3375,
                          price: 799.99,
                          color: const Color(0xFF5949E6),
                        ),
                        _buildOffer(
                          context,
                          percent: 35,
                          oldJeton: 1000,
                          newJeton: 1350,
                          price: 399.99,
                        ),
                      ],
                    ),
                  ),
                  const Gap(18),
                  AppMainButton(context, onPressed: () {}, text: 'Tüm Jetonları Gör'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBonus(BuildContext context, String imgPath, String title) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox.square(
            dimension: 55,
            child: Stack(
              children: [
                Image.asset(AssetPaths.bonusBackground),
                Center(child: Image.asset(imgPath, width: 30, height: 30)),
              ],
            ),
          ),
          const Gap(13),
          Text(
            title,
            style: context.theme.textTheme.bodyMedium,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOffer(
    BuildContext context, {
    required num percent,
    required num oldJeton,
    required num newJeton,
    required num price,
    Color color = const Color(0xFF6F060B),
  }) {
    return Expanded(
      child: Stack(
        children: [
          Column(
            children: [
              const Gap(16),
              Container(
                height: 210,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white),
                  gradient: RadialGradient(
                    colors: [
                      color,
                      const Color(0xFFE50914),
                    ],
                    stops: [0.0, 0.7],
                    radius: 1.8,
                    focal: Alignment.topLeft,
                    focalRadius: .5,
                    // center: Alignment.topLeft,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            oldJeton.toString(),
                            style: context.theme.textTheme.titleMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Text(
                              newJeton.toString(),
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            'Jeton',
                            style: context.theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                    // const Gap(16),
                    Divider(
                      indent: 12,
                      endIndent: 12,
                      height: 2,
                      color: Colors.white.withValues(alpha: .4),
                    ),
                    const Gap(14),
                    Material(
                      color: Colors.transparent,
                      child: Text(
                        '₺${price.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      'Başına haftalık',
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(12),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: .3),
                gradient: RadialGradient(
                  radius: 6,
                  colors: [
                    color,
                    Colors.white,
                  ],
                  stops: [0.0, 0.7],
                ),
              ),
              child: Text(
                "+$percent%",
                style: context.theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
