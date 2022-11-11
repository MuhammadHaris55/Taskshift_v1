import 'dart:convert';

class OnlineStatus {
//    3339,
//  393,
//  "open",
//  "22 minutes ago",
//  false,
//  "m_saimhashmi"

// user_id
// client_id
// status
// user_last_active_at
// user_is_online
// user_full_name
  final int userId;
  final int clientId;
  final String status;
  final String userLastActiveAt;
  final bool userIsOnline;
  final String userFullName;
  OnlineStatus({
    required this.userId,
    required this.clientId,
    required this.status,
    required this.userLastActiveAt,
    required this.userIsOnline,
    required this.userFullName,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'client_id': clientId,
      'status': status,
      'user_last_active_at': userLastActiveAt,
      'user_is_online': userIsOnline,
      'user_full_name': userFullName,
    };
  }

  factory OnlineStatus.fromMap(Map<String, dynamic> map) {
    return OnlineStatus(
      userId: map['user_id']?.toInt() ?? 0,
      clientId: map['client_id']?.toInt() ?? 0,
      status: map['status'] ?? '',
      userLastActiveAt: map['user_last_active_at'] ?? '',
      userIsOnline: map['user_is_online'] ?? false,
      userFullName: map['user_full_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OnlineStatus.fromJson(String source) =>
      OnlineStatus.fromMap(json.decode(source));
}

// / / class OnlineStatus {
//   int? userId;
//   int? clientId;
//   String? status;
//   String? userLastActiveAt;
//   bool? userIsOnline;
//   String? userFullName;

//   OnlineStatus(
//       {this.userId,
//       this.clientId,
//       this.status,
//       this.userLastActiveAt,
//       this.userIsOnline,
//       this.userFullName});

//   OnlineStatus.fromJson(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     clientId = json['client_id'];
//     status = json['status'];
//     userLastActiveAt = json['user_last_active_at'];
//     userIsOnline = json['user_is_online'];
//     userFullName = json['user_full_name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = Map<String, dynamic>();
//     data['user_id'] = userId;
//     data['client_id'] = clientId;
//     data['status'] = status;
//     data['user_last_active_at'] = userLastActiveAt;
//     data['user_is_online'] = userIsOnline;
//     data['user_full_name'] = userFullName;
//     return data;
//   }
// }
