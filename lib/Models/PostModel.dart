class PostModel {
  late String uId;
  String? name;
  String? image;
  String? postImage;
  String? dateTime;
  String? text;

  PostModel({
    required this.name,
    this.uId = "",
    this.image,
    this.dateTime,
    this.postImage,
    this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'uId': uId,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
    };
  }

  PostModel.fromJson(Map<String, dynamic> Json) {
    image = Json['image'];
    name = Json['name'];
    uId = Json['uId'];
    text = Json['text'];
    dateTime = Json['dateTime'];
    postImage = Json['postImage'];
  }
}
