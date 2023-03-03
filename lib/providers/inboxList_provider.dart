import 'package:flutter/cupertino.dart';
import '../features/chatapp/services/inbox_servies.dart';
import '../models/inbox.dart';

class InboxListProvider extends ChangeNotifier {
  List<ChatModel> _myList = [];
  // ChatModel.fromJson({
  //   "conversation_id": 208,
  //   "unread_count": 0,
  //   "user_id": 3339,
  //   "username": "m_saimhashmi",
  //   "isOnline": false,
  //   "userimage":
  //       "//storage/users/3339/profile/display_picture/JHkKzqfdjr5BHpgtfs7eow28UleTPO3CEE6daAph.png",
  //   "alphabeticUserImage": "M",
  //   "last_message": "IMG-20230125-WA0013.jpg",
  //   "last_message_datetime": "25-Jan-2023  08:29"
  // }),
  // ];
  final ChatRemoteService chatRemoteService = ChatRemoteService();

  List<ChatModel> get myList => _myList;

  Future<void> getInboxListDataFromApi() async {
    print('in provider function');
    try {
      final ChatRemoteService chatRemoteService = ChatRemoteService();
      // _myList = await chatRemoteService.getConversationListApi() ?? [];
      List<ChatModel> inboxList =
          await chatRemoteService.getConversationListApi() ?? [];
      if (inboxList.isNotEmpty) {
        if (_myList.isNotEmpty) {
          if (inboxList.first.username != _myList.first.username ||
              inboxList.first.lastMessage != _myList.first.lastMessage ||
              inboxList.first.lastMessageDateTime !=
                  _myList.first.lastMessageDateTime ||
              inboxList.first.unreadCount != _myList.first.unreadCount) {
            _myList = inboxList;
            notifyListeners();
          }
        } else {
          _myList = inboxList;
          notifyListeners();
        }
      }
    } catch (error) {
      debugPrint('Error fetching data from API: $error');
    }
    // Future.delayed(
    //   const Duration(seconds: 5),
    //   () => getInboxListDataFromApi(),
    // );
  }

  void addItem(ChatModel item) {
    _myList.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _myList.removeAt(index);
    notifyListeners();
  }
}
