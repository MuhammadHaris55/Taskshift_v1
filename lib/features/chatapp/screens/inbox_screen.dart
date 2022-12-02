import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskshift_v1/common/widgets/custom_text_widget.dart';
import 'package:taskshift_v1/features/chatapp/screens/chatroom_screen.dart';
import 'package:taskshift_v1/features/chatapp/services/inbox_servies.dart';
import 'package:taskshift_v1/models/inbox.dart';
import 'package:taskshift_v1/providers/user_provider.dart';
import '../../../constants/global_variables.dart';

class InboxScreen extends StatefulWidget {
  static const routeName = '/inbox-screen';

  static var conversationList;

  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<ChatModel> conversationList = [];
  String image = 'https://profiles.ucr.edu/app/images/default-profile.jpg';
  bool loadingChat = false;
  final ChatRemoteService chatRemoteService = ChatRemoteService();

  @override
  void initState() {
    super.initState();
    getConversationList();
    // sharedPrefImage();
  }

  // sharedPrefImage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String prefImage = prefs.getString('image') ?? '';
  //   if (prefImage.isNotEmpty) {
  //     print(prefImage);
  //     image = prefImage;
  //   }
  // }

  Future<void> getConversationList() async {
    loadingChat = true;
    var responseList = await chatRemoteService.getConversationListApi();
    if (responseList != null) {
      conversationList = responseList;
      loadingChat = false;
      setState(() {});
    }
    Future.delayed(
      const Duration(seconds: 5),
      () => getConversationList(),
    );
  }

  List<ChatModel> searchresult = [];
  searchInList(String val) {
    searchresult = [];
    if (val.isNotEmpty) {
      searchresult = conversationList
          .where((item) =>
              ((item.username!.toLowerCase().contains(val.toLowerCase()))))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    image = context.watch<UserProvider>().user.image;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: SubtitleText(text: 'Inbox'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0.w),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    minRadius: 30,
                    backgroundColor: const Color.fromRGBO(142, 142, 142, 0.5),
                    backgroundImage: CachedNetworkImageProvider(
                      image,
                    ),
                    // AssetImage(
                    //   image,
                    // ),
                    // radius: 30,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      onChanged: (val) => searchInList(val),
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
              searchresult.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: searchresult!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.pushNamed(
                                context,
                                ChatroomScreen.routeName,
                                arguments: searchresult![index],
                              ),
                              child: ListTile(
                                leading: Stack(
                                  clipBehavior: Clip.none,
                                  // fit: StackFit.expand,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: const Color.fromRGBO(
                                          142, 142, 142, 0.5),
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        '$uri${conversationList![index].userimage!}',
                                        // 'https://profiles.ucr.edu/app/images/default-profile.jpg',
                                      ),
                                      //     NetworkImage(
                                      //   '$uri${conversationList![index].userimage!}',
                                      // ),
                                      radius: 22.5,
                                    ),
                                    Positioned(
                                      width: 11.0.w,
                                      height: 11.0.h,
                                      top: 38.0.h,
                                      left: 30.0.w,
                                      child: RawMaterialButton(
                                        onPressed: () {},
                                        elevation: 2.0,
                                        fillColor:
                                            conversationList![index].isOnline!
                                                ? Colors.green
                                                : Colors.red,
                                        shape: const CircleBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  searchresult![index].username!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  searchresult![index].lastMessage!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      searchresult![index]
                                          .lastMessageDateTime!
                                          .split(' ')
                                          .last,
                                    ),
                                    searchresult[index].unreadCount! > 0
                                        ? Badge(
                                            badgeColor: const Color.fromRGBO(
                                                138, 165, 255, 1),
                                            badgeContent: const Text('3'),
                                          )
                                        : const SizedBox(
                                            height: 10.0, width: 10.0),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: getConversationList,
                        child: conversationList.isEmpty
                            ? Center(
                                child: loadingChat
                                    ? const CircularProgressIndicator()
                                    : const Text('Don\'t have chat yet'))
                            : ListView.builder(

                                /// here we are counting length of list of conversation
                                itemCount: conversationList!.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    // onTap: () {
                                    //   FocusScopeNode currentFocus =
                                    //       FocusScope.of(context);
                                    //   // if (!currentFocus.hasPrimaryFocus &&
                                    //   //     currentFocus.focusedChild != null) {
                                    //   //   FocusManager.instance.primaryFocus?.unfocus();
                                    //   // } else {
                                    //   Navigator.pushNamed(
                                    //     context,
                                    //     ChatroomScreen.routeName,
                                    //     arguments: conversationList![index],
                                    //   );
                                    //   // }
                                    // },
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      ChatroomScreen.routeName,
                                      arguments: conversationList![index],
                                    ),
                                    child: ListTile(
                                      leading: SizedBox(
                                        // width: 45.0,
                                        // height: 45.0,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          // fit: StackFit.expand,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      142, 142, 142, 0.5),
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                '$uri${conversationList![index].userimage!}',
                                                // 'https://profiles.ucr.edu/app/images/default-profile.jpg',
                                              ),
                                              radius: 22.5,
                                            ),
                                            Positioned(
                                              width: 11.0.w,
                                              height: 11.0.h,
                                              // top: 38.0.h,
                                              // left: 30.0.w,
                                              bottom: 2.0.h,
                                              right: 2.0.w,
                                              child: RawMaterialButton(
                                                onPressed: null,
                                                elevation: 2.0,
                                                fillColor:
                                                    conversationList![index]
                                                            .isOnline!
                                                        ? Colors.green
                                                        : Colors.red,
                                                shape: const CircleBorder(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      title: Text(
                                        // 'Samad Ilyas',
                                        conversationList![index].username!,
                                        overflow: TextOverflow.ellipsis,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            //'10:42 PM'
                                            conversationList![index]
                                                .lastMessageDateTime!
                                                .split(' ')
                                                .last,
                                          ),
                                          conversationList[index].unreadCount! >
                                                  0
                                              ? Badge(
                                                  badgeColor:
                                                      const Color.fromRGBO(
                                                          138, 165, 255, 1),
                                                  badgeContent: const Text('3'),
                                                )
                                              : const SizedBox(
                                                  height: 10.0, width: 10.0),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
