#!/bin/bash

# هذا الاسكريبت ينشئ هيكل المجلدات بالكامل
# ويملأ جميع الملفات بالكود النهائي للمشروع.

echo "جاري إنشاء مجلدات المشروع..."

# --- إنشاء المجلدات الأساسية ---
mkdir -p lib/core/assets
mkdir -p lib/core/constants
mkdir -p lib/core/localization/l10n
mkdir -p lib/core/navigation
mkdir -p lib/core/theme
mkdir -p lib/core/utils
mkdir -p lib/data/datasources

# --- إنشاء مجلدات الـ Features ---
mkdir -p lib/features/about_us/presentation/screens
mkdir -p lib/features/home/data/datasources
mkdir -p lib/features/home/data/repositories
mkdir -p lib/features/home/domain/repositories
mkdir -p lib/features/home/domain/usecases
mkdir -p lib/features/home/presentation/provider
mkdir -p lib/features/home/presentation/screens
mkdir -p lib/features/home/presentation/widgets
mkdir -p lib/features/services/presentation/screens
mkdir -p lib/features/shell

# --- إنشاء مجلدات الـ Features الجديدة ---
mkdir -p lib/features/portfolio/data/datasources
mkdir -p lib/features/portfolio/data/models
mkdir -p lib/features/portfolio/data/repositories
mkdir -p lib/features/portfolio/domain/entities
mkdir -p lib/features/portfolio/domain/repositories
mkdir -p lib/features/portfolio/domain/usecases
mkdir -p lib/features/portfolio/presentation/provider
mkdir -p lib/features/portfolio/presentation/screens

mkdir -p lib/features/testimonials/data/datasources
mkdir -p lib/features/testimonials/data/models
mkdir -p lib/features/testimonials/data/repositories
mkdir -p lib/features/testimonials/domain/entities
mkdir -p lib/features/testimonials/domain/repositories
mkdir -p lib/features/testimonials/domain/usecases
mkdir -p lib/features/testimonials/presentation/provider

# --- إنشاء مجلدات الـ Assets ---
mkdir -p assets/images
mkdir -p assets/icons

echo "جاري إنشاء وتعبئة ملفات المشروع..."

# --- lib/main.dart ---
echo "Creating lib/main.dart..."
cat <<'EOF' > lib/main.dart
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
        localizationsDelegates: const [
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
        initialRoute: AppRoutes.mainShell,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
EOF

# --- lib/data/datasources/supabase_client.dart ---
echo "Creating lib/data/datasources/supabase_client.dart..."
cat <<'EOF' > lib/data/datasources/supabase_client.dart
class SupabaseClientConfig {
  // -----------------------------------------------------------------
  // --- IMPORTANT: REPLACE WITH YOUR SUPABASE URL AND ANON KEY ---
  // -----------------------------------------------------------------
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  // -----------------------------------------------------------------
  // -----------------------------------------------------------------
}
EOF

# --- lib/core/localization/l10n/app_en.arb ---
echo "Creating lib/core/localization/l10n/app_en.arb..."
cat <<'EOF' > lib/core/localization/l10n/app_en.arb
{
    "@@locale": "en",
    "appTitle": "Y&A Tech",
    "navHome": "Home",
    "navServices": "Services",
    "navAbout": "About Us",
    "homeHeroTitle": "Crafting Digital Futures.",
    "homeHeroButton": "Let's Build Together",
    "homeSectionServices": "Our Services",
    "homeSectionPortfolio": "Portfolio",
    "homeSectionTestimonials": "Testimonials",
    "homeSectionContact": "Contact Us",
    "serviceWebTitle": "Web Development",
    "serviceWebDescription": "Creating responsive, high-performance websites and web apps that deliver exceptional user experiences.",
    "serviceAppTitle": "App Development",
    "serviceAppDescription": "Building native, cross-platform, and web-based mobile applications for iOS and Android.",
    "serviceAiTitle": "AI Services",
    "serviceAiDescription": "Leveraging AI services for business automation, data-driven insights, and intelligent solutions.",
    "serviceBrandingTitle": "Branding",
    "serviceBrandingDescription": "Creating powerful brand identities that resonate with your target audience.",
    "contactFormNameHint": "Name",
    "contactFormEmailHint": "Email",
    "contactFormMessageHint": "Message",
    "contactFormButtonSend": "Send Message",
    "contactFormSuccess": "Message sent successfully!",
    "contactFormError": "Failed to send message. Please try again.",

    "aboutHeroTitle": "We build tech for your company.",
    "aboutHeroSubtitle": "Websites, Apps, and AI.",
    "aboutMissionTitle": "Our Mission",
    "aboutMissionDescription": "We build websites, apps, and AI to help your business win.",
    
    "aboutValuesTitle": "Our Values",
    "aboutValuesSubtitle": "At Y&A Tech, our values are the cornerstone of our culture and the driving force behind our success. They guide our decisions, our interactions, and our innovations.",
    "valueInnovation": "Innovation",
    "valueReliability": "Reliability",
    "valueCreativity": "Creativity",
    "aboutTeamTitle": "Meet the Minds Behind Y&A Tech"
}
EOF

# --- lib/core/localization/l10n/app_ar.arb ---
echo "Creating lib/core/localization/l10n/app_ar.arb..."
cat <<'EOF' > lib/core/localization/l10n/app_ar.arb
{
    "@@locale": "ar",
    "appTitle": "واي أند إيه تك",
    "navHome": "الرئيسية",
    "navServices": "خدماتنا",
    "navAbout": "عنا",
    "homeHeroTitle": "صياغة المستقبل الرقمي.",
    "homeHeroButton": "لنبدأ البناء معًا",
    "homeSectionServices": "خدماتنا",
    "homeSectionPortfolio": "أعمالنا",
    "homeSectionTestimonials": "آراء العملاء",
    "homeSectionContact": "تواصل معنا",
    "serviceWebTitle": "تطوير الويب",
    "serviceWebDescription": "إنشاء مواقع وتطبيقات ويب سريعة الاستجابة وعالية الأداء تقدم تجارب مستخدم استثنائية.",
    "serviceAppTitle": "تطوير التطبيقات",
    "serviceAppDescription": "بناء تطبيقات هواتف ذكية أصلية ومتعددة المنصات ومتصفح ويب لأنظمة iOS و Android.",
    "serviceAiTitle": "خدمات الذكاء الاصطناعي",
    "serviceAiDescription": "الاستفادة من خدمات الذكاء الاصطناعي لأتمتة الأعمال والحصول على رؤى قائمة على البيانات وحلول ذكية.",
    "serviceBrandingTitle": "العلامات التجارية",
    "serviceBrandingDescription": "إنشاء هويات تجارية قوية تتردد أصداؤها مع جمهورك المستهدف.",
    "contactFormNameHint": "الاسم",
    "contactFormEmailHint": "البريد الإلكتروني",
    "contactFormMessageHint": "رسالتك",
    "contactFormButtonSend": "إرسال الرسالة",
    "contactFormSuccess": "تم إرسال الرسالة بنجاح!",
    "contactFormError": "فشل إرسال الرسالة. يرجى المحاولة مرة أخرى.",

    "aboutHeroTitle": "تقنية لشركتك.",
    "aboutHeroSubtitle": "مواقع، تطبيقات، وذكاء اصطناعي.",
    "aboutMissionTitle": "مهمتنا",
    "aboutMissionDescription": "نبني مواقع وتطبيقات وذكاء اصطناعي لمساعدة شركتك على الفوز.",

    "aboutValuesTitle": "قيمنا",
    "aboutValuesSubtitle": "في Y&A Tech، قيمنا هي حجر الزاوية في ثقافتنا والقوة الدافعة وراء نجاحنا. إنها توجه قراراتنا وتفاعلاتنا وابتكاراتنا.",
    "valueInnovation": "الابتكار",
    "valueReliability": "الموثوقية",
    "valueCreativity": "الإبداع",
    "aboutTeamTitle": "تعرف على العقول المدبرة في Y&A Tech"
}
EOF

# --- lib/core/localization/app_localizations.dart ---
echo "Creating lib/core/localization/app_localizations.dart..."
cat <<'EOF' > lib/core/localization/app_localizations.dart
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// A simple helper class to access the localization strings
// This makes it easy to call from anywhere in the app
// e.g., s.navHome
class S {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }
}

// Export the delegate for use in main.dart
const LocalizationsDelegate<AppLocalizations> appLocalizationsDelegate =
    AppLocalizations.delegate;
EOF

# --- lib/core/theme/app_colors.dart ---
echo "Creating lib/core/theme/app_colors.dart..."
cat <<'EOF' > lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // --- Main Colors ---
  static const Color primary = Color(0xFF13ECEC);
  
  // --- Backgrounds ---
  static const Color backgroundDark = Color(0xFF102222);
  static const Color backgroundLight = Color(0xFFF5F5F5);

  // --- Card/Surface Colors ---
  static const Color surfaceDark = Color(0xFF193333); // For dark cards
  static const Color surfaceDarkLighter = Color(0xFF1F3E3E); // For dark hover
  static const Color surfaceLight = Color(0xFFFFFFFF);
  
  // --- Text Colors ---
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF333333);
  static const Color textLightDark = Color(0xFF555555); // Subtitles light
  static const Color textLight = Color(0xFFE0E0E0); // Main text dark
  static const Color textMedium = Color(0xFF92C9C9); // Subtitles dark
}
EOF

# --- lib/core/theme/app_theme.dart ---
echo "Creating lib/core/theme/app_theme.dart..."
cat <<'EOF' > lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // --- Base Text Theme ---
  static final TextTheme _baseTextTheme = GoogleFonts.spaceGroteskTextTheme();

  // --- Dark Theme ---
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    
    // Use colorScheme for modern theming
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      background: AppColors.backgroundDark,
      surface: AppColors.surfaceDark,
      onPrimary: AppColors.backgroundDark, // Text on primary buttons
      onBackground: AppColors.textLight,   // Main body text
      onSurface: AppColors.textWhite,      // Text on cards
      error: Colors.redAccent,
      onError: AppColors.textWhite,
    ),

    // App Bar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundDark.withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: _baseTextTheme.titleLarge?.copyWith(
        color: AppColors.textWhite,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: AppColors.textWhite),
    ),

    // Text Theme
    textTheme: _baseTextTheme.copyWith(
      // Headlines
      displayLarge: _baseTextTheme.displayLarge?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      displayMedium: _baseTextTheme.displayMedium?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      displaySmall: _baseTextTheme.displaySmall?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      headlineSmall: _baseTextTheme.headlineSmall?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      
      // Titles
      titleLarge: _baseTextTheme.titleLarge?.copyWith(color: AppColors.textWhite, fontWeight: FontWeight.bold),
      titleMedium: _baseTextTheme.titleMedium?.copyWith(color: AppColors.textWhite),
      
      // Body
      bodyLarge: _baseTextTheme.bodyLarge?.copyWith(color: AppColors.textLight),
      bodyMedium: _baseTextTheme.bodyMedium?.copyWith(color: AppColors.textMedium),

    ).apply(
      bodyColor: AppColors.textLight,
      displayColor: AppColors.textWhite,
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.backgroundDark,
        textStyle: _baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textWhite,
        side: const BorderSide(color: AppColors.primary),
        textStyle: _baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black.withOpacity(0.2),
      hintStyle: _baseTextTheme.bodyLarge?.copyWith(color: AppColors.textMedium),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
    
    // Bottom Nav Bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark.withOpacity(0.9),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textMedium,
      selectedLabelStyle: _baseTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: _baseTextTheme.bodySmall,
      type: BottomNavigationBarType.fixed,
    ),
  );

  // --- Light Theme (Scaffold) ---
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primary,
      background: AppColors.backgroundLight,
      surface: AppColors.surfaceLight,
      onPrimary: AppColors.backgroundDark,
      onBackground: AppColors.textDark,
      onSurface: AppColors.textDark,
      error: Colors.red,
      onError: AppColors.textWhite,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundLight.withOpacity(0.8),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: _baseTextTheme.titleLarge?.copyWith(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(color: AppColors.textDark),
    ),

    textTheme: _baseTextTheme.copyWith(
      displayLarge: _baseTextTheme.displayLarge?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      displayMedium: _baseTextTheme.displayMedium?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      displaySmall: _baseTextTheme.displaySmall?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      headlineSmall: _baseTextTheme.headlineSmall?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      titleLarge: _baseTextTheme.titleLarge?.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold),
      titleMedium: _baseTextTheme.titleMedium?.copyWith(color: AppColors.textDark),
      bodyLarge: _baseTextTheme.bodyLarge?.copyWith(color: AppColors.textDark),
      bodyMedium: _baseTextTheme.bodyMedium?.copyWith(color: AppColors.textLightDark),
    ).apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.backgroundDark,
        textStyle: _baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textDark,
        side: const BorderSide(color: AppColors.primary),
        textStyle: _baseTextTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: AppColors.surfaceLight,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.black.withOpacity(0.1)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      hintStyle: _baseTextTheme.bodyLarge?.copyWith(color: AppColors.textLightDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    ),
    
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundLight.withOpacity(0.9),
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textLightDark,
      selectedLabelStyle: _baseTextTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: _baseTextTheme.bodySmall,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
EOF

# --- lib/core/assets/app_images.dart ---
echo "Creating lib/core/assets/app_images.dart..."
cat <<'EOF' > lib/core/assets/app_images.dart
class AppImages {
  // --- Base Path ---
  static const String _base = 'assets/images/';

  // --- Placeholders (Replace with actual assets) ---
  static const String heroBackground = '${_base}hero_background.png';
}
EOF

# --- lib/core/assets/app_icons.dart ---
echo "Creating lib/core/assets/app_icons.dart..."
cat <<'EOF' > lib/core/assets/app_icons.dart
class AppIcons {
  // --- Base Path ---
  static const String _base = 'assets/icons/';

  // --- Social Icons ---
  // (Make sure you add these files to assets/icons/ folder)
  static const String facebook = '${_base}facebook.svg';
  static const String instagram = '${_base}instagram.svg';
  static const String linkedin = '${_base}linkedin.svg';
  static const String whatsapp = '${_base}whatsapp.svg';
}
EOF

# --- lib/core/constants/social_links.dart ---
echo "Creating lib/core/constants/social_links.dart..."
cat <<'EOF' > lib/core/constants/social_links.dart
class SocialLinks {
  // --- IMPORTANT: REPLACE WITH YOUR ACTUAL URLS ---
  static const String facebook = 'https://www.facebook.com/your-page';
  static const String instagram = 'https://www.instagram.com/your-profile';
  static const String linkedin = 'https://www.linkedin.com/in/your-profile';
  static const String whatsapp = 'https://wa.me/YOURPHONENUMBER'; // e.g. +201000000000
}
EOF

# --- lib/core/utils/size_config.dart ---
echo "Creating lib/core/utils/size_config.dart..."
cat <<'EOF' > lib/core/utils/size_config.dart
import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double? defultSize;
  static Orientation? orientation;
  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    orientation = MediaQuery.of(context).orientation;
    defultSize = orientation == Orientation.landscape
        ? screenHeight! * 0.024
        : screenWidth! * 0.024;
  }
}
EOF

# --- lib/core/navigation/app_routes.dart ---
echo "Creating lib/core/navigation/app_routes.dart..."
cat <<'EOF' > lib/core/navigation/app_routes.dart
class AppRoutes {
  static const String mainShell = '/';
  static const String home = '/home';
  static const String services = '/services';
  static const String about = '/about';
  
  // --- New Route ---
  static const String portfolioDetail = '/portfolio-detail';
}
EOF

# --- lib/core/navigation/app_router.dart ---
echo "Creating lib/core/navigation/app_router.dart..."
cat <<'EOF' > lib/core/navigation/app_router.dart
import 'package:flutter/material.dart';
import '../../features/portfolio/domain/entities/portfolio.dart';
import '../../features/portfolio/presentation/screens/portfolio_detail_screen.dart';
import 'app_routes.dart';
import '../../features/shell/main_navigation_shell.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/services/presentation/screens/services_screen.dart';
import '../../features/about_us/presentation/screens/about_us_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.mainShell:
        return MaterialPageRoute(builder: (_) => const MainNavigationShell());

      // These routes are now handled by the shell, but you
      // could have standalone routes here too.
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.services:
        return MaterialPageRoute(builder: (_) => const ServicesScreen());
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
EOF

# --- lib/features/shell/main_navigation_shell.dart ---
echo "Creating lib/features/shell/main_navigation_shell.dart..."
cat <<'EOF' > lib/features/shell/main_navigation_shell.dart
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/localization/app_localizations.dart';
import '../../core/utils/size_config.dart'; // Import SizeConfig
import '../home/presentation/screens/home_screen.dart';
import '../services/presentation/screens/services_screen.dart';
import '../about_us/presentation/screens/about_us_screen.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ServicesScreen(),
    AboutUsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- Initialize SizeConfig HERE ---
    // This ensures it's set once when the app's main shell builds.
    SizeConfig.init(context);
    // ----------------------------------

    // Get localized strings
    final s = S.of(context);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Symbols.home_rounded),
            label: s.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Symbols.grid_view_rounded),
            label: s.navServices,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Symbols.info_rounded),
            label: s.navAbout,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
EOF

# --- lib/features/home/presentation/screens/home_screen.dart ---
echo "Creating lib/features/home/presentation/screens/home_screen.dart..."
cat <<'EOF' > lib/features/home/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Required for social icons
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart'; // Import Provider
import 'package:url_launcher/url_launcher.dart'; // Required for social icons
import '../../../../core/assets/app_icons.dart'; // Required for social icons
import '../../../../core/constants/social_links.dart'; // Required for social icons
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/navigation/app_routes.dart'; // Import routes
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/size_config.dart'; // Import SizeConfig
import '../../../portfolio/domain/entities/portfolio.dart'; // Import Portfolio entity
import '../../../portfolio/presentation/provider/portfolio_provider.dart'; // Import Portfolio provider
import '../../../testimonials/domain/entities/testimonial.dart'; // Import Testimonial entity
import '../../../testimonials/presentation/provider/testimonial_provider.dart'; // Import Testimonial provider
import '../widgets/contact_form_section.dart';

// 1. Convert to StatefulWidget to fetch data on init
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // 2. Fetch data when the screen is first loaded
    // We use listen: false inside initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  void _fetchData() {
    // Use listen: false because we are in initState (or a function called by it)
    Provider.of<PortfolioProvider>(context, listen: false).fetchPortfolioItems();
    Provider.of<TestimonialProvider>(context, listen: false).fetchTestimonials();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    // 3. Get SizeConfig (it must be initialized in MainNavigationShell)
    final double size = SizeConfig.defultSize!;

    // 4. Watch providers to rebuild when data changes
    final portfolioProvider = context.watch<PortfolioProvider>();
    final testimonialProvider = context.watch<TestimonialProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            leading: Icon(Symbols.hub_rounded,
                color: AppColors.primary, size: size * 1.33), // 32
            title: Text(s.appTitle, style: textTheme.titleLarge),
            centerTitle: false,
          ),

          // --- Hero Section ---
          SliverToBoxAdapter(
            child: Container(
              height: size * 20, // 480
              width: double.infinity,
              padding: EdgeInsets.all(size), // 24
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuCfw09ccU1Z9DbNM8DPE6IN1npUHtZGSMFZhbNBUh3JJZ--D31bJ0HtfKE6btjdIVZlO1l0jwnAPh2WY6T7yqjZdIYDnq2_bgEjv94NBn26yBRdt98B4O1xgrg1_8ESfhH-aKyP0tvCb3tyDxktEfkDhGfEvW90FYig8gQyCNgbrQlBw__y2_hD8R_Dcz4Oicj-xElwVnHfFHy9AP_ywiBlCxDrQTGvRwrtKnVAVMSIywa0eh73po5_Km7h0Ehzd5nqsQX3ywXr1Kc"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    s.homeHeroTitle,
                    textAlign: TextAlign.center,
                    style: textTheme.displayMedium?.copyWith(
                      color: AppColors.textWhite,
                      fontSize: size * 2, // 48
                    ),
                  ),
                  SizedBox(height: size), // 24
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: size, // 24
                        vertical: size * 0.75, // 18
                      ),
                      textStyle: TextStyle(fontSize: size * 0.75), // 18
                    ),
                    onPressed: () {},
                    child: Text(s.homeHeroButton),
                  ),
                ],
              ),
            ),
          ),

          // --- Services Overview Section ---
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, s.homeSectionServices, size),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: size * 6.25, // 150
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: size * 0.66), // 16
                children: [
                  _buildServiceOverviewCard(
                      context, Symbols.web, s.serviceWebTitle, size),
                  _buildServiceOverviewCard(context, Symbols.phone_iphone,
                      s.serviceAppTitle, size),
                  _buildServiceOverviewCard(context, Symbols.auto_awesome,
                      s.serviceAiTitle, size),
                  _buildServiceOverviewCard(
                      context, Symbols.palette, s.serviceBrandingTitle, size),
                ],
              ),
            ),
          ),

          // --- Portfolio Section (Dynamic) ---
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, s.homeSectionPortfolio, size),
          ),
          _buildPortfolioList(context, portfolioProvider, size),

          // --- Testimonials Section (Dynamic) ---
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, s.homeSectionTestimonials, size),
          ),
          _buildTestimonialList(context, testimonialProvider, size),

          // --- Contact Form Section ---
          SliverToBoxAdapter(
            child: _buildSectionHeader(context, s.homeSectionContact, size),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(size * 0.66), // 16
              child: const ContactFormSection(),
            ),
          ),

          // --- Social Links Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size), // 24
              child: _buildSocialLinks(context, size),
            ),
          ),

          // Footer padding
          SliverToBoxAdapter(child: SizedBox(height: size * 1.66)), // 40
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You would need a ScrollController for this to work
        },
        child: const Icon(Symbols.arrow_upward),
      ),
    );
  }

  // --- Dynamic Portfolio List Builder ---
  Widget _buildPortfolioList(
      BuildContext context, PortfolioProvider provider, double size) {
    if (provider.isLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (provider.items.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text("No portfolio items found.")),
      );
    }

    return SliverList.list(
      children: provider.items.map((portfolioItem) {
        return _buildPortfolioCard(
          context,
          portfolioItem,
          size,
        );
      }).toList(),
    );
  }

  // --- Dynamic Testimonial List Builder ---
  Widget _buildTestimonialList(
      BuildContext context, TestimonialProvider provider, double size) {
    if (provider.isLoading) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: size * 7.5, // 180
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (provider.items.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: size * 7.5, // 180
          child: const Center(child: Text("No testimonials found.")),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: SizedBox(
        height: size * 7.5, // 180
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size * 0.66), // 16
          itemCount: provider.items.length,
          itemBuilder: (context, index) {
            final testimonial = provider.items[index];
            return _buildTestimonialCard(
              context,
              testimonial,
              size,
            );
          },
        ),
      ),
    );
  }

  // --- Helper to open social URLs ---
  Future<void> _launchSocialURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      print('Could not launch $url');
    }
  }

  // --- Helper to build the row of social icons ---
  Widget _buildSocialLinks(BuildContext context, double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(AppIcons.facebook, SocialLinks.facebook, size),
        _buildSocialIcon(AppIcons.instagram, SocialLinks.instagram, size),
        _buildSocialIcon(AppIcons.linkedin, SocialLinks.linkedin, size),
        _buildSocialIcon(AppIcons.whatsapp, SocialLinks.whatsapp, size),
      ],
    );
  }

  // --- Helper for a single social icon ---
  Widget _buildSocialIcon(String iconPath, String url, double size) {
    return IconButton(
      icon: SvgPicture.asset(
        iconPath,
        width: size, // 24
        height: size, // 24
        colorFilter: const ColorFilter.mode(
          Colors.transparent,
          BlendMode.dstOver, // Use dstOver to show original color
        ),
      ),
      onPressed: () => _launchSocialURL(url),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, double size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          size * 0.66, size, size * 0.66, size * 0.66), // 16, 24, 16, 16
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }

  Widget _buildServiceOverviewCard(
      BuildContext context, IconData icon, String title, double size) {
    return Container(
      width: size * 6.66, // 160
      margin: EdgeInsets.only(right: size * 0.5), // 12
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(size * 0.5), // 12
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary, size: size * 1.66), // 40
          SizedBox(height: size * 0.66), // 16
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioCard(
      BuildContext context, Portfolio portfolioItem, double size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size * 0.66, vertical: size * 0.33), // 16, 8
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          // 5. Add navigation
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.portfolioDetail,
              arguments: portfolioItem,
            );
          },
          child: SizedBox(
            height: size * 8.33, // 200
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  portfolioItem.mainImage, // Use data from provider
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                        child: Icon(Icons.error, color: Colors.red));
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8)
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: size * 0.66, // 16
                  left: size * 0.66, // 16
                  right: size * 0.66, // 16
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        portfolioItem.title, // Use data from provider
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColors.textWhite),
                      ),
                      Text(
                        portfolioItem.description, // Use data from provider
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.textLight),
                        maxLines: 1, // Keep it short
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(
      BuildContext context, Testimonial testimonial, double size) {
    return Container(
      width: size * 12.5, // 300
      margin: EdgeInsets.only(right: size * 0.5), // 12
      padding: EdgeInsets.all(size * 0.66), // 16
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        borderRadius: BorderRadius.circular(size * 0.5), // 12
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              '"${testimonial.quote}"', // Use data from provider
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: size * 0.66), // 16
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  testimonial.name, // Use data from provider
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  testimonial.title, // Use data from provider
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
EOF

# --- lib/features/home/presentation/widgets/contact_form_section.dart ---
echo "Creating lib/features/home/presentation/widgets/contact_form_section.dart..."
cat <<'EOF' > lib/features/home/presentation/widgets/contact_form_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/utils/size_config.dart';
import '../provider/home_provider.dart';

class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final s = S.of(context);
      final provider = context.read<HomeProvider>();

      final success = await provider.submitContactForm(
        name: _nameController.text,
        email: _emailController.text,
        message: _messageController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success ? s.contactFormSuccess : s.contactFormError),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );

        if (success) {
          _formKey.currentState?.reset();
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final provider = context.watch<HomeProvider>(); // Watch for loading state
    final double size = SizeConfig.defultSize!;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(hintText: s.contactFormNameHint),
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Please enter your name' : null,
          ),
          SizedBox(height: size * 0.66), // 16
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(hintText: s.contactFormEmailHint),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => (value == null ||
                    !value.contains('@') ||
                    !value.contains('.'))
                ? 'Please enter a valid email'
                : null,
          ),
          SizedBox(height: size * 0.66), // 16
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(hintText: s.contactFormMessageHint),
            maxLines: 4,
            validator: (value) => (value == null || value.isEmpty)
                ? 'Please enter your message'
                : null,
          ),
          SizedBox(height: size), // 24
          provider.isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(s.contactFormButtonSend),
                  ),
                ),
        ],
      ),
    );
  }
}
EOF

# --- lib/features/home/presentation/provider/home_provider.dart ---
echo "Creating lib/features/home/presentation/provider/home_provider.dart..."
cat <<'EOF' > lib/features/home/presentation/provider/home_provider.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/usecases/submit_contact_form.dart';
import '../../data/datasources/contact_remote_datasource.dart';
import '../../data/repositories/contact_repository_impl.dart';

class HomeProvider extends ChangeNotifier {
  late final SubmitContactForm _submitContactForm;

  HomeProvider({required SupabaseClient supabaseClient}) {
    // --- Dependency Injection (Manual) ---
    final remoteDataSource = ContactRemoteDataSourceImpl(client: supabaseClient);
    final repository = ContactRepositoryImpl(remoteDataSource: remoteDataSource);
    _submitContactForm = SubmitContactForm(repository: repository);
    // -------------------------------------
  }
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> submitContactForm({
    required String name,
    required String email,
    required String message,
  }) async {
    _setLoading(true);
    
    final result = await _submitContactForm(
      ContactFormParams(name: name, email: email, message: message),
    );

    _setLoading(false);
    return result; 
  }
}
EOF

# --- lib/features/home/domain/usecases/submit_contact_form.dart ---
echo "Creating lib/features/home/domain/usecases/submit_contact_form.dart..."
cat <<'EOF' > lib/features/home/domain/usecases/submit_contact_form.dart
import '../repositories/contact_repository.dart';

// Usecase: Connects Presentation (Provider) to Domain (Repository)
class SubmitContactForm {
  final ContactRepository repository;

  SubmitContactForm({required this.repository});

  // Call method to execute the use case
  Future<bool> call(ContactFormParams params) async {
    try {
      await repository.submitForm(
        name: params.name,
        email: params.email,
        message: params.message,
      );
      return true;
    } catch (e) {
      // In a real app, return a Failure object
      print('SubmitContactForm Usecase Error: $e');
      return false;
    }
  }
}

// Parameters object for the use case
class ContactFormParams {
  final String name;
  final String email;
  final String message;

  ContactFormParams({
    required this.name,
    required this.email,
    required this.message,
  });
}
EOF

# --- lib/features/home/domain/repositories/contact_repository.dart ---
echo "Creating lib/features/home/domain/repositories/contact_repository.dart..."
cat <<'EOF' > lib/features/home/domain/repositories/contact_repository.dart
// Abstract interface (the "contract") defined in the Domain layer
abstract class ContactRepository {
  Future<void> submitForm({
    required String name,
    required String email,
    required String message,
  });
}
EOF

# --- lib/features/home/data/repositories/contact_repository_impl.dart ---
echo "Creating lib/features/home/data/repositories/contact_repository_impl.dart..."
cat <<'EOF' > lib/features/home/data/repositories/contact_repository_impl.dart
import '../datasources/contact_remote_datasource.dart';
import '../../domain/repositories/contact_repository.dart';

// Implementation of the repository in the Data layer
class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> submitForm({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      await remoteDataSource.submitContactForm(
        name: name,
        email: email,
        message: message,
      );
    } catch (e) {
      print('ContactRepositoryImpl Error: $e');
      rethrow;
    }
  }
}
EOF

# --- lib/features/home/data/datasources/contact_remote_datasource.dart ---
echo "Creating lib/features/home/data/datasources/contact_remote_datasource.dart..."
cat <<'EOF' > lib/features/home/data/datasources/contact_remote_datasource.dart
import 'package:supabase_flutter/supabase_flutter.dart';

// Abstract interface for the data source
abstract class ContactRemoteDataSource {
  Future<void> submitContactForm({
    required String name,
    required String email,
    required String message,
  });
}

// Implementation using Supabase Edge Function
class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final SupabaseClient client;
  final String _functionName = 'send-contact-email';

  ContactRemoteDataSourceImpl({required this.client});

  @override
  Future<void> submitContactForm({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final body = {
        'name': name,
        'email': email,
        'message': message,
      };
      
      // Call the edge function
      await client.functions.invoke(_functionName, body: body);

    } on FunctionException catch (e) {
      // Handle Supabase Function-specific errors
      print('Supabase Function Error: ${e.message}');
      rethrow;
    } catch (e) {
      // Handle other errors
      print('ContactRemoteDataSource Error: $e');
      rethrow;
    }
  }
}
EOF

# --- lib/features/services/presentation/screens/services_screen.dart ---
echo "Creating lib/features/services/presentation/screens/services_screen.dart..."
cat <<'EOF' > lib/features/services/presentation/screens/services_screen.dart
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    // Use SizeConfig
    final double size = SizeConfig.defultSize!;

    return Scaffold(
      appBar: AppBar(
        title: Text(s.navServices),
      ),
      body: ListView(
        padding: EdgeInsets.all(size * 0.66), // 16
        children: [
          Text(
            s.navServices,
            textAlign: TextAlign.center,
            style: textTheme.displaySmall,
          ),
          SizedBox(height: size * 0.33), // 8
          Text(
            "We craft digital solutions to propel your business forward.", // This string is missing from .arb, adding manually
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge,
          ),
          SizedBox(height: size), // 24

          // --- Service Cards ---
          _buildServiceCard(
            context: context,
            icon: Symbols.language_rounded,
            title: s.serviceWebTitle,
            description: s.serviceWebDescription,
            size: size,
          ),
          _buildServiceCard(
            context: context,
            icon: Symbols.smartphone_rounded,
            title: s.serviceAppTitle,
            description: s.serviceAppDescription,
            size: size,
          ),
          _buildServiceCard(
            context: context,
            icon: Symbols.psychology_rounded,
            title: s.serviceAiTitle,
            description: s.serviceAiDescription,
            size: size,
          ),
          _buildServiceCard(
            context: context,
            icon: Symbols.palette_rounded,
            title: s.serviceBrandingTitle,
            description: s.serviceBrandingDescription,
            size: size,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required double size,
  }) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: size * 0.66), // 16
      child: Padding(
        padding: EdgeInsets.all(size), // 24
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: size * 1.66), // 40
            SizedBox(height: size * 0.66), // 16
            Text(title, style: textTheme.titleLarge),
            SizedBox(height: size * 0.33), // 8
            Text(description, style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.7)
            )),
            SizedBox(height: size), // 24
            OutlinedButton(
              onPressed: () {
                // TODO: Navigate to service detail page
              },
              child: const Text("Learn More"), // TODO: Localize
            ),
          ],
        ),
      ),
    );
  }
}
EOF

# --- lib/features/about_us/presentation/screens/about_us_screen.dart ---
echo "Creating lib/features/about_us/presentation/screens/about_us_screen.dart..."
cat <<'EOF' > lib/features/about_us/presentation/screens/about_us_screen.dart
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/size_config.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final double size = SizeConfig.defultSize!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(s.navAbout),
            expandedHeight: size * 12.5, // 300
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(
                horizontal: size * 2,
                vertical: size * 0.5,
              ),
              centerTitle: true,
              title: Text(
                s.aboutHeroTitle,
                style: textTheme.titleLarge?.copyWith(
                  color: AppColors.textWhite,
                  fontSize: size * 0.75, // 18
                ),
                textAlign: TextAlign.center,
              ),
              background: Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  image: DecorationImage(
                    image: const NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuA73PRZUtOR2eHcy-xgR78UIlzNRHn3Y4Xnr3z-lhOsHNlqlv8NTf-LuxZwwMAlKuPxPkCkmP3_9PcbUSUkQ6I5hGvUncDoAmBmiLmndW_c3VNVKQLCupLL7sNAYmB_7xLOK4qMq1VsL0DiLb-4YCFldHBBuoC3Dsv3cdyW0kWgrC3DMALE2p6awwEHHfCKSuHFZf1JtMjrMSAtR6WxDqXihxcTwD9zULFLauNnHc_uXuDfW8-Uxc5aLUCMuhazbXVA8Cc_RjhUuu0"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(size * 0.66), // 16
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        s.aboutHeroTitle,
                        style: textTheme.displaySmall?.copyWith(color: AppColors.textWhite),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: size * 0.33), // 8
                       Text(
                        s.aboutHeroSubtitle,
                        style: textTheme.titleMedium?.copyWith(
                          color: AppColors.textLight,
                          fontSize: size * 0.85, // 20
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- Our Mission Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(size), // 24
              child: Column(
                children: [
                  Text(s.aboutMissionTitle, style: textTheme.headlineSmall, textAlign: TextAlign.center),
                  SizedBox(height: size * 0.33), // 8
                  Text(
                    s.aboutMissionDescription,
                    style: textTheme.bodyLarge?.copyWith(fontSize: size * 0.75), // 18
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // --- Our Values Section ---
          SliverToBoxAdapter(
            child: Container(
              color: colorScheme.surface.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: size * 1.33, horizontal: size * 0.66), // 32, 16
              child: Column(
                children: [
                  Text(s.aboutValuesTitle, style: textTheme.headlineSmall, textAlign: TextAlign.center),
                  SizedBox(height: size * 0.33), // 8
                  Text(
                    s.aboutValuesSubtitle,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size), // 24
                  // Using a Wrap for responsiveness on different screen sizes
                  Wrap(
                    spacing: size * 0.66, // 16
                    runSpacing: size * 0.66, // 16
                    alignment: WrapAlignment.center,
                    children: [
                      _buildValueCard(context, Symbols.lightbulb, s.valueInnovation, "Pushing boundaries with cutting-edge technology.", size),
                      _buildValueCard(context, Symbols.shield, s.valueReliability, "Building robust and dependable solutions.", size),
                      _buildValueCard(context, Symbols.palette, s.valueCreativity, "Designing unique and engaging digital experiences.", size),
                    ],
                  )
                ],
              ),
            ),
          ),

          // --- Team Section ---
           SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(size), // 24
              child: Column(
                children: [
                  Text(s.aboutTeamTitle, style: textTheme.headlineSmall, textAlign: TextAlign.center),
                  SizedBox(height: size), // 24
                  _buildTeamMemberCard(
                    context, 
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuALlDl1u6GnPZ8SFKcdUyl0rKxGX38kjsFX_Uazjw2L49zRnZwueXd5ZJNDMKBHPFcZBCP3a06GxiXgyPdKu_NYv5jn39dwMmJnAZhpqSChqgLOW52JvcGci5M5J0Uk-tcq-K4oUD7N12QSnhnHaV035BHSD1cEXtJvaekwIhJyjR_0DJ8RB2iDsy0QAXqrdGDZFDQnXNkqBXLb256YP50kmYuVzwn-Dwkr7DB9JsVqHeB9e8qoxVIJ4ppnyUbZXn8llJcx_pMhe8w", 
                    "John Doe", 
                    "CEO & Founder", 
                    "John drives the company's vision, strategy, and growth.",
                    size
                  ),
                  _buildTeamMemberCard(
                    context, 
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuDzDkOizhWOfPpV-bvqNdSvFr8e4lqE1r4HKYj1GiRxnd_Z6fmulDvF-5Q9ZH2KG6RSY_kig5vz15omimxjRGDqLy6FVPSPUHnlecw20gxXgSAulGYtqX233AX--pIx8VMG9weYLqxBeWn6SMJv2oEXvIdj-ISsKSsE8T8Zi453xBpXryTlnGgXQDoAopjXpkC5Om7kzMZqHNV_nRluZiENSXI9Pg85Hdxq3DZEBYGPn6NZ91UVtgbiELY6evo9LpFqJAnOX9z_rsQ", 
                    "Jane Smith", 
                    "Lead Developer", 
                    "Jane leads our development team with a passion for clean code.",
                    size
                  ),
                  _buildTeamMemberCard(
                    context, 
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBnsjAQoHe_v9euD8Qxv23b36hRkHIsxMssdGOxurvyWvqIPzXNIHsF9ZsJqyzj5pWRjAny1WR9b3OErZqqFxiieRdGu7Rk1okaCf-HvdK3HK5aaVRsDwgCmmWNYlSj61HFcXl6Fd5o7cfv55jCaZbK9jafqcbV7_09CfuZRtmZlnYrTNOIRP2c9qRcficEtw0TjhAbtHxOsoyrNheitBm_e2Vx_5nNBhD_9Zg4vnyzUTqQGAN0fF6sYkTl7JR3J1r6K9Wv3r8VFWs", 
                    "Mike Johnson", 
                    "Head of Design", 
                    "Mike crafts stunning and user-friendly interfaces.",
                    size
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueCard(BuildContext context, IconData icon, String title, String description, double size) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.background,
      child: Container(
        width: size * 12.5, // 300
        padding: EdgeInsets.all(size), // 24
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: size * 1.66), // 40
            SizedBox(height: size * 0.66), // 16
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: size * 0.33), // 8
            Text(description, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard(BuildContext context, String imageUrl, String name, String title, String description, double size) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: EdgeInsets.only(bottom: size), // 24
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size * 10.4, // 250
            width: double.infinity,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(size * 0.66), // 16
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: textTheme.titleLarge),
                SizedBox(height: size * 0.16), // 4
                Text(title, style: textTheme.titleMedium?.copyWith(color: AppColors.primary)),
                SizedBox(height: size * 0.33), // 8
                Text(description, style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.7)
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
EOF

# --- Portfolio Files ---
echo "Creating Portfolio files..."

cat <<'EOF' > lib/features/portfolio/domain/entities/portfolio.dart
// 1. Domain Layer: The pure business object.
class Portfolio {
  final String id;
  final String title;
  final String description;
  final String mainImage; // The image shown in the list
  final List<String> images; // All images for the detail page

  Portfolio({
    required this.id,
    required this.title,
    required this.description,
    required this.mainImage,
    required this.images,
  });
}
EOF

cat <<'EOF' > lib/features/portfolio/domain/repositories/portfolio_repository.dart
import '../entities/portfolio.dart';

// 2. Domain Layer: The contract for the data layer.
abstract class PortfolioRepository {
  Future<List<Portfolio>> getPortfolioList();
}
EOF

cat <<'EOF' > lib/features/portfolio/domain/usecases/get_portfolio_list.dart
import '../entities/portfolio.dart';
import '../repositories/portfolio_repository.dart';

// 3. Domain Layer: Connects presentation to repository.
class GetPortfolioList {
  final PortfolioRepository repository;

  GetPortfolioList(this.repository);

  Future<List<Portfolio>> call() async {
    // In a real app, you'd have error handling (e.g., Either<Failure, List>)
    return await repository.getPortfolioList();
  }
}
EOF

cat <<'EOF' > lib/features/portfolio/data/models/portfolio_model.dart
import '../../domain/entities/portfolio.dart';

// 4. Data Layer: Extends Entity, adds fromJson for parsing.
class PortfolioModel extends Portfolio {
  PortfolioModel({
    required super.id,
    required super.title,
    required super.description,
    required super.mainImage,
    required super.images,
  });

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    // Supabase stores string arrays as List<dynamic>
    final imageList = (json['images'] as List<dynamic>? ?? []).cast<String>();

    return PortfolioModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      mainImage: json['main_image'] as String,
      images: imageList,
    );
  }
}
EOF

cat <<'EOF' > lib/features/portfolio/data/datasources/portfolio_remote_datasource.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/portfolio_model.dart';

// 5. Data Layer: Abstract class for data fetching.
abstract class PortfolioRemoteDataSource {
  Future<List<PortfolioModel>> getPortfolioList();
}

// 6. Data Layer: Implementation using Supabase.
class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final SupabaseClient client;
  final String _tableName = 'portfolio'; // اسم الجدول في Supabase

  PortfolioRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PortfolioModel>> getPortfolioList() async {
    try {
      // افترض أنك ستجلب كل المشاريع، مرتبة بالأحدث
      final data = await client
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);
      
      // --- FIX ---
      // Add a null check. If RLS is misconfigured or the table is empty,
      // data might be null.
      if (data == null) {
        return []; // Return an empty list, not null
      }
      // --- END FIX ---

      final portfolios =
          data.map((item) => PortfolioModel.fromJson(item)).toList();
      return portfolios;
    } on PostgrestException catch (e) {
      print('Supabase Error (Portfolio): ${e.message}');
      rethrow;
    } catch (e) {
      print('PortfolioDataSource Error: $e');
      rethrow;
    }
  }
}
EOF

cat <<'EOF' > lib/features/portfolio/data/repositories/portfolio_repository_impl.dart
import '../../domain/entities/portfolio.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_remote_datasource.dart';

// 7. Data Layer: Implements the repository contract.
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Portfolio>> getPortfolioList() async {
    try {
      // The model is compatible with the entity
      return await remoteDataSource.getPortfolioList();
    } catch (e) {
      rethrow;
    }
  }
}
EOF

cat <<'EOF' > lib/features/portfolio/presentation/provider/portfolio_provider.dart
import 'package:flutter/material.dart';
import '../../domain/entities/portfolio.dart';
import '../../domain/usecases/get_portfolio_list.dart';

// 8. Presentation Layer: Manages state for Portfolio.
class PortfolioProvider extends ChangeNotifier {
  final GetPortfolioList getPortfolioList;

  PortfolioProvider({required this.getPortfolioList});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Portfolio> _items = [];
  List<Portfolio> get items => _items;

  bool _hasFetched = false;

  Future<void> fetchPortfolioItems() async {
    // Evita إعادة الجلب إذا تم جلبه من قبل
    if (_hasFetched || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _items = await getPortfolioList();
      _hasFetched = true;
    } catch (e) {
      print("Error fetching portfolio: $e");
      // يمكنك إضافة متغير للخطأ هنا
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
EOF

cat <<'EOF' > lib/features/portfolio/presentation/screens/portfolio_detail_screen.dart
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
EOF

# --- Testimonial Files ---
echo "Creating Testimonial files..."

cat <<'EOF' > lib/features/testimonials/domain/entities/testimonial.dart
class Testimonial {
  final String id;
  final String quote;
  final String name;
  final String title;

  Testimonial({
    required this.id,
    required this.quote,
    required this.name,
    required this.title,
  });
}
EOF

cat <<'EOF' > lib/features/testimonials/domain/repositories/testimonial_repository.dart
import '../entities/testimonial.dart';

abstract class TestimonialRepository {
  Future<List<Testimonial>> getTestimonials();
}
EOF

cat <<'EOF' > lib/features/testimonials/domain/usecases/get_testimonials.dart
import '../entities/testimonial.dart';
import '../repositories/testimonial_repository.dart';

class GetTestimonials {
  final TestimonialRepository repository;

  GetTestimonials(this.repository);

  Future<List<Testimonial>> call() async {
    return await repository.getTestimonials();
  }
}
EOF

cat <<'EOF' > lib/features/testimonials/data/models/testimonial_model.dart
import '../../domain/entities/testimonial.dart';

class TestimonialModel extends Testimonial {
  TestimonialModel({
    required super.id,
    required super.quote,
    required super.name,
    required super.title,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) {
    return TestimonialModel(
      id: json['id'] as String,
      quote: json['quote'] as String,
      name: json['name'] as String,
      title: json['title'] as String,
    );
  }
}
EOF

cat <<'EOF' > lib/features/testimonials/data/datasources/testimonial_remote_datasource.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/testimonial_model.dart';

abstract class TestimonialRemoteDataSource {
  Future<List<TestimonialModel>> getTestimonials();
}

class TestimonialRemoteDataSourceImpl implements TestimonialRemoteDataSource {
  final SupabaseClient client;
  final String _tableName = 'testimonials'; // اسم الجدول في Supabase

  TestimonialRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TestimonialModel>> getTestimonials() async {
    try {
      final data = await client
          .from(_tableName)
          .select()
          .order('created_at', ascending: false);

      // --- FIX ---
      // Add a null check. If RLS is misconfigured or the table is empty,
      // data might be null.
      if (data == null) {
        return []; // Return an empty list
      }
      // --- END FIX ---

      final testimonials =
          data.map((item) => TestimonialModel.fromJson(item)).toList();
      return testimonials;
    } on PostgrestException catch (e) {
      print('Supabase Error (Testimonials): ${e.message}');
      rethrow;
    } catch (e) {
      print('TestimonialDataSource Error: $e');
      rethrow;
    }
  }
}
EOF

cat <<'EOF' > lib/features/testimonials/data/repositories/testimonial_repository_impl.dart
import '../../domain/entities/testimonial.dart';
import '../../domain/repositories/testimonial_repository.dart';
import '../datasources/testimonial_remote_datasource.dart';

class TestimonialRepositoryImpl implements TestimonialRepository {
  final TestimonialRemoteDataSource remoteDataSource;

  TestimonialRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Testimonial>> getTestimonials() async {
    try {
      return await remoteDataSource.getTestimonials();
    } catch (e) {
      rethrow;
    }
  }
}
EOF

cat <<'EOF' > lib/features/testimonials/presentation/provider/testimonial_provider.dart
import 'package:flutter/material.dart';
import '../../domain/entities/testimonial.dart';
import '../../domain/usecases/get_testimonials.dart';

class TestimonialProvider extends ChangeNotifier {
  final GetTestimonials getTestimonials;

  TestimonialProvider({required this.getTestimonials});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Testimonial> _items = [];
  List<Testimonial> get items => _items;

  bool _hasFetched = false;

  Future<void> fetchTestimonials() async {
    if (_hasFetched || _isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _items = await getTestimonials();
      _hasFetched = true;
    } catch (e) {
      print("Error fetching testimonials: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
EOF

echo ""
echo "----------------------------------------------------"
echo "تم إنشاء جميع الملفات وتعبئتها بنجاح!"
echo "----------------------------------------------------"
echo ""
echo "خطواتك التالية:"
echo "1. أضف Supabase URL/Key الخاص بك إلى 'lib/data/datasources/supabase_client.dart'"
echo "2. أنشئ جداول 'portfolio' و 'testimonials' في Supabase."
echo "3. أنشئ Edge Function باسم 'send-contact-email' في Supabase."
echo "4. أضف أيقونات SVG (facebook.svg, etc.) إلى مجلد 'assets/icons/'"
echo "5. قم بتشغيل 'flutter pub get' لتثبيت الإضافات."
echo "6. قم بتشغيل 'flutter gen-l10n' لإنشاء ملفات الترجمة."
echo "7. قم بتشغيل 'flutter run' لبدء تشغيل التطبيق."
echo ""

