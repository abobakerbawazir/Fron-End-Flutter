class APIurl {
  //static const String baseUrl = 'https://abubakr.hadramout-bootcamps.com/api/';
  static const String baseUrl = 'http://192.168.129.98:8000/api/';
  static const String loginUrl = baseUrl + "login";
  static const String SignupUrl = baseUrl + 'signup';
  static const String logoutUrl = baseUrl + 'logout';
  static const String indexUrl = baseUrl + 'index';
  static const String getImageUrl = baseUrl + 'retImage';
  static const String deleteBrandUrl = baseUrl + "prand/delete/";
  static const String baseAdmin = baseUrl + 'admin/';
  static const String updateProfile = baseAdmin + 'update/';
  static const String deleteuserUrl = baseAdmin + 'delete/';
  static const String updateByAdminUrl = baseAdmin + 'update/';
  static const String indexByAdminUrl = baseAdmin + 'index';
  static const String viewAllBranchActive = baseAdmin + 'viewAllBranchActive';
  static const String viewAllBranchActiveSearch =
      baseAdmin + 'viewAllBranchActiveSearch?full_name=';
  static const String viewAlluserDoesNotAdmin =
      baseAdmin + 'viewAlluserDoesNotAdmin';
  static const String viewAlluserByRoleNameUrl =
      baseAdmin + 'viewAlluserByRoleName/';
  static const String baseCarUrl = baseUrl + 'car/';
  static const String addCarAndImageURL = baseCarUrl + 'addCarAndImage';

  static const String getCarWithUserAndPrand =
      baseCarUrl + 'getCarWithUserAndPrand';
  static const String viewAllCarsUlrl = baseCarUrl + 'index';
  static const String storeCarsUlrl = baseCarUrl + 'store';
  static const String baseImageUrl = baseUrl + 'image/';
  static const String uploadImageImageCarUrl = baseImageUrl + 'uploadImage';
  static const String retImageImageCarUrl = baseImageUrl + 'retImage';
  static const String getImageIdImageCarUrl = baseImageUrl + 'getImageId';
  static const String baseBookingUrl = baseUrl + 'booking/';
  static const String getAllBookingUrl = baseBookingUrl + 'index';
  static const String
      addBookingCarsWithId_user_And_Id_car_From_To_date_request_car_isNot_activeUrl =
      baseBookingUrl +
          'bookingCarsByUser_id_and_car_id_select_only_date_from_to/';
  static const String getAllInformationBookingForAllCustomer =
      baseBookingUrl + 'getAllInformationBookingForAllCustomer';
  static const String getByIDInformationBookingForAllCustomer =
      baseBookingUrl + 'getByIDInformationBookingForAllCustomer';
  static const String getBookingByBranchId =
      baseBookingUrl + 'getBookingByBranchId/';
  static const String getBookingByBranchIdByCustomerIdForCoustomer =
      baseBookingUrl + 'getBookingByBranchIdByCustomerIdForCoustomer/';
  static const String updateBookingStateByBranch =
      baseBookingUrl + 'updateBookingStateByBranch/';
  static const String getAllInformationBookingForOnlyCustomer =
      baseBookingUrl + 'getAllInformationBookingForOnlyCustomer/';
  static const String getallImageCarBYCarIdURL =
      baseUrl + 'image/getImageId?car_id=';
}
