// ignore_for_file: public_member_api_docs, sort_constructors_first

class GetEmployeeReqParams {
  final String? qrcode;
  final int? requestemployeeid;

  GetEmployeeReqParams({this.qrcode, this.requestemployeeid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrcode': qrcode,
      'requestemployeeid': requestemployeeid,
    };
  }
}
