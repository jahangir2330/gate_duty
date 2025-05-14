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

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World'**
  String get helloWorld;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Welcome, {username}!'**
  String greeting(String username);

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @qrscan.
  ///
  /// In en, this message translates to:
  /// **'Qr Scan'**
  String get qrscan;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @signin.
  ///
  /// In en, this message translates to:
  /// **'Sign-In'**
  String get signin;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @employeeview.
  ///
  /// In en, this message translates to:
  /// **'Employee Detail'**
  String get employeeview;

  /// No description provided for @employeelist.
  ///
  /// In en, this message translates to:
  /// **'Employee List'**
  String get employeelist;

  /// No description provided for @rolename.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get rolename;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Role: {rolename}!'**
  String rolenameWithPlaceholder(String rolename);

  /// No description provided for @gateName.
  ///
  /// In en, this message translates to:
  /// **'Gate'**
  String get gateName;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Gate: {gateName}'**
  String gateNameWithPlaceholder(String gateName);

  /// No description provided for @jobTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title'**
  String get jobTitle;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Job Title: {jobTitle}'**
  String jobTitleWithPlaceholder(String jobTitle);

  /// No description provided for @referenceNumber.
  ///
  /// In en, this message translates to:
  /// **'Reference Number'**
  String get referenceNumber;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Reference Number: {referenceNumber}'**
  String referenceNumberWithPlaceholder(String referenceNumber);

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Full Name: {fullName}'**
  String fullNameWithPlaceholder(String fullName);

  /// No description provided for @employeeId.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employeeId;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Employee: {employeeId}'**
  String employeeIdWithPlaceholder(String employeeId);

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Company Name: {companyName}'**
  String companyNameWithPlaceholder(String companyName);

  /// No description provided for @nationality.
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get nationality;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Nationality: {nationality}'**
  String nationalityWithPlaceholder(String nationality);

  /// No description provided for @civilId.
  ///
  /// In en, this message translates to:
  /// **'Civil ID'**
  String get civilId;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Civil ID: {civilId}'**
  String civilIdWithPlaceholder(String civilId);

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Start Date: {startDate}'**
  String startDateWithPlaceholder(DateTime startDate);

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'End Date: {endDate}'**
  String endDateWithPlaceholder(DateTime endDate);

  /// No description provided for @allowedGates.
  ///
  /// In en, this message translates to:
  /// **'Allowed Gates'**
  String get allowedGates;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Allowed Gates: {allowedGates}'**
  String allowedGatesWithPlaceholder(String allowedGates);

  /// No description provided for @vehicleNumberPlates.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number Plates'**
  String get vehicleNumberPlates;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number Plates: {vehicleNumberPlates}'**
  String vehicleNumberPlatesWithPlaceholder(String vehicleNumberPlates);

  /// No description provided for @lastEntryStatus.
  ///
  /// In en, this message translates to:
  /// **'Last Entry Status'**
  String get lastEntryStatus;

  /// A message with a single parameter
  ///
  /// In en, this message translates to:
  /// **'Last Entry Status: {lastEntryStatus}'**
  String lastEntryStatusWithPlaceholder(String lastEntryStatus);

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter;

  /// No description provided for @out.
  ///
  /// In en, this message translates to:
  /// **'Out'**
  String get out;

  /// No description provided for @rescan.
  ///
  /// In en, this message translates to:
  /// **'Re Scan'**
  String get rescan;

  /// No description provided for @lastentrydetail.
  ///
  /// In en, this message translates to:
  /// **'Last Entry'**
  String get lastentrydetail;

  /// No description provided for @entrystatusname.
  ///
  /// In en, this message translates to:
  /// **'Entry Status'**
  String get entrystatusname;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// No description provided for @jobDetails.
  ///
  /// In en, this message translates to:
  /// **'Job Details'**
  String get jobDetails;

  /// No description provided for @premissionDetails.
  ///
  /// In en, this message translates to:
  /// **'Premission Details'**
  String get premissionDetails;

  /// No description provided for @entryDetails.
  ///
  /// In en, this message translates to:
  /// **'Entry Details'**
  String get entryDetails;

  /// No description provided for @validitystatusname.
  ///
  /// In en, this message translates to:
  /// **'Validity Status'**
  String get validitystatusname;
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
