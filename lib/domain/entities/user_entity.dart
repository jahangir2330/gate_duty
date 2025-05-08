class UserEntity {
  final String username;
  final String email;
  final String? userId;
  final String? applicationId;
  final int? masterUserId;
  final String? emailAddress;
  final String? loweredUsername;
  final String? mobileNumber;
  final String? userProfilePhoto;
  final int? rolePriority;
  final String? roleName;
  int? gateid;
  final String? gateName;
  final String? gateNameAr;
  final int? companyId;
  final String? companyName;
  final String? companyNameAr;
  final String? currentUserRoleName;

  UserEntity({
    this.userId,
    this.applicationId,
    this.masterUserId,
    required this.username,
    this.emailAddress,
    required this.email,
    this.loweredUsername,
    this.mobileNumber,
    this.userProfilePhoto,
    this.rolePriority,
    this.roleName,
    this.gateid,
    this.gateName,
    this.gateNameAr,
    this.companyId,
    this.companyName,
    this.companyNameAr,
    this.currentUserRoleName,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userId: json['userId'] ?? '',
      applicationId: json['applicationId'] ?? '',
      masterUserId: json['masterUserId'] ?? 0,
      username: json['username'] ?? '',
      email: json['emailAddress'] ?? '',
      emailAddress: json['emailAddress'] ?? '',
      loweredUsername: json['loweredUsername'] ?? '',
      mobileNumber: json['mobileNumber'] ?? '',
      userProfilePhoto: json['userProfilePhoto'] ?? '',
      rolePriority: json['rolePriority'] ?? -99,
      roleName: json['roleName'] ?? '',
      gateid: json['gateid'],
      gateName: json['gateName'],
      gateNameAr: json['gateNameAr'],
      companyId: json['companyId'],
      companyName: json['companyName'],
      companyNameAr: json['companyNameAr'],
      currentUserRoleName: json['currentUserRoleName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'applicationId': applicationId,
      'masterUserId': masterUserId,
      'username': username,
      'emailAddress': emailAddress,
      'email': email,
      'loweredUsername': loweredUsername,
      'mobileNumber': mobileNumber,
      'userProfilePhoto': userProfilePhoto,
      'rolePriority': rolePriority,
      'roleName': roleName,
      'gateid': gateid,
      'gateName': gateName,
      'gateNameAr': gateNameAr,
      'companyId': companyId,
      'companyName': companyName,
      'companyNameAr': companyNameAr,
      'currentUserRoleName': currentUserRoleName,
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
