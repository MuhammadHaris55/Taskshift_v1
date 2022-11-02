import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:taskshift_v1/models/inbox.dart';

class ChatRemoteService {
//  Future<String?> token1 =  RemoteService().getToken();
  // String token ='X276T8hZsglKnwnYf9GOs34yzBQqPJYOLbT20tuyvhjSnxcOCbbLf38KOR4RkNS99Tfl6keU9ei8fNuF';

  Future<List<ChatModel>?> getConversationListApi() async {
    String token =
        'X276T8hZsglKnwnYf9GOs34yzBQqPJYOLbT20tuyvhjSnxcOCbbLf38KOR4RkNS99Tfl6keU9ei8fNuF';
    // var client = http.Client();
    http.Response response = await http
        .post(Uri.parse('https://taskshift.com/api/getchat'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': token,
      'Authorization': "Bearer $token"
    });

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseConversationList, response.body);
  }

// A function that converts a response body into a List<Photo>.
  List<ChatModel> parseConversationList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    // List<ChatModel> a1 =
    parsed.map<ChatModel>((json) => ChatModel.fromJson(json)).toList();
    // for (var element in a1) {
    //   print('element :' + element.lastMessageDateTime.toString());
    // }
    return parsed.map<ChatModel>((json) => ChatModel.fromJson(json)).toList();
  }
}
