// ignore_for_file: public_member_api_docs, sort_constructors_first

class InOutEmployeeReqParams {
  final int requestemployeeid;
  final int? gateid;
  final String? inbyusername;
  final DateTime? intime;
  final DateTime? outtime;
  final String? inbymacaddress;
  final String? outbymacaddress;

  InOutEmployeeReqParams({
    required this.requestemployeeid,
    this.gateid,
    this.inbyusername,
    this.intime,
    this.outtime,
    this.inbymacaddress,
    this.outbymacaddress,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'requestemployeeid': requestemployeeid,
      'gateid': gateid,
      'inbyusername': inbyusername,
      'intime': intime?.toIso8601String(),
      'outtime': outtime?.toIso8601String(),
      'inbymacaddress': inbymacaddress,
      'outbymacaddress': outbymacaddress,
    };
  }
}

class IdAsReqParams {
  final int idParam;

  IdAsReqParams({required this.idParam});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestemployeeid': idParam,
    };
  }
}

// class InOutEmployeeReqParams {
//   final String requestemployeeid;

//   InOutEmployeeReqParams({required this.requestemployeeid});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'requestemployeeid': requestemployeeid,
//     };
//   }
// }
