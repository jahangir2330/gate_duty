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
  });

  // Optional: Add a factory constructor to create an instance from a Map (e.g., JSON)
  factory EmployeeInOutEntity.fromJson(Map<String, dynamic> json) {
    return EmployeeInOutEntity(
      employeeinoutinfoid: json['employeeinoutinfoid'] as int?,
      requestemployeeid: json['requestemployeeid'] as int?,
      employeevehicleid: json['employeevehicleid'] as int?,
      intime: json['intime'] == null
          ? null
          : DateTime.parse(json['intime'] as String),
      inbyusername: json['inbyusername'] as String?,
      inbymacaddress: json['inbymacaddress'] as String?,
      gateid: json['gateid'] as int?,
      outtime: json['outtime'] == null
          ? null
          : DateTime.parse(json['outtime'] as String),
      outbyusername: json['outbyusername'] as String?,
      outbymacaddress: json['outbymacaddress'] as String?,
      duration: json['duration'] as int?,
      notetext: json['notetext'] as String?,
      fullname: json['fullname'] as String?,
      fullnameen: json['fullnameen'] as String?,
      emergencycontactnumber: json['emergencycontactnumber'] as String?,
      carnumberplate: json['carnumberplate'] as String?,
      gatename: json['gatename'] as String?,
      gatenamear: json['gatenamear'] as String?,
      companyid: json['companyid'] as int?,
      companyname: json['companyname'] as String?,
      companynamear: json['companynamear'] as String?,
      entrystatusid: json['entrystatusid'] as int?,
      entrystatusname: json['entrystatusname'] as String?,
      entrystatusnamear: json['entrystatusnamear'] as String?,
      referencenumber: json['referencenumber'] as String?,
      civilidnumber: json['civilidnumber'] as String?,
      startdate: json['startdate'] == null
          ? null
          : DateTime.parse(json['startdate'] as String),
      enddate: json['enddate'] == null
          ? null
          : DateTime.parse(json['enddate'] as String),
    );
  }

  // Optional: Add a method to convert the object to a Map (e.g., for JSON serialization)
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
    };
  }
}
