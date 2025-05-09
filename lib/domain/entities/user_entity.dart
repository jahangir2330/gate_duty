class UserEntity {
  final String username;
  final String email;
  final String userid;
  final String applicationid;
  final int masteruserid;
  final String emailaddress;
  final String loweredusername;
  final String mobilenumber;
  final String userprofilephoto;
  final int rolepriority;
  final String rolename;
  int gateid;
  final String gatename;
  final String gatenamear;
  final int companyid;
  final String companyname;
  final String companynamear;
  final String currentuserrolename;

  UserEntity({
    required this.username,
    required this.email,
    required this.userid,
    required this.applicationid,
    required this.masteruserid,
    required this.emailaddress,
    required this.loweredusername,
    required this.mobilenumber,
    required this.userprofilephoto,
    required this.rolepriority,
    required this.rolename,
    required this.gateid,
    required this.gatename,
    required this.gatenamear,
    required this.companyid,
    required this.companyname,
    required this.companynamear,
    required this.currentuserrolename,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userid: json['userid'] ?? '',
      applicationid: json['applicationid'] ?? '',
      masteruserid: json['masteruserid'] ?? 0,
      username: json['username'] ?? '',
      email: json['emailaddress'] ?? '',
      emailaddress: json['emailaddress'] ?? '',
      loweredusername: json['loweredusername'] ?? '',
      mobilenumber: json['mobilenumber'] ?? '',
      userprofilephoto: json['userprofilephoto'] ?? '',
      rolepriority: json['rolepriority'] ?? -99,
      rolename: json['rolename'] ?? '',
      gateid: json['gateid'] ?? -99,
      gatename: json['gatename'] ?? '',
      gatenamear: json['gatenamear'],
      companyid: json['companyid'] ?? -99,
      companyname: json['companyname'] ?? '',
      companynamear: json['companynamear'] ?? '',
      currentuserrolename: json['currentuserrolename'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'applicationid': applicationid,
      'masteruserid': masteruserid,
      'username': username,
      'emailaddress': emailaddress,
      'email': email,
      'loweredusername': loweredusername,
      'mobilenumber': mobilenumber,
      'userprofilephoto': userprofilephoto,
      'rolepriority': rolepriority,
      'rolename': rolename,
      'gateid': gateid,
      'gatename': gatename,
      'gatenamear': gatenamear,
      'companyid': companyid,
      'companyname': companyname,
      'companynamear': companynamear,
      'currentuserrolename': currentuserrolename,
    };
  }
}

// class UserEntity {
//   final String email;
//   final String username;
//   final String userId;
//   final String applicationId;
//   final int masterUserId;
//   final String emailAddress;
//   final String loweredUsername;
//   final String mobileNumber;
//   final String userProfilePhoto;
//   final int rolePriority;
//   final String roleName;
//   int? gateid;
//   final String? gateName;
//   final String? gateNameAr;
//   final int? companyId;
//   final String? companyName;
//   final String? companyNameAr;
//   final String? currentUserRoleName;

//   UserEntity({
//     required this.email,
//     required this.username,
//     required this.userId,
//     required this.applicationId,
//     required this.masterUserId,
//     required this.emailAddress,
//     required this.loweredUsername,
//     required this.mobileNumber,
//     required this.userProfilePhoto,
//     required this.rolePriority,
//     required this.roleName,
//     this.gateid,
//     this.gateName,
//     this.gateNameAr,
//     this.companyId,
//     this.companyName,
//     this.companyNameAr,
//     this.currentUserRoleName,
//   });
// }
