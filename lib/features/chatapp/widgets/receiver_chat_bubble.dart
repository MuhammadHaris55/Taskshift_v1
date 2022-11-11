import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:taskshift_v1/constants/utils.dart';

import '../../../constants/global_variables.dart';

class ReceiverChatBubble extends StatelessWidget {
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

  Future openFile(String imagePath, String fileName) async {
    // final file = await downloadFile(imagePath, fileName);
    final file = await downloadFile(attachmentPath!.toString(), fileName);
    if (file == null) return;

    print('Path: ${file.path}');

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String imagePath, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    try {
      final response = await Dio().get(
        imagePath,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String fileImage = '';
    if (url != '') {
      var imageSplit = url!.split('src=').last.split('>').first.toString();
      fileImage = imageSplit.split('"').elementAt(1);
      print('image ---> $fileImage');
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
                          GestureDetector(
                              onTap: () => openFile(
                                    'https://taskshift.com/storage/conversations/210/3385/H0jiLMabOvJWx2PG3gsWPGI5ipbTC4lcxfjfRqJW.pdf',
                                    message,
                                  ),
                              child: CachedNetworkImage(imageUrl: fileImage)),
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
