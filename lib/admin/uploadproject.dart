import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import '../components/vybutton.dart';
import '../components/vytext.dart';


class UploadProjectPage extends StatefulWidget {
  @override
  _UploadProjectPageState createState() => _UploadProjectPageState();
}

class _UploadProjectPageState extends State<UploadProjectPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _linksController = TextEditingController();
  String _selectedDomain = 'App';
  File? _imageFile;
  final picker = ImagePicker();
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
      print('User Email: $_userEmail');
    }
  }


  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_imageFile == null) return null;

    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('project_images/${_imageFile!.path.split('/').last}');
      await ref.putFile(_imageFile!);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<void> _uploadProject() async {
    final imageUrl = await _uploadImage();
    String projectName = _nameController.text.trim();
    String projectDescription = _descriptionController.text.trim();
    List<String> tags = _tagsController.text.trim().isEmpty
        ? []
        : _tagsController.text.trim().split(',');
    String? status =
    _statusController.text.trim().isEmpty ? null : _statusController.text.trim();
    List<String> links = _linksController.text.trim().isEmpty
        ? []
        : _linksController.text.trim().split(',');
    if (projectName.isEmpty || projectDescription.isEmpty) {
      MotionToast.warning(
        title: Text("Warning"),
        description: Text("projectName and projectDescription are required"),
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
    try {
      await FirebaseFirestore.instance.collection('projects').add({
        'projectName': projectName,
        'projectDescription': projectDescription,
        'imageUrl': imageUrl,
        'tags': tags,
        'status': status,
        'links': links,
        'uploaded_by': _userEmail,
        'domain': _selectedDomain,
        'uplaodTime':DateTime.now()
      });


      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Project uploaded successfully')));
      _nameController.clear();
      _descriptionController.clear();
      _tagsController.clear();
      _statusController.clear();
      _linksController.clear();
      _selectedDomain = 'App';



      setState(() {
        _imageFile = null;
      });
    } catch (error) {
      // Show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to upload project: $error')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Project Information'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VyText(_nameController, 'Project Name', Icons.title),
            VyText(_descriptionController, 'Project Description', Icons.description),
            _imageFile != null
                ? Image.file(_imageFile!)
                : Center(child: VyButton('Pick Image', Icons.image, _pickImage)),
            VyText(_tagsController, 'Tags (comma-separated)', Icons.tag),
            VyText(_statusController, 'Status', Icons.info),
            VyText(_linksController, 'Links (comma-separated)', Icons.link),
            DropdownButtonFormField<String>(
              value: _selectedDomain,
              onChanged: (newValue) {
                setState(() {
                  _selectedDomain = newValue!;
                });
              },
              items: <String>['App', 'Web'].map<DropdownMenuItem<String>>((String value) {
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
            Center(child: VyButton('Upload Project', Icons.upload, _uploadProject)),

          ],
        ),
      ),
    );
  }
}






