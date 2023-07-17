import 'dart:io';

import 'package:advertisement/components/custom_text_field.dart';
import 'package:advertisement/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _name = TextEditingController();
  final _dateTime = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _address = TextEditingController();

  List<File> _selectedImages = [];

  Future<void> _pickImagesFromGallery() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    setState(() {
      _selectedImages = pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            CustomTextField(
              controller: _title,
              hintText: 'Write the title',
            ),
            AppSize.height10,
            CustomTextField(
              maxLines: 5,
              controller: _description,
              hintText: 'Write the description',
            ),
            AppSize.height10,
            if (_selectedImages.isNotEmpty)
              Column(
                children: [
                  for (final imageFile in _selectedImages)
                    Image.file(imageFile),
                ],
              )
            else
              IconButton(
                onPressed: _pickImagesFromGallery,
                icon: const Icon(Icons.photo_camera),
              ),
            AppSize.height10,
            CustomTextField(
              controller: _name,
              hintText: 'Write your name',
            ),
            AppSize.height10,
            CustomTextField(
              controller: _dateTime,
              hintText: 'Write the date and time',
            ),
            AppSize.height10,
            CustomTextField(
              controller: _phoneNumber,
              hintText: 'Write your phone number',
            ),
            AppSize.height10,
            CustomTextField(
              controller: _address,
              hintText: 'Write your address',
            ),
          ],
        ),
      ),
    );
  }
}
