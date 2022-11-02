class ChatModel {
  int? conversationId;
  int? unreadCount;
  int? userId;
  String? username;
  bool? isOnline;
  String? userimage;
  String? alphabeticUserImage;
  String? lastMessage;
  String? lastMessageDateTime;

  ChatModel(
      {this.conversationId,
      this.unreadCount,
      this.userId,
      this.username,
      this.isOnline,
      this.userimage,
      this.alphabeticUserImage,
      this.lastMessage,
      this.lastMessageDateTime});

  ChatModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversation_id'];
    unreadCount = json['unread_count'];
    userId = json['user_id'];
    username = json['username'];
    isOnline = json['isOnline'];
    userimage = json['userimage'];
    alphabeticUserImage = json['alphabeticUserImage'];
    lastMessage = json['last_message'];
    lastMessageDateTime = json['last_message_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conversation_id'] = this.conversationId;
    data['unread_count'] = this.unreadCount;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['isOnline'] = this.isOnline;
    data['userimage'] = this.userimage;
    data['alphabeticUserImage'] = this.alphabeticUserImage;
    data['last_message'] = this.lastMessage;
    data['last_message_datetime'] = this.lastMessageDateTime;

    return data;
    print(data);
  }
}
