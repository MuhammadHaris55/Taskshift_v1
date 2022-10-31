import 'package:flutter/material.dart';
import 'package:taskshift_v1/features/chatapp/widgets/receiver_chat_bubble.dart';
import 'package:taskshift_v1/features/chatapp/widgets/sender_chat_bubble.dart';

import '../../../constants/global_variables.dart';

class ChatroomScreen extends StatelessWidget {
  static const routeName = '/chatroom-screen';
  Map<String, String> receiver;

  ChatroomScreen({
    Key? key,
    required this.receiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              minRadius: 22.5,
              backgroundImage: AssetImage(
                receiver['image']!,
              ),
              // radius: 30,
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  receiver['name']!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: appFontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const Text(
                  'Online',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontFamily: appFontFamily,
                  ),
                ),
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
              itemCount: ChatMaterial.messagesList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Column(
                  children: [
                    ChatMaterial.messagesList[index]['id'] == '1'
                        ? ReceiverChatBubble(
                            image: receiver['image']!,
                            message: ChatMaterial.messagesList[index]['msg']!,
                          )
                        : SenderChatBubble(
                            message: ChatMaterial.messagesList[index]['msg']!),
                  ],
                ),
              ),
            ),
          ),
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
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                floatingLabelStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: AppColors.colorBlue,
                    size: 30.0,
                  ),
                ),
                hintText: "Write a message",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
