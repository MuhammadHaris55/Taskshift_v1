import 'dart:convert';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String userName;
  final String displayName;
  final String email;
  final String remainingBids;
  final String apiToken;
  final String profileviewas;
  final String image;
  final String alphabeticImage;
  final String identityVerify;
  final String contactVerify;
  final List<String> skills;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.displayName,
    required this.email,
    required this.remainingBids,
    required this.apiToken,
    required this.profileviewas,
    required this.image,
    required this.alphabeticImage,
    required this.identityVerify,
    required this.contactVerify,
    required this.skills,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'user_name': userName,
      'display_name': displayName,
      'email': email,
      'remainingBids': remainingBids,
      'api_token': apiToken,
      'profileviewas': profileviewas,
      'image': image,
      'alphabetic_image': alphabeticImage,
      'identity_verify': identityVerify,
      'contact_verify': contactVerify,
      'skills': skills,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      userName: map['user_name'] ?? '',
      displayName: map['display_name'] ?? '',
      email: map['email'] ?? '',
      remainingBids: map['remainingBids'] ?? '',
      apiToken: map['api_token'] ?? '',
      profileviewas: map['profileviewas'] ?? '',
      image: map['image'] ?? '',
      alphabeticImage: map['alphabetic_image'] ?? '',
      identityVerify: map['identity_verify'] ?? '',
      contactVerify: map['contact_verify'] ?? '',
      skills: List<String>.from(map['skills']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

}

// class User {
//   final String first_name;
//   final String last_name;
//   final String user_name;
//   final String display_name;
//   final String email;
//   final String remainingBids;
//   final String api_token;
//   final String profileviewas;
//   final String image;
//   final String alphabetic_image;
//   final String identity_verify;
//   final String contact_verify;
//   final List<String> skills;

//   User({
//     required this.first_name,
//     required this.last_name,
//     required this.user_name,
//     required this.display_name,
//     required this.email,
//     required this.remainingBids,
//     required this.api_token,
//     required this.profileviewas,
//     required this.image,
//     required this.alphabetic_image,
//     required this.identity_verify,
//     required this.contact_verify,
//     required this.skills,
//   });
// // [
// //     "Inbound Call Center",
// //     "Telemarketing Services"
// // ]


//   Map<String, dynamic> toMap() {
//     return {
//       'first_name': first_name,
//       'last_name': last_name,
//       'user_name': user_name,
//       'display_name': display_name,
//       'email': email,
//       'remainingBids': remainingBids,
//       'api_token': api_token,
//       'profileviewas': profileviewas,
//       'image': image,
//       'alphabetic_image': alphabetic_image,
//       'identity_verify': identity_verify,
//       'contact_verify': contact_verify,
//       'skills': skills,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       first_name: map['first_name'] ?? '',
//       last_name: map['last_name'] ?? '',
//       user_name: map['user_name'] ?? '',
//       display_name: map['display_name'] ?? '',
//       email: map['email'] ?? '',
//       remainingBids: map['remainingBids'] ?? '',
//       api_token: map['api_token'] ?? '',
//       profileviewas: map['profileviewas'] ?? '',
//       image: map['image'] ?? '',
//       alphabetic_image: map['alphabetic_image'] ?? '',
//       identity_verify: map['identity_verify'] ?? '',
//       contact_verify: map['contact_verify'] ?? '',
//       skills: List<String>.from(map['skills']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));
// }
