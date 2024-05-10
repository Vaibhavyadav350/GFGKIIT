import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../components/vybutton.dart';
import '../components/vytext.dart';

class UploadHackathon extends StatefulWidget {
  @override
  State<UploadHackathon> createState() => _UploadHackathonState();
}

class _UploadHackathonState extends State<UploadHackathon> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _agendaController = TextEditingController();
  final TextEditingController _registrationTimeController = TextEditingController();
  final TextEditingController _lunchBreakTimeController = TextEditingController();
  final TextEditingController _presentationsTimeController = TextEditingController();

  String? imageUrl;
  File? _imageFile;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _fetchDataFromFirestore();
  }
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  Future<void> _fetchDataFromFirestore() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('hackathon').doc('details').get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        _titleController.text = data['title'] ?? '';
        _dateController.text = data['date'] ?? '';
        _timeController.text = data['time'] ?? '';
        _locationController.text = data['location'] ?? '';
        _descriptionController.text = data['description'] ?? '';
        _agendaController.text = data['agenda'] ?? '';
        _registrationTimeController.text = data['timeofRegistration and Welcome'] ?? '';
        _lunchBreakTimeController.text = data['timeofLunch Break'] ?? '';
        _presentationsTimeController.text = data['timeProjectPresentations andJudging'] ?? '';

        setState(() {
          imageUrl = data['image'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No data available')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch data: $error')));
    }
  }

  Future<void> _uploadDataToFirestore() async {
    try {
      if (_imageFile != null) {
        final ref = FirebaseStorage.instance.ref().child('hackathon_images/${_imageFile!.path.split('/').last}');
        await ref.putFile(_imageFile!);
        imageUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('hackathon').doc('details').set({
        'title': _titleController.text,
        'date': _dateController.text,
        'time': _timeController.text,
        'location': _locationController.text,
        'description': _descriptionController.text,
        'agenda': _agendaController.text,
        'image': imageUrl,
        'timeofRegistration and Welcome': _registrationTimeController.text,
        'timeofLunch Break': _lunchBreakTimeController.text,
        'timeProjectPresentations andJudging': _presentationsTimeController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data uploaded successfully')));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload data: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hackathon Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  VyText(
                    _titleController,
                    'Enter hackathon title',
                    Icons.title,
                  ),
                  VyText(
                    _titleController,
                    'Date',
                    Icons.date_range,
                  ),VyText(
                    _timeController,
                    'Time',
                    Icons.access_time,
                  ),VyText(
                    _descriptionController,
                    'Description',
                    Icons.info,
                  ),VyText(
                    _locationController,
                    'Agenda',
                    Icons.location_on,
                  ),

                  Center(
                    child: VyButton(
                        'Pick Image',
                        Icons.upload, _pickImage
                    ),
                  ),SizedBox(height: 10,),
                  Center(child: SizedBox(height:300,child: _imageFile != null ? Image.file(_imageFile!) : SizedBox())),

                  VyText(
                    _registrationTimeController,
                    'Registration Enter time',
                    Icons.access_time,
                  ),


                  VyText(
                    _lunchBreakTimeController,
                    'Enter time',
                    Icons.access_time,
                  ),


                  VyText(
                    _presentationsTimeController,
                    'Presentation time',
                    Icons.access_time,
                  ),



                  Center(
                    child: VyButton(
                        'Upload Data',
                        Icons.upload, _uploadDataToFirestore
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
