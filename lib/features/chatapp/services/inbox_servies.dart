import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskshift_v1/constants/global_variables.dart';
import 'package:taskshift_v1/constants/utils.dart';
import 'package:taskshift_v1/models/chatMessage.dart';
import 'package:taskshift_v1/models/inbox.dart';

class ChatRemoteService {
  Future<List<ChatModel>?> getConversationListApi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('x-auth-token') ?? '';
    // 'uWIUvZckMLuiAkyZ1hTr1nt4zqbu1nSl0meUXO2Xw6iFTthbmiZrUhveh4250sPhAxMnA7sSzYxDnEkP';
    http.Response response = await http.post(
      Uri.parse(Apis.getChat),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': token,
        'Authorization': "Bearer $token"
      },
    );

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

  Future<List<ChatMessage>?> getMessageListApi(int conversationId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('x-auth-token') ?? '';
    // 'uWIUvZckMLuiAkyZ1hTr1nt4zqbu1nSl0meUXO2Xw6iFTthbmiZrUhveh4250sPhAxMnA7sSzYxDnEkP';

    http.Response response = await http.post(
      Uri.parse(Apis.getMessage),
      headers: {
        'Authorization': "Bearer $token",
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "active": conversationId.toString(),
      }),
    );
    var res = jsonDecode(response.body);
    List<ChatMessage> chatList = [];

    for (var i = 0; i < res.length; i++) {
      chatList.add(ChatMessage.fromJson(jsonEncode(res[i])));
    }

    // ---------------------------------- to make conversation status READ
    conversationStatusRead(token, conversationId);

    print('chatLIst ----> $chatList');
    print('res ---> $res');
    return chatList;
  }

  conversationStatusRead(String token, int conversationId) async {
    await http.post(
      Uri.parse(Apis.msgStatusRead),
      headers: {
        'Authorization': "Bearer $token",
        'Content-type': 'application/json',
      },
      body: jsonEncode({
        "conversation": conversationId,
        "read_status": "read",
      }),
    );
    // ---------------------------------- to make conversation status READ
  }

  // ----------------------Send message function
  void sendMessage(
      int userId, int clientId, int conversationId, String msg) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('x-auth-token') ?? '';

    print(
        'the function variables ---> $userId --- $clientId -- $conversationId --- $msg ---$token');

    http.Response response = await http.post(
      Uri.parse(Apis.sendMessage),
      headers: {
        'Authorization': "Bearer $token",
        'Content-Type': "application/json",
      },
      body: jsonEncode({
        'user_id': userId.toInt(),
        'client_id': clientId.toInt(),
        'conversation_id': conversationId.toInt(),
        'messages': msg.toString(),
      }),
    );

    print('send msg --- > ${response.body.toString()}');
  }

  // Future<String>
  uploadImage(BuildContext context, int userId, int clientId,
      int conversationId, var file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('x-auth-token') ?? '';
    print('filename -- ${file.name}');
    print('file path -- ${file.path}');
    print(file.toString());
    var request = http.MultipartRequest('POST', Uri.parse(Apis.sendMessage));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));
    request.headers.addAll({
      'Authorization': "Bearer $token",
      'Content-Type': "multipart/form-data",
    });
    Map<String, String> body = {
      'user_id': userId.toString(),
      'client_id': clientId.toString(),
      'conversation_id': conversationId.toString(),
      // 'messages': msg.toString(),
      'messages': file.name,
    };
    request.fields.addAll(body);
    var res = await request.send();
    print('file status --> ${res.statusCode}');
    print('file reason pharase --> ${res.reasonPhrase}');
    showSnackBar(context, 'error ${res.reasonPhrase}');
    // return res.reasonPhrase;
  }
}
