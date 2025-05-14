class EmployeeInOutEntity {
  int? employeeinoutinfoid;
  int? requestemployeeid;
  int? employeevehicleid;
  DateTime? intime;
  String? inbyusername;
  String? inbymacaddress;
  int? gateid;
  DateTime? outtime;
  String? outbyusername;
  String? outbymacaddress;
  int? duration;
  String? notetext;
  String? fullname;
  String? fullnameen;
  String? emergencycontactnumber;
  String? carnumberplate;
  String? gatename;
  String? gatenamear;
  int? companyid;
  String? companyname;
  String? companynamear;
  int? entrystatusid;
  String? entrystatusname;
  String? entrystatusnamear;
  String? referencenumber;
  String? civilidnumber;
  DateTime? startdate;
  DateTime? enddate;

  int? pageSize;
  int? currentPage;
  String? sortexpression;
  String? apiculture;

  EmployeeInOutEntity({
    this.employeeinoutinfoid,
    this.requestemployeeid,
    this.employeevehicleid,
    this.intime,
    this.inbyusername,
    this.inbymacaddress,
    this.gateid,
    this.outtime,
    this.outbyusername,
    this.outbymacaddress,
    this.duration,
    this.notetext,
    this.fullname,
    this.fullnameen,
    this.emergencycontactnumber,
    this.carnumberplate,
    this.gatename,
    this.gatenamear,
    this.companyid,
    this.companyname,
    this.companynamear,
    this.entrystatusid,
    this.entrystatusname,
    this.entrystatusnamear,
    this.referencenumber,
    this.civilidnumber,
    this.startdate,
    this.enddate,
    this.pageSize,
    this.currentPage,
    this.sortexpression,
    this.apiculture,
  });

  factory EmployeeInOutEntity.fromJson(Map<String, dynamic> json) {
    try {
      return EmployeeInOutEntity(
        employeeinoutinfoid: parseInt(json['employeeinoutinfoid']),
        requestemployeeid: parseInt(json['requestemployeeid']),
        employeevehicleid: parseInt(json['employeevehicleid']),
        gateid: parseInt(json['gateid']),
        duration: parseInt(json['duration']),
        companyid: parseInt(json['companyid']),
        entrystatusid: parseInt(json['entrystatusid']),
        pageSize: parseInt(json['pageSize']),
        currentPage: parseInt(json['currentPage']),
        intime: json['intime'] == null ? null : DateTime.parse(json['intime']),
        outtime:
            json['outtime'] == null ? null : DateTime.parse(json['outtime']),
        inbyusername: json['inbyusername'],
        inbymacaddress: json['inbymacaddress'],
        outbyusername: json['outbyusername'],
        outbymacaddress: json['outbymacaddress'],
        notetext: json['notetext'],
        fullname: json['fullname'],
        fullnameen: json['fullnameen'],
        emergencycontactnumber: json['emergencycontactnumber'],
        carnumberplate: json['carnumberplate'],
        gatename: json['gatename'],
        gatenamear: json['gatenamear'],
        companyname: json['companyname'],
        companynamear: json['companynamear'],
        entrystatusname: json['entrystatusname'],
        entrystatusnamear: json['entrystatusnamear'],
        referencenumber: json['referencenumber'],
        civilidnumber: json['civilidnumber'],
        startdate: json['startdate'] == null
            ? null
            : DateTime.parse(json['startdate']),
        enddate:
            json['enddate'] == null ? null : DateTime.parse(json['enddate']),
        sortexpression: json['SortExpression'],
        apiculture: "NA",
      );
    } catch (e) {
      //print('Error during EmployeeInOutEntity.fromJson: $e');
      //print('Problematic JSON: $json');
      return EmployeeInOutEntity(); // fallback
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeinoutinfoid': employeeinoutinfoid,
      'requestemployeeid': requestemployeeid,
      'employeevehicleid': employeevehicleid,
      'intime': intime?.toIso8601String(),
      'inbyusername': inbyusername,
      'inbymacaddress': inbymacaddress,
      'gateid': gateid,
      'outtime': outtime?.toIso8601String(),
      'outbyusername': outbyusername,
      'outbymacaddress': outbymacaddress,
      'duration': duration,
      'notetext': notetext,
      'fullname': fullname,
      'fullnameen': fullnameen,
      'emergencycontactnumber': emergencycontactnumber,
      'carnumberplate': carnumberplate,
      'gatename': gatename,
      'gatenamear': gatenamear,
      'companyid': companyid,
      'companyname': companyname,
      'companynamear': companynamear,
      'entrystatusid': entrystatusid,
      'entrystatusname': entrystatusname,
      'entrystatusnamear': entrystatusnamear,
      'referencenumber': referencenumber,
      'civilidnumber': civilidnumber,
      'startdate': startdate?.toIso8601String(),
      'enddate': enddate?.toIso8601String(),
      'pageSize': pageSize,
      'currentPage': currentPage,
      'sortexpression': sortexpression,
      'apiculture': apiculture,
    };
  }

  static int? parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
