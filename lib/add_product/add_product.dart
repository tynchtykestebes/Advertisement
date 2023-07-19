import 'dart:io';
import 'package:advertisement/components/custom_text_field.dart';
import 'package:advertisement/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

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
      _selectedImages =
          pickedImages.map((pickedImage) => File(pickedImage.path)).toList();
    });
  }

  Future<void> _uploadDataAndImages() async {
    final title = _title.text;
    final description = _description.text;
    final name = _name.text;
    final dateTime = _dateTime.text;
    final phoneNumber = _phoneNumber.text;
    final address = _address.text;

    // Upload images to Firebase Storage
    final List<String> imageUrls = [];
    for (final imageFile in _selectedImages) {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(imageUrl);
    }

    // Save data and image URLs to Firestore
    await FirebaseFirestore.instance.collection('products').add({
      'title': title,
      'description': description,
      'name': name,
      'dateTime': dateTime,
      'phoneNumber': phoneNumber,
      'address': address,
      'imageUrls': imageUrls,
    });

    // Clear input fields and selected images
    _title.clear();
    _description.clear();
    _name.clear();
    _dateTime.clear();
    _phoneNumber.clear();
    _address.clear();
    setState(() {
      _selectedImages.clear();
    });

    
    Navigator.pop(context);
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
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(_selectedImages[index]),
                    );
                  },
                ),
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
            AppSize.height10,
            ElevatedButton.icon(
              onPressed: _uploadDataAndImages,
              icon: const Icon(Icons.upload_outlined),
              label: const Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
