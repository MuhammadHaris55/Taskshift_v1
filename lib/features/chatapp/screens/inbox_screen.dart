import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../../../constants/global_variables.dart';
import '../../../models/inbox.dart';
import '../../../providers/inboxList_provider.dart';
import '../../../providers/user_provider.dart';
import '../services/inbox_servies.dart';
import 'chatroom_screen.dart';

class InboxScreen extends StatefulWidget {
  static const routeName = '/inbox-screen';

  static var conversationList;

  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<ChatModel> conversationList = [];
  bool loadingChat = false;
  final ChatRemoteService chatRemoteService = ChatRemoteService();

  @override
  void initState() {
    super.initState();
    getConversationList();
  }

  Future<void> getConversationList() async {
    loadingChat = true;
    var responseList = await chatRemoteService.getConversationListApi();
    if (responseList != null) {
      if (responseList.isNotEmpty) {
        print("list of inbox----> ${responseList.first.userimage}");
        conversationList = responseList;
      }
    }
    loadingChat = false;
    setState(() {});
    print("In getConverationlist function outside if");
    Future.delayed(
      const Duration(seconds: 5),
      () => getConversationList(),
    );
  }

  List<ChatModel> searchresult = [];
  searchInList(String val, BuildContext context) {
    searchresult = [];
    if (val.isNotEmpty) {
      var inboxprovider =
          Provider.of<InboxListProvider>(context, listen: false);
      searchresult =
          // conversationList
          inboxprovider.myList
              .where((item) =>
                  ((item.username!.toLowerCase().contains(val.toLowerCase()))))
              .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var inboxprovider = context.watch<InboxListProvider>();
    inboxprovider.getInboxListDataFromApi();
    // inboxListProvider.getInboxListDataFromApi();
    // var userData = context.watch<UserProvider>().user;
    // image = context.watch<UserProvider>().user.image;
    print("build function");
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
                  // CircleAvatar(
                  //   minRadius: 30,
                  //   backgroundColor: const Color.fromRGBO(142, 142, 142, 0.5),
                  //   backgroundImage: CachedNetworkImageProvider(
                  //     image,
                  //   ),
                  // ),
                  Consumer<UserProvider>(
                    builder: (context, userData, child) {
                      return Stack(
                        clipBehavior: Clip.none,
                        // fit: StackFit.expand,
                        children: [
                          // conversationList![index].userimage!.isEmpty
                          //     ? CircleAvatar(
                          //         backgroundColor:
                          //             const Color.fromRGBO(142, 142, 142, 0.5),
                          //         radius: 22.5,
                          //         child: Text(
                          //           conversationList![index]
                          //               .alphabeticUserImage!,
                          //           style: const TextStyle(
                          //             color: Colors.black,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 22.0,
                          //           ),
                          //         ),
                          //       )
                          //     : CircleAvatar(
                          //         backgroundColor:
                          //             const Color.fromRGBO(142, 142, 142, 0.5),
                          //         backgroundImage: CachedNetworkImageProvider(
                          //           '$uri${conversationList![index].userimage!}',
                          //           // 'https://profiles.ucr.edu/app/images/default-profile.jpg',
                          //         ),
                          //         //     NetworkImage(
                          //         //   '$uri${conversationList![index].userimage!}',
                          //         // ),
                          //         radius: 22.5,
                          //       ),
                          ClipOval(
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromRGBO(142, 142, 142, 0.5),
                              radius: 30,
                              child: userData.user.image.isEmpty
                                  ? Text(
                                      userData.user.alphabeticImage,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                      ),
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: '$uri${userData.user.image}',
                                      placeholder: (context, url) =>
                                          const SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                            ),
                          ),
                          Positioned(
                            width: 11.0.w,
                            height: 11.0.h,
                            // top: 38.0.h,
                            // left: 30.0.w,
                            bottom: 3.0.h,
                            right: 3.0.w,
                            child: RawMaterialButton(
                              onPressed: () {},
                              elevation: 2.0,
                              fillColor:
                                  // netConnected == false ? Colors.red :
                                  Colors.green,
                              shape: const CircleBorder(),
                            ),
                          ),
                        ],
                      );
                      // ClipOval(
                      //   child: CircleAvatar(
                      //     backgroundColor:
                      //         const Color.fromRGBO(142, 142, 142, 0.5),
                      //     radius: 30,
                      //     child: userData.user.image.isEmpty
                      //         ? Text(
                      //             userData.user.alphabeticImage,
                      //             style: const TextStyle(
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 22.0,
                      //             ),
                      //           )
                      //         : CachedNetworkImage(
                      //             imageUrl: '$uri${userData.user.image}',
                      //             placeholder: (context, url) => const SizedBox(
                      //                 height: 20.0,
                      //                 width: 20.0,
                      //                 child: CircularProgressIndicator()),
                      //             errorWidget: (context, url, error) =>
                      //                 const Icon(Icons.error),
                      //           ),
                      //   ),
                      // );
                    },
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      onChanged: (val) => searchInList(val, context),
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
                                    conversationList![index].userimage!.isEmpty
                                        ? CircleAvatar(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    142, 142, 142, 0.5),
                                            radius: 22.5,
                                            child: Text(
                                              conversationList![index]
                                                  .alphabeticUserImage!,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.0,
                                              ),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundColor:
                                                const Color.fromRGBO(
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
                                        ? badges.Badge(
                                            badgeColor: const Color.fromRGBO(
                                                138, 165, 255, 1),
                                            badgeContent: Text(
                                              // '3'
                                              searchresult[index]
                                                  .unreadCount
                                                  .toString(),
                                            ),
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
                            : Consumer<InboxListProvider>(
                                builder: (context, inboxData, child) {
                                  return ListView.builder(
                                    /// here we are counting length of list of conversation
                                    // itemCount: conversationList!.length,
                                    itemCount: inboxData.myList.length,
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
                                          arguments: inboxData.myList![index],
                                        ),
                                        child: ListTile(
                                          leading: SizedBox(
                                            // width: 45.0,
                                            // height: 45.0,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              // fit: StackFit.expand,
                                              children: [
                                                // backgroundImage:
                                                //     // NetworkImage(
                                                //     CachedNetworkImageProvider(
                                                //   '$uri${conversationList![index].userimage!}',
                                                //   // 'https://profiles.ucr.edu/app/images/default-profile.jpg',
                                                // ),
                                                // child: FadeInImage(
                                                //   placeholder: const AssetImage(
                                                //       'assets/images/default-dp.jpg'),
                                                //   image:
                                                //       // NetworkImage(
                                                //       CachedNetworkImageProvider(
                                                //     '$uri${conversationList![index].userimage!}',
                                                //   ),
                                                //   fit: BoxFit.cover,
                                                // ),
                                                // CircleAvatar(
                                                //         backgroundColor:
                                                //             const Color.fromRGBO(
                                                //                 142, 142, 142, 0.5),
                                                //         radius: 22.5,
                                                //         child: Text(
                                                //           conversationList![index]
                                                //               .alphabeticUserImage!,
                                                //           style: const TextStyle(
                                                //             color: Colors.black,
                                                //             fontWeight:
                                                //                 FontWeight.bold,
                                                //             fontSize: 22.0,
                                                //           ),
                                                //         ),
                                                //       )
                                                ClipOval(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            142, 142, 142, 0.5),
                                                    radius: 22.5,
                                                    child: inboxData
                                                            .myList![index]
                                                            .userimage!
                                                            .isEmpty
                                                        ? Text(
                                                            inboxData
                                                                .myList![index]
                                                                .alphabeticUserImage!,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 22.0,
                                                            ),
                                                          )
                                                        : CachedNetworkImage(
                                                            imageUrl:
                                                                '$uri${inboxData.myList![index].userimage!}',
                                                            placeholder: (context,
                                                                    url) =>
                                                                const SizedBox(
                                                                    height:
                                                                        20.0,
                                                                    width: 20.0,
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ),
                                                  ),
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
                                                    fillColor: inboxData
                                                            .myList![index]
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
                                            inboxData.myList![index].username!,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            // 'update me regarding app update me regarding app update me regarding ap p update me regarding app update me regarding app update me regarding app',
                                            inboxData
                                                .myList![index].lastMessage!,
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
                                                inboxData.myList![index]
                                                    .lastMessageDateTime!
                                                    .split(' ')
                                                    .last,
                                              ),
                                              inboxData.myList[index]
                                                          .unreadCount! >=
                                                      1
                                                  ? badges.Badge(
                                                      badgeColor:
                                                          const Color.fromRGBO(
                                                              138, 165, 255, 1),
                                                      badgeContent: Text(
                                                        // '3'
                                                        inboxData.myList[index]
                                                            .unreadCount
                                                            .toString(),
                                                      ),
                                                    )
                                                  : const SizedBox(
                                                      height: 10.0,
                                                      width: 10.0),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
