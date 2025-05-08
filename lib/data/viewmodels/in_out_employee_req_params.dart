// ignore_for_file: public_member_api_docs, sort_constructors_first

class InOutEmployeeReqParams {
  final String requestemployeeid;

  InOutEmployeeReqParams({required this.requestemployeeid});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestemployeeid': requestemployeeid,
    };
  }
}
