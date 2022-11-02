import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/common/widgets/custom_text_widget.dart';
import 'package:taskshift_v1/features/chatapp/screens/chatroom_screen.dart';
import 'package:taskshift_v1/features/chatapp/services/inbox_servies.dart';
import 'package:taskshift_v1/models/inbox.dart';
import '../../../constants/global_variables.dart';

class InboxScreen extends StatefulWidget {
  static const routeName = '/inbox-screen';

  static var conversationList;

  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<ChatModel>? conversationList = [];

  @override
  void initState() {
    super.initState();
    getConversationList();
  }

  void getConversationList() async {
    var responseList = await ChatRemoteService().getConversationListApi();
    if (responseList != null) {
      conversationList = responseList;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: SubtitleText(text: 'Inbox'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  minRadius: 30,
                  backgroundImage: AssetImage(
                    ChatMaterial.userDP,
                  ),
                  // radius: 30,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      focusColor: Colors.grey[600],
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      floatingLabelStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[600],
                      ),
                      prefixIconColor: Colors.grey[600],
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      hintText: "Search",
                      fillColor: const Color.fromRGBO(112, 112, 112, 0.05),
                    ),
                    cursorColor: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: conversationList != null
                  ? ListView.builder(

                      /// here we are counting length of list of conversation
                      itemCount: conversationList!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            ChatroomScreen.routeName,
                            arguments: conversationList![index],
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(
                                // "assets/images/clientimage.png",
                                conversationList![index].userimage!,
                              ),
                              radius: 22.5,
                            ),
                            title: Text(
                              // 'Samad Ilyas',
                              conversationList![index].username!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              // 'update me regarding app update me regarding app update me regarding ap p update me regarding app update me regarding app update me regarding app',
                              conversationList![index].lastMessage!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  //'10:42 PM'
                                  conversationList![index].lastMessageDateTime!,
                                ),
                                // Badge(
                                //   badgeColor: const Color.fromRGBO(138, 165, 255, 1),
                                //   badgeContent: const Text('3'),
                                // ),
                              ],
                            ),
                          ),
                        );
                      })
                  : const Text("wait...."),
            ),
          ],
        ),
      ),
    );
  }
}
