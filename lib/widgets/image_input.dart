import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {

    final pickedImage = await _pickImage();

    if (pickedImage == null) {
      return;
    }
    final imageFile = File(pickedImage.path);
    setState(() {
      _storedImage = imageFile;
    });

    final savedImage = await _saveImage(imageFile);
    widget.onSelectImage(savedImage);
  }

  Future<XFile?> _pickImage () async {
    final imagePicker = ImagePicker();
    return imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
  }

  Future<File> _saveImage(File image) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    return image.copy('${appDir.path}/$fileName');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
            onPressed: _takePicture,
          ),
        ),
      ],
    );
  }
}
