// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageToUpload extends StatefulWidget {
  const PickImageToUpload({super.key});

  @override
  State<PickImageToUpload> createState() => _PickImageToUploadState();
}

class _PickImageToUploadState extends State<PickImageToUpload> {
  bool isAvailable = false;
  File? pickedImage;
  Uint8List? webImage;
  Future<void> _pickImage() async {
    if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          isAvailable = true;
        });
      } else {
        print('no image to print');
      }
    } else {
      print('something');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            isAvailable
                ? Container(
                    height: 500,
                    width: 500,
                    child: isAvailable ? Image.memory(webImage!) : SizedBox(),
                  )
                : Container(
                    child: DottedBorder(
                      dashPattern: [9, 7],
                      borderType: BorderType.Rect,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: Colors.blue,
                            size: 50,
                          ),
                          TextButton(
                            onPressed: () {
                              _pickImage();
                            },
                            child: Text(
                              'Choose An Image',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                print('image uploaded');
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
