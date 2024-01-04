import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mask_detect/Image_compressor.dart';
import 'package:mask_detect/Page1.dart';
import 'package:mask_detect/Sell_Page.dart';
// import 'package:tflite/tflite.dart';

void main() {
  runApp(MyApp1());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Sell_Page(),
    );
  }
}

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool loading = true;
//   File? file;
//   var output;
//   var label;
//   var fine;
//   ImagePicker image = ImagePicker();
//   var gfg = {
//     'with_mask': 'no_fine',
//     'without_mask': 'Fine_100_dollar',
//   };

//   @override
//   void initState() {
//     super.initState();
//     loadmodel().then((value) {
//       setState(() {});
//     });
//   }

//   detectimage(File l) async {
//     var prediction = await Tflite.runModelOnImage(
//       path: l.path,
//       numResults: 2,
//       threshold: 0.6,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );

//     setState(() {
//       output = prediction;
//       label = (output![0]['label']).toString().substring(2);
//       fine = gfg[label];
//       loading = false;
//     });
//   }

//   loadmodel() async {
//     await Tflite.loadModel(
//       model: "assets/model_unquant.tflite",
//       labels: "assets/labels.txt",
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   getImageFromCamera() async {
//     var img = await image.pickImage(source: ImageSource.camera);

//     setState(() {
//       file = File(img!.path);
//     });
//     detectimage(file!);
//   }

//   getImageFromGallery() async {
//     var img = await image.pickImage(source: ImageSource.gallery);

//     setState(() {
//       file = File(img!.path);
//     });
//     detectimage(file!);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         height: h,
//         width: w,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Mask Detection App',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//             ),
//             SizedBox(height: 20),
//             loading == true
//                 ? Container()
//                 : Container(
//                     color: Colors.red,
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 220,
//                           padding: EdgeInsets.all(15),
//                           child: Image.file(file!),
//                         ),
//                         Text(
//                           (output![0]['label']).toString().substring(2),
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           'Confidence: ' +
//                               (output![0]['confidence']).toString(),
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                         Text(
//                           fine,
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//             SizedBox(height: 100),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 FloatingActionButton(
//                   elevation: 0.0,
//                   child: Icon(
//                     Icons.image,
//                   ),
//                   backgroundColor: Color.fromARGB(255, 187, 188, 204),
//                   onPressed: getImageFromGallery,
//                 ),
//                 SizedBox(width: 20),
//                 FloatingActionButton(
//                   elevation: 0.0,
//                   child: Icon(
//                     Icons.camera,
//                   ),
//                   backgroundColor: Color.fromARGB(255, 187, 188, 204),
//                   onPressed: getImageFromCamera,
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),
//             Text(
//               'Created By Ritesh Shandilya',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
