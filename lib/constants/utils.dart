// import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

//To download the file of the chat attachments for view on the fly
Future openFile(BuildContext context, String imagePath, String fileName) async {
  final file = await downloadFile(context, imagePath.toString(), fileName);

  if (file == null) {
    showSnackBar(context, 'Sorry, this media file appears to be missing');
    return;
  }
  // print('Path: ${file.path}');
  OpenFile.open(file.path);
}

Future<File?> downloadFile(
    BuildContext context, String imagePath, String name) async {
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
    // showSnackBar(context, e.toString());
    return null;
  }
}
//-------- END -------To download the file of the chat attachments for view on the fly


// Future<List<File>> pickImages() async {
//   List<File> images = [];
//   try {
//     var files = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: true,
//     );
//     if (files != null && files.files.isNotEmpty) {
//       for (int i = 0; i < files.files.length; i++) {
//         images.add(File(files.files[i].path!));
//       }
//     }
//   } catch (e) {
//     debugPrint(e.toString());
//   }
//   return images;
// }
// void functionalitySnackBar1(BuildContext context) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       backgroundColor: Colors.transparent,
//       behavior: SnackBarBehavior.floating,
//       elevation: 0,
//       content: Stack(
//         alignment: Alignment.center,
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             height: 70,
//             decoration: const BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.all(Radius.circular(15)),
//             ),
//             child: Row(
//               children: [
//                 const SizedBox(
//                   width: 48,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'Oops Error!',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                       Text(
//                         // text,
//                         'This Username is not found! Please try again later',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 25,
//             left: 20,
//             child: ClipRRect(
//               child: Stack(
//                 children: [
//                   Icon(
//                     Icons.circle,
//                     color: Colors.red.shade200,
//                     size: 17,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: -20,
//             left: 5,
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   height: 30,
//                   width: 30,
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(15),
//                     ),
//                   ),
//                 ),
//                 const Positioned(
//                   top: 5,
//                   child: Icon(
//                     Icons.clear_outlined,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

