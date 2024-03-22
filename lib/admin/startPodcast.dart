import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/widget/dynamicform.dart';


class PodcastPage extends StatelessWidget {
  final CollectionReference firestoreCollection =
  FirebaseFirestore.instance.collection('podcasts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Podcast Form'),
      ),
      body: DynamicForm(
        fields: {
          'Title': 'textfield',
          'Category': ['Technology', 'Music', 'Education'], // Example dropdown field
          'Image': 'imagepicker',
          // Add more fields as needed
        },
        firestoreCollection: firestoreCollection,
      ),
    );
  }
}
