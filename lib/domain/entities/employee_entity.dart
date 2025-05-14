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
  //final String currentstatus;
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
  final int lastentrystatusid;
  final String? lastentrydetailar;

  final int? validitystatusid;
  final String? validitystatusname;
  final String? validitystatusnamear;
  final String? validitycssclass;
  final String? apiculture;

  EmployeeEntity({
    required this.requestemployeeid,
    required this.requestapplicationid,
    required this.fullName,
    this.fullNameen,
    required this.thumbspersonalpicure,
    required this.thumbscivilidimage,
    required this.thumbscivilidbacksideimage,
    this.vehiclelist,
    this.approvedbysignature,
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
    //required this.currentstatus,
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
    required this.lastentrystatusid,
    this.lastentrydetailar,
    this.validitystatusid,
    this.validitystatusname,
    this.validitystatusnamear,
    this.validitycssclass,
    this.apiculture,
  });

  factory EmployeeEntity.fromJson(Map<String, dynamic> json) {
    try {
      return EmployeeEntity(
        requestemployeeid: json['requestemployeeid'] as int,
        requestapplicationid: json['requestapplicationid'] as int,
        fullName: json['fullname'] as String,
        fullNameen:
            json['fullnameen'] != null ? json['fullnameen'] as String : null,
        thumbspersonalpicure: json['thumbspersonalpicure'] as String,
        thumbscivilidimage: json['thumbscivilidimage'] as String,
        thumbscivilidbacksideimage:
            json['thumbscivilidbacksideimage'] as String,
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
        //currentstatus: json['currentstatus'] as String,
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
        lastentrystatusid: json['lastentrystatusid'] as int,
        lastentrydetailar: json['lastentrydetailar'] as String,
        validitystatusid: json['validitystatusid'] as int,
        validitystatusname: json['validitystatusname'] as String,
        validitystatusnamear: json['validitystatusnamear'] as String,
        validitycssclass: json['validitycssclass'] as String,
        apiculture: "NA",
      );
    } catch (e) {
      //print('Error parsing JSON: $e');
      throw FormatException('Failed to parse EmployeeEntity JSON: $e');
    }
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
      //'currentstatus': currentstatus,
      'gatenamesstring': gatenamesstring,
      'gatenamesarabicstring': gatenamesarabicstring,
      'contractdocument': contractdocument,
      'companyname': companyname,
      'companynamear': companynamear,
      'licensetypename': licensetypename,
      'licensetypenamear': licensetypenamear,
      'statusname': statusname,
      'statusnamear': statusnamear,
      'nationalityname': nationalitynamear,
      'qrcode': qrcode,
      'statuscssclass': statuscssclass,
      'nationalityid': nationalityid,
      'jobtitle': jobtitle,
      'civilidnumber': civilidnumber,
      'numberofvehicle': numberofvehicle,
      'vehiclenumberplates': vehiclenumberplates,
      'ispersonblocked': ispersonblocked,
      'isactive': isactive,
      'lastentrystatusid': lastentrystatusid,
      'lastentrydetailar': lastentrydetailar,
      'validitystatusid': validitystatusid,
      'validitystatusname': validitystatusname,
      'validitystatusnamear': validitystatusnamear,
      'validitycssclass': validitycssclass,
      'apiculture': apiculture,
    };
  }
}
