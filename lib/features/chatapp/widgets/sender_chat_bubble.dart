import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';

class SenderChatBubble extends StatefulWidget {
  String message;
  String time;
  String? url;
  String? attachmentPath;
  SenderChatBubble({
    Key? key,
    required this.message,
    required this.time,
    this.url,
    this.attachmentPath,
  }) : super(key: key);

  @override
  State<SenderChatBubble> createState() => _SenderChatBubbleState();
}

class _SenderChatBubbleState extends State<SenderChatBubble> {
  bool openingImage = false;

  @override
  Widget build(BuildContext context) {
    String fileImage = '';
    if (widget.url != '') {
      var imageSplit =
          widget.url!.split('src=').last.split('>').first.toString();
      fileImage = imageSplit.split('"').elementAt(1);
      print('image ---> $fileImage');
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
                widget.url != ''
                    ? Column(
                        children: [
                          openingImage
                              ? SizedBox(
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      CachedNetworkImage(imageUrl: fileImage),
                                      const CircularProgressIndicator(),
                                    ],
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      openingImage = true;
                                    });
                                    await openFile(
                                        context,
                                        widget.attachmentPath.toString(),
                                        widget.message);
                                    setState(() {
                                      openingImage = false;
                                    });
                                  },
                                  child:
                                      CachedNetworkImage(imageUrl: fileImage),
                                ),
                          const SizedBox(height: 10.0),
                        ],
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    widget.message,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                Text(
                  widget.time.split(' ').last,
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
