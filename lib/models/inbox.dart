import 'dart:convert';

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

class InboxList {
  final int conversationId;
  final int unreadCount;
  final int userId;
  final String username;
  final bool isOnline;
  final String userimage;
  final String alphabeticUserImage;
  final String lastMessage;
  final String lastMessageDateTime;

  InboxList({
    required this.conversationId,
    required this.unreadCount,
    required this.userId,
    required this.username,
    required this.isOnline,
    required this.userimage,
    required this.alphabeticUserImage,
    required this.lastMessage,
    required this.lastMessageDateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'conversation_id': conversationId,
      'unread_count': unreadCount,
      'user_id': userId,
      'username': username,
      'isOnline': isOnline,
      'userimage': userimage,
      'alphabeticUserImage': alphabeticUserImage,
      'last_message': lastMessage,
      'last_message_datetime': lastMessageDateTime,
    };
  }

  factory InboxList.fromMap(Map<String, dynamic> map) {
    return InboxList(
      conversationId: map['conversation_id']?.toInt() ?? 0,
      unreadCount: map['unread_count']?.toInt() ?? 0,
      userId: map['user_id']?.toInt() ?? 0,
      username: map['username'] ?? '',
      isOnline: map['isOnline'] ?? false,
      userimage: map['userimage'] ??
          'https://profiles.ucr.edu/app/images/default-profile.jpg',
      alphabeticUserImage: map['alphabeticUserImage'] ?? '',
      lastMessage: map['last_message'] ?? '',
      lastMessageDateTime: map['last_message_datetime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InboxList.fromJson(String source) =>
      InboxList.fromMap(json.decode(source));
}
