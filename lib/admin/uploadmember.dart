import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motion_toast/motion_toast.dart';

import '../components/vybutton_.dart';
import '../components/vytext.dart';

class AddTeamMemberPage extends StatefulWidget {
  @override
  _AddTeamMemberPageState createState() => _AddTeamMemberPageState();
}

class _AddTeamMemberPageState extends State<AddTeamMemberPage> {
  File? _imageFile;
  final picker = ImagePicker();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _kiitemailController = TextEditingController();
  String _selectedDomain = 'App'; // Added for dropdown
  String? _userEmail; // Added to save the user's email

  @override
  void initState() {
    super.initState();
    _getUserEmail();
  }

  Future<void> _getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userEmail = user.email;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImageToFirebaseStorage() async {
    try {
      if (_imageFile == null) return null;
      String imageName = 'team_member_${DateTime.now().millisecondsSinceEpoch}.jpg';
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('team_members').child(imageName);
      firebase_storage.UploadTask uploadTask = ref.putFile(_imageFile!);
      await uploadTask.whenComplete(() => null);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }



  Future<void> _uploadTeamMember() async {
    try {
      String? imageUrl = await _uploadImageToFirebaseStorage();
      if (imageUrl == null) {
        MotionToast.error(
          title: Text("Failed"),
          description: Text("Failed to upload team member photo"),
        ).show(context);
        return;
      }
      String firstname = _firstnameController.text.trim();
      String lastname = _lastnameController.text.trim();
      String kiitemail = _kiitemailController.text.trim();
      if (firstname.isEmpty || kiitemail.isEmpty) {
        MotionToast.warning(
          title: Text("Warning"),
          description: Text("Name and kiitemail are required"),
        ).show(context);
        return;
      }
      if (_selectedDomain.isEmpty) {
        MotionToast.info(
          title: Text("Info"),
          description: Text("Please select a domain"),
        ).show(context);
        return;
      }
      await FirebaseFirestore.instance.collection('team_members').add({
        'firstname': firstname,
        'lastname': lastname,
        'email': kiitemail,
        'photo_url': imageUrl,
        'domain': _selectedDomain, // Save the selected domain
        'uploaded_by': _userEmail,
        'uploadTime': DateTime.now(), // Save the user's email
      });
      MotionToast.success(
        title: Text("Success"),
        description: Text("Team member uploaded successfully"),
      ).show(context);
    } catch (e) {
      MotionToast.error(
        title: Text("Failed"),
        description: Text("Failed to upload team member: $e"),
      ).show(context);
    }

    _firstnameController.clear();
    _lastnameController.clear();
    _kiitemailController.clear();
    _selectedDomain = 'App';

    // Reset the image file
    setState(() {
      _imageFile = null;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Team Member'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _pickImage();
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(75),
                    image: _imageFile != null
                        ? DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: _imageFile == null
                      ? Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: Colors.grey[600],
                  )
                      : null,
                ),
              ),
            ),
            SizedBox(height: 20,),
            VyText(_firstnameController, 'First Name', Icons.person),
            VyText(_lastnameController, 'Last Name', Icons.person),
            VyText(_kiitemailController, 'Email', Icons.mail),
            DropdownButtonFormField<String>(
              value: _selectedDomain,
              onChanged: (newValue) {
                setState(() {
                  _selectedDomain = newValue!;
                });
              },
              items: <String>['App', 'Web','Blockchain','AI/ML','UI/UX','CoreDev','GameDev','DevOps'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Domain',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(child: VyButton('Upload Team Member', Icons.upload, _uploadTeamMember)),
          ],
        ),
      ),
    );
  }
}
