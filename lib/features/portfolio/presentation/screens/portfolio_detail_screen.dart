import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../../domain/entities/portfolio.dart';

// 9. Presentation Layer: The new detail screen.
class PortfolioDetailScreen extends StatelessWidget {
  final Portfolio portfolio;
  const PortfolioDetailScreen({super.key, required this.portfolio});

  @override
  Widget build(BuildContext context) {
    // SizeConfig should be initialized by now
    final double size = SizeConfig.defultSize!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(portfolio.title),
        backgroundColor: AppColors.backgroundDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Image Carousel ---
            if (portfolio.images.isNotEmpty)
              CarouselSlider(
                options: CarouselOptions(
                  height: size * 15, // 15 * 24 = 360
                  autoPlay: true,
                  viewportFraction: 1.0, // Full width
                ),
                items: portfolio.images.map((imgUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.surfaceDark,
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                          // Loading indicator for images
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          // Error handler for images
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Icon(Icons.error, color: Colors.red));
                          },
                        ),
                      );
                    },
                  );
                }).toList(),
              )
            else
              // Fallback if no images
              Container(
                height: size * 15,
                color: AppColors.surfaceDark,
                child: const Center(
                    child: Icon(Icons.image_not_supported, size: 50)),
              ),

            // --- Description ---
            Padding(
              padding: EdgeInsets.all(size), // 24
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    portfolio.title,
                    style: textTheme.displaySmall?.copyWith(
                      color: AppColors.textWhite,
                    ),
                  ),
                  SizedBox(height: size * 0.5), // 12
                  const Divider(color: AppColors.primary),
                  SizedBox(height: size * 0.5), // 12
                  Text(
                    portfolio.description,
                    style:
                        textTheme.bodyLarge?.copyWith(fontSize: size * 0.75), // 18
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
