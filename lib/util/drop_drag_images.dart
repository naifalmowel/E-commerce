import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:sumer/modules/product/controller/product_controller.dart';
import 'package:sumer/util/constant.dart';

class DropzoneForImages extends StatefulWidget {
  const DropzoneForImages({
    super.key,
    required this.onFileUploaded,
    this.child,
    this.carousel,
  });
  final void Function(String downloadUrl) onFileUploaded;
  final Widget? child ;
  final bool? carousel ;
  @override
  State<DropzoneForImages> createState() => _DropzoneForImagesState();
}

class _DropzoneForImagesState extends State<DropzoneForImages> {

  bool isHighlighted = false;
  bool isUploading = false;
  bool isError = false;

  @override
  void initState() {
    super.initState();
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
          FilePickerResult? events = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            allowCompression: true,
            type: FileType.custom,
            allowedExtensions: ["jpeg", "jpg", "png", "webp"],
          );
          if (events == null) {
            isUploading = false;
            return;
          }
          setState(() {
            isUploading = true;
            Get.find<ProductController>().isUploading(true);
            isError = false;
          });
          await uploadFiles(events.files);
        }
      },
      child: widget.child ?? DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 3,
        color: isError ? const Color(0xffF37A7A) : const Color(0xFFCED4DA),
        radius: const Radius.circular(10),
        dashPattern: const [8, 1],
        child: Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            color: isHighlighted ? const Color(0xFFEBF0F7) : isError ? const Color(0xffFDEBEB) : const Color(0xFFF8F9FA),
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

  Future<void> uploadFiles(List<PlatformFile> files) async {
    try {
      List<Future<void>> uploadTasks = [];
      for (var file in files) {
        uploadTasks.add(acceptFile(file));
      }
      await Future.wait(uploadTasks);

      Get.find<ProductController>().isUploading(false);
      if (mounted) {
        setState(() {
          isUploading = false;

        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isUploading = false;
          isError = true;
          Get.find<ProductController>().isUploading(false);
          Constant.showSnakeBarError(context, 'Error occurred while uploading files.');
        });
      }
    }
  }
  Future<void> acceptFile(PlatformFile file) async {
    final name = file.name;
    Uint8List? bytes = file.bytes;
    if (bytes == null || bytes.length > 3 * 1024 * 1024) {
      if (mounted) {
        setState(() {
          isError = true;
          Constant.showSnakeBarError(context, 'File exceeds 3MB limit.');
        });
      } Get.find<ProductController>().isUploading(false);
      return;
    }

    final ext = name.split('.').last.toLowerCase();
    if (ext != 'jpg' && ext != 'jpeg' && ext != 'png') {
      if (mounted) {
        setState(() {
          isError = true;
          Constant.showSnakeBarError(context, 'Invalid file format. Only .jpg, .jpeg, and .png are allowed.');
        });
      }
      Get.find<ProductController>().isUploading(false);
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.find<ProductController>().isUploading(false);
      return;
    }

    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child((widget.carousel??false)?'carousel':'products').child(name);
      final uploadTask = ref.putData(bytes);

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      widget.onFileUploaded(downloadUrl);

    } catch (e) {
      if (mounted) {
        setState(() {
          isError = true;
          Get.find<ProductController>().isUploading(false);
          Constant.showSnakeBarError(context, 'Error uploading file: $name');
        });
      }
    }
  }
}
