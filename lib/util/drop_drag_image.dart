import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/user/controller/user_controller.dart';

class Dropzone extends StatefulWidget {
   const Dropzone({
    super.key,
    required this.onFileUploaded,
  });
   final void Function(String downloadUrl) onFileUploaded;
  @override
  State<Dropzone> createState() => _DropzoneState();
}

class _DropzoneState extends State<Dropzone> {

  bool isHighlighted = false;
  bool isUploading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!isUploading) {
          FilePickerResult? events =
          await FilePicker.platform.pickFiles(
            allowCompression: true,
            type: FileType.custom,
            allowedExtensions: [
              "jpeg",
              "jpg",
              "png",
              "webp",
            ],
          );
          if (events == null) {
            isUploading = false;
            return;
          }
            await acceptFile(events);
        }
      },
      //This is the dotted border around the Container
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 3,
        //On error I want to show red color
        color: isError ? const Color(0xffF37A7A) : const Color(0xFFCED4DA),
        radius: const Radius.circular(10),
        dashPattern: const [8, 1],
        child: Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            //On hover I want to show light blue color
            color: isHighlighted
                ? const Color(0xFFEBF0F7)
                : isError
                ? const Color(0xffFDEBEB)
                : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isUploading
                    ? const CircularProgressIndicator()
                    : Image.asset(
                  'assets/image/cloud.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                 Text(
                  'Click or drag to this area to upload',
                  style: TextStyle(color: Colors.black),
                ),
                const Text(
                  'Formats: .jpg and .png',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  isError
                      ? 'Only images of up to 3mb and .png .jpg are allowed'
                      : 'Support for a single or bulk upload. Maximum file size 3MB.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> acceptFile(FilePickerResult event) async {
    setState(() {
      isUploading = true;
      isHighlighted = false;
      isError = false;
    });

    final name = event.files.single.name;
    Uint8List? bytes = event.files.single.bytes;
    if (bytes!.length > 3 * 1024 * 1024) {
      setState(() {
        isUploading = false;
        isError = true;
      });
      return;
    }
    final ext = name.split('.').last;
    if (ext != 'jpg' && ext != 'jpeg' && ext != 'png') {
      setState(() {
        isUploading = false;
        isError = true;
      });
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        isUploading = false;
      });
      return;
    }
    try {
      final storage = FirebaseStorage.instance;
      Get.find<UserController>();
      final ref =
      storage.ref().child('category').child(event.files.single.name);
      final uploadTask = ref.putData(bytes);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      widget.onFileUploaded(downloadUrl);
      setState(() {
        isUploading = false;
      });
    } catch (e) {
      setState(() {
        isUploading = false;
        isError = true;
      });
    }
    setState(() {});
  }
}
