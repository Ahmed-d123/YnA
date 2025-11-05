import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

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
