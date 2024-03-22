import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gfg_kiit/components/widget/project_card.dart';
import 'package:gfg_kiit/components/widget/team_member_avatar.dart';

Scaffold buildScaffold(String webdev,String teamMemberCollection, String projectCollection,String domain) {
  return Scaffold(
    appBar: AppBar(
      title: Text(webdev),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Our Team',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(teamMemberCollection).where('domain', isEqualTo: domain).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              var teamMembers = snapshot.data!.docs;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: teamMembers.map((member) {
                    return buildTeamMemberAvatar(member['photo_url'], member['firstname']);
                  }).toList(),
                ),
              );
            },
          ),
          SizedBox(height: 30),
          Text(
            'Current Projects',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(projectCollection).where('domain', isEqualTo: domain).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              var projects = snapshot.data!.docs;
              return Column(
                children: projects.map((project) {
                  return buildProjectCard(
                    projectName: project['projectName'],
                    projectDescription: project['projectDescription'],
                    imageUrl: project['imageUrl'], // Include imageUrl
                    tags: List<String>.from(project['tags']), // Include tags
                    status: project['status'], // Include status
                    links: List<String>.from(project['links']), // Include links
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    ),
  );
}