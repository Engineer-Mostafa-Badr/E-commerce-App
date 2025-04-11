class UserDataModel {
  String userID, name, email;
  String? phone;

  UserDataModel({
    required this.email,
    required this.name,
    required this.userID,
    this.phone,
  });
}
