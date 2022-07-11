

class UserInfoPojo{
  String? name;
  String? emailId;
  String? phoneNumber;
  String? imageUrl;

  UserInfoPojo({this.name, this.emailId, this.phoneNumber, this.imageUrl});

  factory UserInfoPojo.fromJson(Map<String, dynamic> json) => UserInfoPojo(
    name: json["name"],
    emailId: json["email"],
    phoneNumber: json["phone"],
    imageUrl: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": emailId,
    "phone": phoneNumber,
    "image": imageUrl,
  };


}