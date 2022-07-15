
class UserData {
  String? name;
  String? imageUrl;
  bool? isSignedIn;
  String? emailId;
  String? phoneNumber;

  UserData(
      {this.name,
      this.imageUrl,
      this.isSignedIn,
      this.emailId,
      this.phoneNumber});

  UserData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        imageUrl = json['imageUrl'],
        isSignedIn = json['isSignedIn'],
        emailId = json['emailId'],
        phoneNumber = json['phoneNumber'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'imageUrl': imageUrl,
    'isSignedIn': isSignedIn,
    'emailId': emailId,
    'phoneNumber': phoneNumber,
  };
}
