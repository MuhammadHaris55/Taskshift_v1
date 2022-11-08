import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskshift_v1/common/widgets/bottom_bar.dart';
import 'package:taskshift_v1/features/chatapp/screens/inbox_screen.dart';
import 'package:taskshift_v1/features/chatapp/widgets/receiver_chat_bubble.dart';
import 'package:taskshift_v1/features/chatapp/widgets/sender_chat_bubble.dart';
import 'package:taskshift_v1/models/chatMessage.dart';

import '../../../constants/global_variables.dart';
import '../../../models/inbox.dart';
import '../services/inbox_servies.dart';

class ChatroomScreen extends StatefulWidget {
  static const routeName = '/chatroom-screen';
  ChatModel receiver;

  ChatroomScreen({
    Key? key,
    required this.receiver,
  }) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  List<ChatMessage>? conversationList = [];
  late SharedPreferences prefs;
  late int userId;
  bool disposeFunc = false;
  PlatformFile? pickedFile;

  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    disposeFunc = false;
    getMessageList();
  }

  Future getMessageList() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('userId') ?? 0;
    var responseList = await ChatRemoteService()
        .getMessageListApi(widget.receiver.conversationId!.toInt());
    if (responseList != null) {
      conversationList = responseList;
      print('messageList ---> $conversationList');
    }
    setState(() {});
    if (disposeFunc == false) {
      Future.delayed(const Duration(seconds: 3), () => {getMessageList()});
    }
  }

  void sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      print(messageController.text.trim());
      ChatRemoteService().sendMessage(
        userId,
        conversationList![0].clientid,
        widget.receiver.conversationId!.toInt(),
        messageController.text.trim(),
      );

      ChatMessage msgObj = ChatMessage.fromJson(
        jsonEncode({
          "mid": 0,
          "message": messageController.text.trim(),
          "alert_type_message": "",
          "type": "message",
          "userid": userId,
          "user_role": "user",
          "user_name": "chelseaelliot",
          "userimage":
              "/storage/users/393/profile/display_picture/WDLLZl7cK8vq8rGQe8GD9oMTLhx1BO1Ah7bSBNSH.png",
          "userimage_url":
              "https://taskshift.com/storage/users/393/profile/display_picture/WDLLZl7cK8vq8rGQe8GD9oMTLhx1BO1Ah7bSBNSH.png",
          "alphabeticUserImage": "C",
          "clientid": conversationList![0].clientid,
          "status": "un_read",
          "created": ""
        }),
      );
      conversationList!.insert(0, msgObj);
      messageController.clear();
      getMessageList();
      setState(() {});
    }
  }

  selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'docx',
        'pptx',
        'pdf',
        'xlsx',
        'zip',
        'rar',
        'gz'
      ],
    );
    if (result == null) return;

    final file = File(result.files.single.path!);
    ChatRemoteService().uploadImage(
      context,
      userId,
      conversationList![0].clientid,
      widget.receiver.conversationId!.toInt(),
      result.files.single,
    );
    // ChatRemoteService().uploadImage(file.path);

    // setState(() {
    //   pickedFile = result.files.first;
    // });
    getMessageList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        disposeFunc = true;
        Timer(
          const Duration(seconds: 2),
          () => Navigator.pushNamed(context, BottomBar.routeName),
        );
        // Navigator.pushNamed(context, BottomBar.routeName);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          titleSpacing: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false),
            icon: const Icon(
              Icons.arrow_back_sharp,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                minRadius: 22.5,
                backgroundColor: const Color.fromRGBO(142, 142, 142, 0.5),
                backgroundImage: CachedNetworkImageProvider(
                  '$uri${widget.receiver.userimage!}',
                ),
                // AssetImage(
                //   widget.receiver.userimage!,
                // ),
                // radius: 30,
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receiver.username!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: appFontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  // Text(
                  //   widget.receiver.isOnline! ? 'Online' : 'Offline',
                  //   style: const TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 12.0,
                  //     fontFamily: appFontFamily,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                // itemCount: ChatMaterial.messagesList.length,
                itemCount: conversationList!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Column(
                    children: [
                      // ReceiverChatBubble(
                      //   image: conversationList![index].userimageUrl,
                      //   message: conversationList![index].message,
                      // ),
                      conversationList![index].userid == userId
                          ? SenderChatBubble(
                              message: conversationList![index].message,
                              time: conversationList![index].created,
                              url: conversationList![index].url,
                              // message: ChatMaterial.messagesList[index]['msg']!,
                            )
                          : ReceiverChatBubble(
                              image: widget.receiver.userimage!,
                              message: conversationList![index].message,
                              time: conversationList![index].created,
                              url: conversationList![index].url,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   child: Text(pickedFile!.name),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.colorGrey,
                    width: 0.5,
                  ),
                ),
              ),
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  floatingLabelStyle: TextStyle(color: Colors.grey[600]),
                  border: InputBorder.none,
                  suffixIcon: SizedBox(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: selectFile,
                          icon: const Icon(
                            Icons.attachment_sharp,
                            color: AppColors.colorBlue,
                            size: 25.0,
                          ),
                        ),
                        IconButton(
                          onPressed: sendMessage,
                          icon: const Icon(
                            Icons.send,
                            color: AppColors.colorBlue,
                            size: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hintText: "Write a message",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
