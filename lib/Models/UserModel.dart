class UserModel {
  String? email;
  String? password;
  String? phone;
  late String uId;
  String? name;
  String? image;
  String? cover;

  UserModel(
      {this.email,
      required this.name,
      this.cover,
      this.password,
      this.phone,
      this.uId = "",
      this.image});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'cover': cover,
      'email': email,
      'password': password,
      'uId': uId,
      'phone': phone,
    };
  }

  UserModel.fromJson(Map<String, dynamic> Json) {
    email = Json['email'];
    image = Json['image'];
    name = Json['name'];
    password = Json['password'];
    uId = Json['uId'];
    phone = Json['phone'];
    cover = Json['cover'];
  }
}
