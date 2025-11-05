import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/localization/app_localizations.dart';
import 'core/navigation/app_router.dart';
import 'core/navigation/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/supabase_client.dart';

// Home (Contact Form)
import 'features/home/presentation/provider/home_provider.dart';

// Portfolio
import 'features/portfolio/data/datasources/portfolio_remote_datasource.dart';
import 'features/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'features/portfolio/domain/usecases/get_portfolio_list.dart';
import 'features/portfolio/presentation/provider/portfolio_provider.dart';

// Testimonials
import 'features/testimonials/data/datasources/testimonial_remote_datasource.dart';
import 'features/testimonials/data/repositories/testimonial_repository_impl.dart';
import 'features/testimonials/domain/usecases/get_testimonials.dart';
import 'features/testimonials/presentation/provider/testimonial_provider.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: SupabaseClientConfig.supabaseUrl,
    anonKey: SupabaseClientConfig.supabaseAnonKey,
  );

  runApp(const MyApp());
}

// Helper getter for Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MultiProvider to set up all your application-level providers
    return MultiProvider(
      providers: [
        // --- Home Provider (Contact Form) ---
        ChangeNotifierProvider(
          create: (context) => HomeProvider(supabaseClient: supabase),
        ),

        // --- Portfolio Provider ---
        ChangeNotifierProvider(
          create: (context) {
            // Setup dependencies for Portfolio
            final remoteSource =
                PortfolioRemoteDataSourceImpl(client: supabase);
            final repository =
                PortfolioRepositoryImpl(remoteDataSource: remoteSource);
            final usecase = GetPortfolioList(repository);
            return PortfolioProvider(getPortfolioList: usecase);
          },
        ),

        // --- Testimonial Provider ---
        ChangeNotifierProvider(
          create: (context) {
            // Setup dependencies for Testimonials
            final remoteSource =
                TestimonialRemoteDataSourceImpl(client: supabase);
            final repository =
                TestimonialRepositoryImpl(remoteDataSource: remoteSource);
            final usecase = GetTestimonials(repository);
            return TestimonialProvider(getTestimonials: usecase);
          },
        ),
      ],
      child: MaterialApp(
        title: 'Y&A Tech',
        debugShowCheckedModeBanner: false,

        // --- Theme ---
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark, // Defaulting to dark as per the website

        // --- Localization ---
        locale: const Locale('en'), // Default locale
        supportedLocales: const [
          Locale('en', ''), // English, no country code
          Locale('ar', ''), // Arabic, no country code
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first; // Default to English
        },

        // --- Navigation ---
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
