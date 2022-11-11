import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:taskshift_v1/models/onlineStatus.dart';
import '../../../constants/global_variables.dart';

class ChatServices {
  Future<bool?> getOnlineStatus(int conversationId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('x-auth-token') ?? '';
      http.Response response = await http.get(
        Uri.parse('${Apis.getReceiverOnlineStatus}$conversationId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        List<OnlineStatus> resConverse = [];
        resConverse.add(OnlineStatus.fromJson(response.body));
        return resConverse.first.userIsOnline;
      }
    } catch (e) {
      debugPrint('catch --> ${e.toString()}');
    }
    return null;
  }
}
