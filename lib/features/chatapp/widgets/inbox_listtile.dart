import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';
import '../screens/chatroom_screen.dart';

class InboxListTile extends StatelessWidget {
  int index;
  InboxListTile({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ChatroomScreen.routeName,
        arguments: ChatMaterial.inboxDataList[index],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            // "assets/images/clientimage.png",
            ChatMaterial.inboxDataList[index]['image']!,
          ),
          radius: 22.5,
        ),
        title: Text(
          // 'Samad Ilyas',
          ChatMaterial.inboxDataList[index]['name']!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          // 'update me regarding app update me regarding app update me regarding ap p update me regarding app update me regarding app update me regarding app',
          ChatMaterial.inboxDataList[index]['msg']!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text('10:42 PM'),
            // Badge(
            //   badgeColor: const Color.fromRGBO(138, 165, 255, 1),
            //   badgeContent: const Text('3'),
            // ),
          ],
        ),
      ),
    );
  }
}
