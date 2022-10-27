import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskshift_v1/common/widgets/custom_text_widget.dart';
import 'package:taskshift_v1/features/chatapp/widgets/inbox_listtile.dart';
import '../../../constants/global_variables.dart';

class InboxScreen extends StatefulWidget {
  static const routeName = '/inbox-screen';
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: SubtitleText(text: 'Inbox'),
        // const Text(
        //   'Inbox',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontFamily: appFontFamily,
        //   ),
        // ),
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
                      prefixIcon: Icon(Icons.search, color: Colors.grey[600],),
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
              child: ListView.builder(
                itemCount: ChatMaterial.inboxDataList.length,
                itemBuilder: (context, index) => InboxListTile(index: index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
