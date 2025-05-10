class ApiUrls {
  //static const baseURL = 'https://gipmsapi.kuwaitarmy.gov.kw/api/';
  static const baseURL = 'https://fastshinystone51.conveyor.cloud/api/';
  static const register = '${baseURL}auth/register';
  static const userProfile = '${baseURL}users/profile';
  static const login = '${baseURL}Auth/login';

  //User
  static const getuserinfo = '${baseURL}Gen_UserDetail/GetSingleGen_UserDetail';

  //Employee
  static const employeedetail =
      '${baseURL}Tran_ApplicationReqForEmpDetl/Verify';

  //In Out
  static const employeein =
      '${baseURL}Tran_ApplicationReqForEmpInOut/AddTran_ApplicationReqForEmpInOut';
  static const employeeout =
      '${baseURL}Tran_ApplicationReqForEmpInOut/OutEmployee';

  static const employeeinoutlist =
      '${baseURL}Tran_ApplicationReqForEmpInOut/GetAllPagedTran_ApplicationReqForEmpInOut';
}
