// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get helloWorld => 'مرحباً بالعالم';

  @override
  String greeting(String username) {
    return 'أهلاً بك يا $username!';
  }

  @override
  String get home => 'الرئيسية';

  @override
  String get language => 'اللغة';

  @override
  String get qrscan => 'مسح QR';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get signin => 'تسجيل الدخول';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get password => 'كلمة المرور';

  @override
  String get employeeview => 'تفاصيل الموظف';

  @override
  String get employeelist => 'قائمة الموظفين';

  @override
  String get rolename => 'الدور';

  @override
  String rolenameWithPlaceholder(String rolename) {
    return 'الدور: $rolename!';
  }

  @override
  String get gateName => 'البوابة';

  @override
  String gateNameWithPlaceholder(String gateName) {
    return 'بوابة $gateName';
  }

  @override
  String get jobTitle => 'المسمى الوظيفي';

  @override
  String jobTitleWithPlaceholder(String jobTitle) {
    return 'المسمى الوظيفي: $jobTitle';
  }

  @override
  String get referenceNumber => 'الرقم المرجعي';

  @override
  String referenceNumberWithPlaceholder(String referenceNumber) {
    return 'الرقم المرجعي: $referenceNumber';
  }

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String fullNameWithPlaceholder(String fullName) {
    return 'الاسم الكامل: $fullName';
  }

  @override
  String get employeeId => 'الموظف';

  @override
  String employeeIdWithPlaceholder(String employeeId) {
    return 'الموظف: $employeeId';
  }

  @override
  String get companyName => 'اسم الشركة';

  @override
  String companyNameWithPlaceholder(String companyName) {
    return 'اسم الشركة: $companyName';
  }

  @override
  String get nationality => 'الجنسية';

  @override
  String nationalityWithPlaceholder(String nationality) {
    return 'الجنسية: $nationality';
  }

  @override
  String get civilId => 'الرقم المدني';

  @override
  String civilIdWithPlaceholder(String civilId) {
    return 'الرقم المدني: $civilId';
  }

  @override
  String get startDate => 'تاريخ البدء';

  @override
  String startDateWithPlaceholder(DateTime startDate) {
    final intl.DateFormat startDateDateFormat = intl.DateFormat('dd-MM-yyyy', localeName);
    final String startDateString = startDateDateFormat.format(startDate);

    return 'تاريخ البدء: $startDateString';
  }

  @override
  String get endDate => 'تاريخ الانتهاء';

  @override
  String endDateWithPlaceholder(DateTime endDate) {
    final intl.DateFormat endDateDateFormat = intl.DateFormat('dd-MM-yyyy', localeName);
    final String endDateString = endDateDateFormat.format(endDate);

    return 'تاريخ الانتهاء: $endDateString';
  }

  @override
  String get allowedGates => 'البوابات المسموح بها';

  @override
  String allowedGatesWithPlaceholder(String allowedGates) {
    return 'البوابات المسموح بها: $allowedGates';
  }

  @override
  String get vehicleNumberPlates => 'أرقام لوحات المركبات';

  @override
  String vehicleNumberPlatesWithPlaceholder(String vehicleNumberPlates) {
    return 'أرقام لوحات المركبات: $vehicleNumberPlates';
  }

  @override
  String get lastEntryStatus => 'حالة الإدخال الأخير';

  @override
  String lastEntryStatusWithPlaceholder(String lastEntryStatus) {
    return 'حالة الإدخال الأخير: $lastEntryStatus';
  }

  @override
  String get enter => 'يدخل';

  @override
  String get out => 'الخروج';

  @override
  String get rescan => 'إعادة المسح';

  @override
  String get lastentrydetail => 'الإدخال الأخير';

  @override
  String get entrystatusname => 'حالة الإدخال';

  @override
  String get notAvailable => 'غير متوفر';

  @override
  String get personalDetails => 'البيانات الشخصية';

  @override
  String get jobDetails => 'تفاصيل الوظيفة';

  @override
  String get premissionDetails => 'تفاصيل الإذن';

  @override
  String get entryDetails => 'تفاصيل الدخول';

  @override
  String get validitystatusname => 'حالة الصلاحية';
}
