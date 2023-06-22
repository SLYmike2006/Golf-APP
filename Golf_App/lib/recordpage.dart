import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tests/resultpage.dart';
import 'package:image_picker/image_picker.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key, required this.title});
  final String title;

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  File? video1;
  File? video2;

  final imagePicker = ImagePicker();

  Future getVideo1(
    ImageSource img,
  ) async {
    final pickedFile = await imagePicker.pickVideo(
        source: img,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10));
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          video1 = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future getVideo2(
    ImageSource img,
  ) async {
    final pickedFile = await imagePicker.pickVideo(
        source: img,
        preferredCameraDevice: CameraDevice.front,
        maxDuration: const Duration(minutes: 10));
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          video2 = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  void nextpage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ResultPage(
                title: "Analysis Of Your Swing",
                video1: video1!.path,
                video2: video2!.path)));
  }

  Widget confirmVideo1(File? video1) {
    if (video1 == null) return const Icon(Icons.error);
    return const Icon(Icons.check);
  }

  Widget confirmVideo2(File? video2) {
    if (video2 == null) return const Icon(Icons.error);
    return const Icon(Icons.check);
  }

  Widget selectVideo1(File? video1) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 120.0,
          width: 150.0,
          child: ElevatedButton(
              onPressed: () {
                getVideo1(ImageSource.camera);
              },
              child: Text("RECORD")),
        ),
        SizedBox(height: 40),
        SizedBox(
          height: 120.0,
          width: 150.0,
          child: ElevatedButton(
              onPressed: () {
                getVideo1(ImageSource.gallery);
              },
              child:
                  Text("Get video from library", textAlign: TextAlign.center)),
        ),
        confirmVideo1(video1),
      ],
    );
  }

  Widget selectVideo2(File? video2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 120.0,
          width: 150.0,
          child: ElevatedButton(
              onPressed: () {
                getVideo2(ImageSource.camera);
              },
              child: Text("RECORD")),
        ),
        SizedBox(height: 40),
        SizedBox(
          height: 120.0,
          width: 150.0,
          child: ElevatedButton(
              onPressed: () {
                getVideo2(ImageSource.gallery);
              },
              child:
                  Text("Get video from library", textAlign: TextAlign.center)),
        ),
        confirmVideo2(video2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                selectVideo1(video1),
                selectVideo2(video2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                  width: 200.0,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text("Use Default Second Swing"),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              SizedBox(
                height: 40.0,
                width: 250.0,
                child: ElevatedButton(
                    onPressed: nextpage,
                    child: Text("Analyze Video", textAlign: TextAlign.center)),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
