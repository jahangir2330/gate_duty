// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World';

  @override
  String greeting(String username) {
    return 'Welcome, $username!';
  }

  @override
  String get home => 'Home';

  @override
  String get language => 'Language';

  @override
  String get qrscan => 'Qr Scan';

  @override
  String get profile => 'Profile';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get logout => 'Logout';

  @override
  String get signin => 'Sign-In';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get employeeview => 'Employee Detail';

  @override
  String get employeelist => 'Employee List';

  @override
  String get rolename => 'Role';

  @override
  String rolenameWithPlaceholder(String rolename) {
    return 'Role: , $rolename!';
  }

  @override
  String get gateName => 'Gate';

  @override
  String gateNameWithPlaceholder(String gateName) {
    return 'Gate: $gateName';
  }

  @override
  String get jobTitle => 'Job Title';

  @override
  String jobTitleWithPlaceholder(String jobTitle) {
    return 'Job Title: $jobTitle';
  }

  @override
  String get referenceNumber => 'Reference Number';

  @override
  String referenceNumberWithPlaceholder(String referenceNumber) {
    return 'Reference Number: $referenceNumber';
  }

  @override
  String get fullName => 'Full Name';

  @override
  String fullNameWithPlaceholder(String fullName) {
    return 'Full Name: $fullName';
  }

  @override
  String get employeeId => 'Employee';

  @override
  String employeeIdWithPlaceholder(String employeeId) {
    return 'Employee: $employeeId';
  }

  @override
  String get companyName => 'Company Name';

  @override
  String companyNameWithPlaceholder(String companyName) {
    return 'Company Name: $companyName';
  }

  @override
  String get nationality => 'Nationality';

  @override
  String nationalityWithPlaceholder(String nationality) {
    return 'Nationality: $nationality';
  }

  @override
  String get civilId => 'Civil ID';

  @override
  String civilIdWithPlaceholder(String civilId) {
    return 'Civil ID: $civilId';
  }

  @override
  String get startDate => 'Start Date';

  @override
  String startDateWithPlaceholder(DateTime startDate) {
    final intl.DateFormat startDateDateFormat = intl.DateFormat('dd-MM-yyyy', localeName);
    final String startDateString = startDateDateFormat.format(startDate);

    return 'Start Date: $startDateString';
  }

  @override
  String get endDate => 'End Date';

  @override
  String endDateWithPlaceholder(DateTime endDate) {
    final intl.DateFormat endDateDateFormat = intl.DateFormat('dd-MM-yyyy', localeName);
    final String endDateString = endDateDateFormat.format(endDate);

    return 'End Date: $endDateString';
  }

  @override
  String get allowedGates => 'Allowed Gates';

  @override
  String allowedGatesWithPlaceholder(String allowedGates) {
    return 'Allowed Gates: $allowedGates';
  }

  @override
  String get vehicleNumberPlates => 'Vehicle Number Plates';

  @override
  String vehicleNumberPlatesWithPlaceholder(String vehicleNumberPlates) {
    return 'Vehicle Number Plates: $vehicleNumberPlates';
  }

  @override
  String get lastEntryStatus => 'Last Entry Status';

  @override
  String lastEntryStatusWithPlaceholder(String lastEntryStatus) {
    return 'Last Entry Status: $lastEntryStatus';
  }

  @override
  String get enter => 'Enter';

  @override
  String get out => 'Out';

  @override
  String get rescan => 'Re Scan';

  @override
  String get lastentrydetail => 'Last Entry';

  @override
  String get entrystatusname => 'Entry Status';
}
