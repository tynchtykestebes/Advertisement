import 'package:advertisement/components/custom_text_field.dart';
import 'package:advertisement/constants/app_size.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

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
            CustomTextField(
              prefixIcon: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.photo_camera),
                ),
              ),
              maxLines: 5,
              controller: _description,
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
