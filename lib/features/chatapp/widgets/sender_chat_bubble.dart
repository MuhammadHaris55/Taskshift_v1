import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class SenderChatBubble extends StatelessWidget {
  String message;
  String time;
  String? url;
  SenderChatBubble({
    Key? key,
    required this.message,
    required this.time,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = '';
    if (url != '') {
      var imageSplit = url!.split('src=').last.split('>').first.toString();
      image = imageSplit.split('"').elementAt(1);
      print('image ---> $image');
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.35,
            ),
            decoration: const BoxDecoration(
              color: AppColors.colorBlue,
              borderRadius: BorderRadius.only(
                topRight: Radius.zero,
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                url != ''
                    ?
                    // Container(
                    //     height: 150.0,
                    //     decoration: BoxDecoration(
                    //       image: DecorationImage(
                    //         fit: BoxFit.fill,
                    //         image: CachedNetworkImageProvider(image),
                    //       ),
                    //     ),
                    //   )
                    Column(
                        children: [
                          CachedNetworkImage(imageUrl: image),
                          const SizedBox(height: 10.0),
                        ],
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Text(
                  time.split(' ').last,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
