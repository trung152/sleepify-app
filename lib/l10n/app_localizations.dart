import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Sleepify'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Luxury Sleep & Breathwork'**
  String get appTagline;

  /// No description provided for @splashLoading.
  ///
  /// In en, this message translates to:
  /// **'Preparing your sleep experience...'**
  String get splashLoading;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languageContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get languageContinue;

  /// No description provided for @onboardingGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'What is your main goal today?'**
  String get onboardingGoalTitle;

  /// No description provided for @onboardingGoalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us your aspiration for better well-being'**
  String get onboardingGoalSubtitle;

  /// No description provided for @goalSleep.
  ///
  /// In en, this message translates to:
  /// **'Sleep'**
  String get goalSleep;

  /// No description provided for @goalRelax.
  ///
  /// In en, this message translates to:
  /// **'Relax'**
  String get goalRelax;

  /// No description provided for @goalFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get goalFocus;

  /// No description provided for @goalBreathe.
  ///
  /// In en, this message translates to:
  /// **'Breathe'**
  String get goalBreathe;

  /// No description provided for @onboardingBedtimeTitle.
  ///
  /// In en, this message translates to:
  /// **'When do you usually sleep?'**
  String get onboardingBedtimeTitle;

  /// No description provided for @onboardingBedtimeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This helps us personalize your experience'**
  String get onboardingBedtimeSubtitle;

  /// No description provided for @bedtime9to10.
  ///
  /// In en, this message translates to:
  /// **'9 PM - 10 PM'**
  String get bedtime9to10;

  /// No description provided for @bedtime10to12.
  ///
  /// In en, this message translates to:
  /// **'10 PM - 12 AM'**
  String get bedtime10to12;

  /// No description provided for @bedtime12to2.
  ///
  /// In en, this message translates to:
  /// **'12 AM - 2 AM'**
  String get bedtime12to2;

  /// No description provided for @bedtimeAfter2.
  ///
  /// In en, this message translates to:
  /// **'After 2 AM'**
  String get bedtimeAfter2;

  /// No description provided for @onboardingSleepHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'How many hours of sleep do you need?'**
  String get onboardingSleepHoursTitle;

  /// No description provided for @onboardingSleepHoursSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll use this to personalize your preferences'**
  String get onboardingSleepHoursSubtitle;

  /// No description provided for @onboardingNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Get notified for better rest'**
  String get onboardingNotificationTitle;

  /// No description provided for @onboardingNotificationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enable this to set your sleep schedule, so you don\'t miss your perfect bedtime.'**
  String get onboardingNotificationSubtitle;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @skipForNow.
  ///
  /// In en, this message translates to:
  /// **'I\'ll do it later'**
  String get skipForNow;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get homeGreetingEvening;

  /// No description provided for @soundsTitle.
  ///
  /// In en, this message translates to:
  /// **'Relaxing Sounds'**
  String get soundsTitle;

  /// No description provided for @breathworkTitle.
  ///
  /// In en, this message translates to:
  /// **'Breathwork'**
  String get breathworkTitle;

  /// No description provided for @libraryTitle.
  ///
  /// In en, this message translates to:
  /// **'My Library'**
  String get libraryTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @premiumTitle.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get premiumTitle;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabSounds.
  ///
  /// In en, this message translates to:
  /// **'Sounds'**
  String get tabSounds;

  /// No description provided for @tabBreathwork.
  ///
  /// In en, this message translates to:
  /// **'Breathwork'**
  String get tabBreathwork;

  /// No description provided for @tabLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get tabLibrary;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
