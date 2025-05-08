class EmployeeEntity {
  final int requestemployeeid;
  final int requestapplicationid;
  final String fullName;
  final String? fullNameen;
  final String thumbspersonalpicure;
  final String thumbscivilidimage;
  final String thumbscivilidbacksideimage;
  final String? vehiclelist;
  final String? approvedbysignature;
  final int companyid;
  final int requesterid;
  final int representativeid;
  final int licensetypeid;
  final int requesttypeid;
  final String emergencycontactnumber;
  final String referencenumber;
  final DateTime? startdate;
  final DateTime? enddate;
  final String? canenterafteroffice;
  final String? timingnote;
  final String currentstatus;
  final String? gatenamesstring;
  final String? gatenamesarabicstring;
  final String contractdocument;
  final String companyname;
  final String companynamear;
  final String licensetypename;
  final String licensetypenamear;
  final String statusname;
  final String statusnamear;
  final String nationalityname;
  final String nationalitynamear;
  final String qrcode;
  final String statuscssclass;
  final int nationalityid;
  final String jobtitle;
  final String civilidnumber;
  final int numberofvehicle;
  final String vehiclenumberplates;
  final bool ispersonblocked;
  final bool isactive;

  EmployeeEntity({
    required this.requestemployeeid,
    required this.requestapplicationid,
    required this.fullName,
    this.fullNameen, // Nullable
    required this.thumbspersonalpicure,
    required this.thumbscivilidimage,
    required this.thumbscivilidbacksideimage,
    this.vehiclelist,
    this.approvedbysignature, // Nullable
    required this.companyid,
    required this.requesterid,
    required this.representativeid,
    required this.licensetypeid,
    required this.requesttypeid,
    required this.emergencycontactnumber,
    required this.referencenumber,
    required this.startdate,
    required this.enddate,
    this.canenterafteroffice,
    this.timingnote,
    required this.currentstatus,
    this.gatenamesstring,
    this.gatenamesarabicstring,
    required this.contractdocument,
    required this.companyname,
    required this.companynamear,
    required this.licensetypename,
    required this.licensetypenamear,
    required this.statusname,
    required this.statusnamear,
    required this.nationalityname,
    required this.nationalitynamear,
    required this.qrcode,
    required this.statuscssclass,
    required this.nationalityid,
    required this.jobtitle,
    required this.civilidnumber,
    required this.numberofvehicle,
    required this.vehiclenumberplates,
    required this.ispersonblocked,
    required this.isactive,
  });

  factory EmployeeEntity.fromJson(Map<String, dynamic> json) {
    return EmployeeEntity(
      requestemployeeid: json['requestemployeeid'] as int,
      requestapplicationid: json['requestapplicationid'] as int,
      fullName: json['fullname'] as String,
      fullNameen: json['fullnameen'],
      thumbspersonalpicure: json['thumbspersonalpicure'] as String,
      thumbscivilidimage: json['thumbscivilidimage'] as String,
      thumbscivilidbacksideimage: json['thumbscivilidbacksideimage'] as String,
      vehiclelist: json['vehiclelist'],
      approvedbysignature: json['approvedbysignature'],
      companyid: json['companyid'] as int,
      requesterid: json['requesterid'] as int,
      representativeid: json['representativeid'] as int,
      licensetypeid: json['licensetypeid'] as int,
      requesttypeid: json['requesttypeid'] as int,
      emergencycontactnumber: json['emergencycontactnumber'] as String,
      referencenumber: json['referencenumber'] as String,
      startdate: json['startdate'] == null
          ? null
          : DateTime.parse(json['startdate'] as String),
      enddate: json['enddate'] == null
          ? null
          : DateTime.parse(json['enddate'] as String),
      canenterafteroffice: json['canenterafteroffice'],
      timingnote: json['timingnote'],
      currentstatus: json['currentstatus'] as String,
      gatenamesstring: json['gatenamesstring'],
      gatenamesarabicstring: json['gatenamesarabicstring'],
      contractdocument: json['contractdocument'] as String,
      companyname: json['companyname'] as String,
      companynamear: json['companynamear'] as String,
      licensetypename: json['licensetypename'] as String,
      licensetypenamear: json['licensetypenamear'] as String,
      statusname: json['statusname'] as String,
      statusnamear: json['statusnamear'] as String,
      nationalityname: json['nationalityname'] as String,
      nationalitynamear: json['nationalitynamear'] as String,
      qrcode: json['qrcode'] as String,
      statuscssclass: json['statuscssclass'] as String,
      nationalityid: json['nationalityid'] as int,
      jobtitle: json['jobtitle'] as String,
      civilidnumber: json['civilidnumber'] as String,
      numberofvehicle: json['numberofvehicle'] as int,
      vehiclenumberplates: json['vehiclenumberplates'] as String,
      ispersonblocked: json['ispersonblocked'] as bool,
      isactive: json['isactive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestemployeeid': requestemployeeid,
      'requestapplicationid': requestapplicationid,
      'fullname': fullName,
      'fullnameen': fullNameen,
      'thumbspersonalpicure': thumbspersonalpicure,
      'thumbscivilidimage': thumbscivilidimage,
      'thumbscivilidbacksideimage': thumbscivilidbacksideimage,
      'vehiclelist': vehiclelist,
      'approvedbysignature': approvedbysignature,
      'companyid': companyid,
      'requesterid': requesterid,
      'representativeid': representativeid,
      'licensetypeid': licensetypeid,
      'requesttypeid': requesttypeid,
      'emergencycontactnumber': emergencycontactnumber,
      'referencenumber': referencenumber,
      'startdate': startdate?.toIso8601String(),
      'enddate': enddate?.toIso8601String(),
      'canenterafteroffice': canenterafteroffice,
      'timingnote': timingnote,
      'currentstatus': currentstatus,
      'gatenamesstring': gatenamesstring,
      'gatenamesarabicstring': gatenamesarabicstring,
      'contractdocument': contractdocument,
      'companyname': companyname,
      'companynamear': companynamear,
      'licensetypename': licensetypename,
      'licensetypenamear': licensetypenamear,
      'statusname': statusname,
      'statusnamear': statusnamear,
      'nationalityname': nationalityname,
      'nationalitynamear': nationalitynamear,
      'qrcode': qrcode,
      'statuscssclass': statuscssclass,
      'nationalityid': nationalityid,
      'jobtitle': jobtitle,
      'civilidnumber': civilidnumber,
      'numberofvehicle': numberofvehicle,
      'vehiclenumberplates': vehiclenumberplates,
      'ispersonblocked': ispersonblocked,
      'isactive': isactive,
    };
  }
}

// class EmployeeData {
//   final int requestemployeeid;
//   final String largePersonalPicture;
//   final String thumbsPersonalPicture;
//   final String? approvedSignature;
//   final String companyName;
//   final String requesterName;
//   final String representativeName;
//   final String nationality;
//   final String licenseType;
//   final String requestType;
//   final String statusName;
//   final String fullName;
//   final String jobTitle;
//   final String civilIdNumber;
//   final String vehicleNumberPlates;

//   EmployeeData({
//     required this.requestemployeeid,
//     required this.largePersonalPicture,
//     required this.thumbsPersonalPicture,
//     this.approvedSignature,
//     required this.companyName,
//     required this.requesterName,
//     required this.representativeName,
//     required this.nationality,
//     required this.licenseType,
//     required this.requestType,
//     required this.statusName,
//     required this.fullName,
//     required this.jobTitle,
//     required this.civilIdNumber,
//     required this.vehicleNumberPlates,
//   });

//   factory EmployeeData.fromJson(Map<String, dynamic> json) {
//     return EmployeeData(
//       requestemployeeid: json['requestemployeeid'] as int,
//       largePersonalPicture: json['largepersonalpicure'] ?? '',
//       thumbsPersonalPicture: json['thumbspersonalpicure'] ?? '',
//       approvedSignature: json['approvedbysignature'],
//       companyName: json['companyname'] ?? '',
//       requesterName: json['requestername'] ?? '',
//       representativeName: json['representativename'] ?? '',
//       nationality: json['nationalityname'] ?? '',
//       licenseType: json['licensetypename'] ?? '',
//       requestType: json['requesttypename'] ?? '',
//       statusName: json['statusname'] ?? '',
//       fullName: json['fullname'] ?? '',
//       jobTitle: json['jobtitle'] ?? '',
//       civilIdNumber: json['civilidnumber'] ?? '',
//       vehicleNumberPlates: json['vehiclenumberplates'] ?? '',
//     );
//   }
// }
