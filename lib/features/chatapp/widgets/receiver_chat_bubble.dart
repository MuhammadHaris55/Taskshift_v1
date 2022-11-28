import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taskshift_v1/constants/utils.dart';

import '../../../constants/global_variables.dart';

class ReceiverChatBubble extends StatefulWidget {
  String image;
  String message;
  String time;
  String? url;
  String? attachmentPath;
  ReceiverChatBubble({
    Key? key,
    required this.image,
    required this.message,
    required this.time,
    this.url,
    this.attachmentPath,
  }) : super(key: key);

  @override
  State<ReceiverChatBubble> createState() => _ReceiverChatBubbleState();
}

class _ReceiverChatBubbleState extends State<ReceiverChatBubble> {
  bool openingImage = false;

  // Future openFile(String fileName) async {
  //   setState(() {
  //     openingImage = true;
  //   });
  //   // final file = await downloadFile(imagePath, fileName);
  //   final file = await downloadFile(
  //       context, widget.attachmentPath!.toString(), fileName);
  //   setState(() {
  //     openingImage = false;
  //   });
  //   if (file == null) {
  //     showSnackBar(context, 'Sorry, this media file appears to be missing');
  //     return;
  //   }
  //   print('Path: ${file.path}');
  //   OpenFile.open(file.path);
  // }

  @override
  Widget build(BuildContext context) {
    String fileImage = '';
    if (widget.url != '') {
      var imageSplit =
          widget.url!.split('src=').last.split('>').first.toString();
      fileImage = imageSplit.split('"').elementAt(1);
      // print('image ---> $fileImage');
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: const Color.fromRGBO(142, 142, 142, 0.5),
          backgroundImage: CachedNetworkImageProvider(
            '$uri${widget.image}',
          ),
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
                                  // onTap: () => openFile(widget.message),
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
