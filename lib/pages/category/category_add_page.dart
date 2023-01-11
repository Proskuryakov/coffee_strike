import 'dart:io';

import 'package:coffee_strike/controllers/category_controller.dart';
import 'package:coffee_strike/models/result.dart';
import 'package:coffee_strike/pages/common/button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CategoryAddPage extends StatefulWidget {

  @override
  _CategoryAddPageState createState() => _CategoryAddPageState();
}

class _CategoryAddPageState extends StateMVC {

  File? _imageFile;

  late CategoryController _controller;

  _CategoryAddPageState() : super(CategoryController()) {
    _controller = controller as CategoryController;
  }

  final TextEditingController nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создать категорию"),
        centerTitle: true,
        backgroundColor: Colors.black12,
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding (
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Название"
                ),
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Необходимо название";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Material(
                child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      _getFromGallery();
                    },
                    child: Button("ВЫБРАТЬ КАРТИНКУ")
                ),
              ),
              SizedBox(height: 5),
              _getImageContainer(),
              SizedBox(height: 20),
              Material(
                child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () {
                      _savePressed();
                    },
                    child: Button("СОХРАНИТЬ")
                ),
              ),
              _getProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImageContainer() {
    if (_imageFile != null) {
      return Container(
        height: 300,
        width: 300,
        child: Image.file(
          _imageFile!,
          fit: BoxFit.cover,
        )
      );
    }
    return SizedBox(height: 0);
  }

  Widget _getProgressIndicator() {
    final state = _controller.currentState;
    if (state is ResultLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(color: Colors.black),
        )
      );
    }
    return SizedBox(height: 0);
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50
    );
    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }

  }

  _savePressed() {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      _controller.createCategory(_imageFile!, nameController.text, (result) {
        if (result is ResultSuccess) {
          Navigator.pop(context, result);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Произошла ошибка при создании категории"))
          );
        }
      });
    }
  }

}