import 'package:flutter/material.dart';
import '../../features/portfolio/domain/entities/portfolio.dart';
import '../../features/portfolio/presentation/screens/portfolio_detail_screen.dart';
import 'app_routes.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/services/presentation/screens/services_screen.dart';
import '../../features/about_us/presentation/screens/about_us_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      // These routes are now handled by the shell, but you
      // could have standalone routes here too.
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.services:
      // --- تعديل ---
      // استقبال "الرقم" (index) عند طلب الصفحة
        final int? scrollToIndex = settings.arguments as int?;
        return MaterialPageRoute(
          builder: (_) => ServicesScreen(
            scrollToIndex: scrollToIndex,
          ),
        );
      case AppRoutes.about:
        return MaterialPageRoute(builder: (_) => const AboutUsScreen());

      // --- Handle New Route ---
      case AppRoutes.portfolioDetail:
        // We expect a Portfolio object to be passed as an argument
        final portfolioItem = settings.arguments as Portfolio?;
        if (portfolioItem != null) {
          return MaterialPageRoute(
            builder: (_) =>
                PortfolioDetailScreen(portfolio: portfolioItem),
          );
        }
        // Fallback for an error
        return _errorRoute(settings.name);

      default:
        return _errorRoute(settings.name);
    }
  }

  static Route<dynamic> _errorRoute(String? routeName) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for $routeName'),
        ),
      ),
    );
  }
}
