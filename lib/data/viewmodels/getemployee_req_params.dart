// ignore_for_file: public_member_api_docs, sort_constructors_first

class GetEmployeeReqParams {
  final String qrcode;

  GetEmployeeReqParams({required this.qrcode});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'qrcode': qrcode,
    };
  }
}
