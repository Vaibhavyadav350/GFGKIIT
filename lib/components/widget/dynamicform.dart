import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gfg_kiit/home/homescreen.dart';
import 'package:image_picker/image_picker.dart';

import '../../home/home.dart';

class DynamicForm extends StatefulWidget {
  final Map<String, dynamic> fields;
  final CollectionReference firestoreCollection;

  const DynamicForm({required this.fields, required this.firestoreCollection});

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  late Map<String, dynamic> _formData;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _formData = {};
  }

  void _handleFieldChange(String key, dynamic value) {
    setState(() {
      _formData[key] = value;
    });
  }

  Future<void> _handleImagePick() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _handleSubmit() async {
    try {
      String? imageUrl;

      if (_imageFile != null) {
        // Upload image to Firebase Storage
        final Reference storageRef = FirebaseStorage.instance.ref().child('images').child('${DateTime.now()}.jpg');
        await storageRef.putFile(_imageFile!);

        // Get image URL
        imageUrl = await storageRef.getDownloadURL();
      }

      // Merge form data with image URL
      Map<String, dynamic> formDataWithImage = Map.from(_formData);
      formDataWithImage['image'] = imageUrl;
      // Add date and time of upload
      formDataWithImage['uploadDateTime'] = Timestamp.now();

      // Add user's email ID
      String? userEmail = FirebaseAuth.instance.currentUser?.email;
      formDataWithImage['userEmail'] = userEmail;
      // Save form data to Firestore
      await widget.firestoreCollection.add(formDataWithImage);

      print('Form data saved successfully');
      print('Clearing form fields and image file');
      setState(() {
        // Clear form fields and image file
        _formData.clear(); // Initialize _formData again
        _imageFile = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form data saved successfully')),
      );
      await Future.delayed(Duration(seconds: 2));

      // Navigate to the HomePage after saving the form data
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));

    } catch (error) {
      print('Failed to save form data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save form data')),
      );
    }
  }






  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.fields.keys.map<Widget>((key) {
          dynamic field = widget.fields[key];
          Widget formField;

          if (field is String && field == 'textfield') {
            formField = TextFormField(
              decoration: InputDecoration(labelText: key),
              onChanged: (value) => _handleFieldChange(key, value),
            );
          } else if (field is List<String>) {
            formField = DropdownButtonFormField<String>(
              value: null,
              onChanged: (value) => _handleFieldChange(key, value),
              items: field.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              decoration: InputDecoration(labelText: key),
            );
          } else if (field == 'imagepicker') {
            formField = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _handleImagePick,
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 10.0),
                _imageFile != null
                    ? Image.file(_imageFile!)
                    : SizedBox(),
              ],
            );
          } else {
            throw Exception('Invalid field type');
          }

          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: formField,
          );
        }).toList()..add(
          // Upload button
          ElevatedButton(
            onPressed: _handleSubmit,
            child: Text('Upload'),
          ),
        ),
      ),
    );
  }
}
