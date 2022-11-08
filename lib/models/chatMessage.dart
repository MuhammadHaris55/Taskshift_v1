import 'dart:convert';

class ChatMessage {
  final int mid;
  final String message;
  final String alertTypeMessage;
  final String type;
  final int userid;
  final String userRole;
  final String userName;
  final String userimage;
  final String userimageUrl;
  final String alphabeticUserImage;
  final int clientid;
  final String status;
  final String created;
  // final int? attachment_id;
  final int? attachmentId;
  final String? url;
  final String? filename;
  final String? extension;
  final String? size;

  ChatMessage(
    this.mid,
    this.message,
    this.alertTypeMessage,
    this.type,
    this.userid,
    this.userRole,
    this.userName,
    this.userimage,
    this.userimageUrl,
    this.alphabeticUserImage,
    this.clientid,
    this.status,
    this.created,
    this.attachmentId,
    this.url,
    this.filename,
    this.extension,
    this.size,
  );

  Map<String, dynamic> toMap() {
    return {
      'mid': mid,
      'message': message,
      'alert_type_message': alertTypeMessage,
      'type': type,
      'userid': userid,
      'user_role': userRole,
      'user_name': userName,
      'userimage': userimage,
      'userimage_url': userimageUrl,
      'alphabeticUserImage': alphabeticUserImage,
      'clientid': clientid,
      'status': status,
      'created': created,
      'attachment_id': attachmentId,
      'url': url,
      'filename': filename,
      'extension': extension,
      'size': size,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      map['mid']?.toInt() ?? 0,
      map['message'] ?? '',
      map['alert_type_message'] ?? '',
      map['type'] ?? '',
      map['userid']?.toInt() ?? 0,
      map['user_role'] ?? '',
      map['user_name'] ?? '',
      map['userimage'] ?? '',
      map['userimage_url'] ?? '',
      map['alphabeticUserImage'] ?? '',
      map['clientid']?.toInt() ?? 0,
      map['status'] ?? '',
      map['created'] ?? '',
      map['attachment_id']?.toInt() ?? 0,
      map['url'] ?? '',
      map['filename'] ?? '',
      map['extension'] ?? '',
      map['size'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source));
}
