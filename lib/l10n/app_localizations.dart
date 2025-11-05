import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Y&A Tech'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navServices.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get navServices;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get navAbout;

  /// No description provided for @homeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Crafting Digital Futures.'**
  String get homeHeroTitle;

  /// No description provided for @homeHeroButton.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Build Together'**
  String get homeHeroButton;

  /// No description provided for @homeSectionServices.
  ///
  /// In en, this message translates to:
  /// **'Our Services'**
  String get homeSectionServices;

  /// No description provided for @homeSectionPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get homeSectionPortfolio;

  /// No description provided for @homeSectionTestimonials.
  ///
  /// In en, this message translates to:
  /// **'Testimonials'**
  String get homeSectionTestimonials;

  /// No description provided for @homeSectionContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get homeSectionContact;

  /// No description provided for @serviceWebTitle.
  ///
  /// In en, this message translates to:
  /// **'Web Development'**
  String get serviceWebTitle;

  /// No description provided for @serviceWebDescription.
  ///
  /// In en, this message translates to:
  /// **'Creating responsive, high-performance websites that deliver exceptional user experiences.'**
  String get serviceWebDescription;

  /// No description provided for @serviceAppTitle.
  ///
  /// In en, this message translates to:
  /// **'App Development'**
  String get serviceAppTitle;

  /// No description provided for @serviceAppDescription.
  ///
  /// In en, this message translates to:
  /// **'Building native and cross-platform mobile applications for iOS and Android.'**
  String get serviceAppDescription;

  /// No description provided for @serviceAiTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Integration'**
  String get serviceAiTitle;

  /// No description provided for @serviceAiDescription.
  ///
  /// In en, this message translates to:
  /// **'Leveraging artificial intelligence for business automation and data-driven insights.'**
  String get serviceAiDescription;

  /// No description provided for @serviceBrandingTitle.
  ///
  /// In en, this message translates to:
  /// **'Branding'**
  String get serviceBrandingTitle;

  /// No description provided for @serviceBrandingDescription.
  ///
  /// In en, this message translates to:
  /// **'Creating powerful brand identities that resonate with your target audience.'**
  String get serviceBrandingDescription;

  /// No description provided for @contactFormNameHint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get contactFormNameHint;

  /// No description provided for @contactFormEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get contactFormEmailHint;

  /// No description provided for @contactFormMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get contactFormMessageHint;

  /// No description provided for @contactFormButtonSend.
  ///
  /// In en, this message translates to:
  /// **'Send Message'**
  String get contactFormButtonSend;

  /// No description provided for @contactFormSuccess.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully!'**
  String get contactFormSuccess;

  /// No description provided for @contactFormError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send message. Please try again.'**
  String get contactFormError;

  /// No description provided for @aboutHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Crafting Digital Futures, Together.'**
  String get aboutHeroTitle;

  /// No description provided for @aboutHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A brief overview of Y&A Tech\'s origin and purpose.'**
  String get aboutHeroSubtitle;

  /// No description provided for @aboutMissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Mission'**
  String get aboutMissionTitle;

  /// No description provided for @aboutMissionDescription.
  ///
  /// In en, this message translates to:
  /// **'To create smart, human-centric digital solutions that empower businesses and individuals to thrive in an ever-evolving digital landscape.'**
  String get aboutMissionDescription;

  /// No description provided for @aboutValuesTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Values'**
  String get aboutValuesTitle;

  /// No description provided for @aboutValuesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'At Y&A Tech, our values are the cornerstone of our culture and the driving force behind our success. They guide our decisions, our interactions, and our innovations.'**
  String get aboutValuesSubtitle;

  /// No description provided for @valueInnovation.
  ///
  /// In en, this message translates to:
  /// **'Innovation'**
  String get valueInnovation;

  /// No description provided for @valueReliability.
  ///
  /// In en, this message translates to:
  /// **'Reliability'**
  String get valueReliability;

  /// No description provided for @valueCreativity.
  ///
  /// In en, this message translates to:
  /// **'Creativity'**
  String get valueCreativity;

  /// No description provided for @aboutTeamTitle.
  ///
  /// In en, this message translates to:
  /// **'Meet the Minds Behind Y&A Tech'**
  String get aboutTeamTitle;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
