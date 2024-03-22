import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_toast/motion_toast.dart';

import '../components/vybutton_.dart';
import '../components/vytext.dart';

class HackathonDetailsPage extends StatefulWidget {
  @override
  State<HackathonDetailsPage> createState() => _HackathonDetailsPageState();
}

class _HackathonDetailsPageState extends State<HackathonDetailsPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  String? _userEmail;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hackathon Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('hackathon').doc('details').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(child: Text('No data available'));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data['image']), // Replace with actual placeholder image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  data['title'] ?? 'Hackathon Title',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Date: ${data['date'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Time: ${data['time'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Location: ${data['location'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  data['description'] ?? 'N/A',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Agenda:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Registration Time: ${data['timeofRegistration and Welcome'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Lunch Break Time: ${data['timeofLunch Break'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Presentations Time: ${data['timeProjectPresentations andJudging'] ?? 'N/A'}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                VyText(nameController, 'Name', Icons.person),
                SizedBox(height: 10),
                VyText(emailController, 'Email', Icons.email),
                SizedBox(height: 20),
                VyButton('Register Now', Icons.arrow_forward, () {
                  String name = nameController.text;
                  String email = emailController.text;
                  FirebaseFirestore.instance.collection('hackathon_candidates').add({
                    'hackathon_title': data['title'] ?? 'N/A',
                    'name': name,
                    'email': email,
                    'uploaded_by': _userEmail,
                    'uploadTime': DateTime.now(),
                  }).then((value) {
                    // Handle successful registration
                    MotionToast.success(
                      title: Text("Success"),
                      description: Text("Team member uploaded successfully"),
                    ).show(context);
                  }).catchError((error) {
                    // Handle registration error
                    MotionToast.error(
                      title: Text("Failed"),
                      description: Text("Failed to upload team member: $error"),
                    ).show(context);
                  });
                  nameController.clear();
                  emailController.clear();
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
