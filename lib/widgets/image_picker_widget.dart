import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File)? onImageSelected;

  const ImagePickerWidget({super.key, this.onImageSelected});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  final List<File> _imageFiles = [];

  Future<void> _getImageFromGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFiles.add(File(pickedImage.path));
        widget.onImageSelected?.call(_imageFiles.last);
      });
    }
  }

  Future<void> _captureImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _imageFiles.add(File(pickedImage.path));
        widget.onImageSelected?.call(_imageFiles.last);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('صور المنتج', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        if (_imageFiles.isNotEmpty)
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int index = 0; index < _imageFiles.length; index++)
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.file(_imageFiles[index], width: 100, height: 100, fit: BoxFit.cover),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: const CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.red,
                              child: Icon(Icons.close, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.add_a_photo),
            label: Text(
              _imageFiles.isEmpty ? 'اضغط لاضافة الصور' : 'اضافة صورة اخرى',
              style: const TextStyle(fontSize: 16),
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.camera_alt),
                          title: const Text('التقط صوره'),
                          onTap: () {
                            Navigator.pop(context);
                            _captureImage();
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text('اختر من المعرض'),
                          onTap: () {
                            Navigator.pop(context);
                            _getImageFromGallery();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
