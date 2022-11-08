import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class ReceiverChatBubble extends StatelessWidget {
  String image;
  String message;
  String time;
  String? url;
  ReceiverChatBubble({
    Key? key,
    required this.image,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromRGBO(142, 142, 142, 0.5),
          backgroundImage: CachedNetworkImageProvider(
            '$uri$image',
          ),
          // AssetImage(
          //   // "assets/images/clientimage.png",
          //   image,
          // ),
          radius: 15,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.4,
            ),
            decoration: const BoxDecoration(
              color: AppColors.colorGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                url != ''
                    ? Column(
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
