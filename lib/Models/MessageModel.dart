class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;

  MessageModel({
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
    required this.text,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'dateTime': dateTime,
      'receiverId': receiverId,
      'senderId': senderId,
    };
  }

  MessageModel.fromJson(Map<String, dynamic> Json) {
    senderId = Json['senderId'];
    text = Json['text'];
    dateTime = Json['dateTime'];
    receiverId = Json['receiverId'];
  }
}
