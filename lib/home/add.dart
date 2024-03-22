import 'package:flutter/material.dart';
import 'package:gfg_kiit/admin/hackathonupload.dart';
import 'package:gfg_kiit/admin/startPodcast.dart';
import 'package:gfg_kiit/admin/uploadmember.dart';
import 'package:gfg_kiit/admin/uploadphotos.dart';
import 'package:gfg_kiit/admin/uploadproject.dart';
import '../components/widget/appbarbox.dart';
import '../admin/addInternship.dart';
import '../admin/addresource.dart';
import '../admin/createCodeChallenge.dart';

class AddFeatures extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppBarBox(heading: "   Moderator Tools"),

          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: [
                _moderatorCard(context, 'Modify Hackathon', Icons.edit, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadHackathon()),
                  );
                }),
                _moderatorCard(context, 'Add Project', Icons.add, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadProjectPage()),
                  );
                }),
                _moderatorCard(context, 'Invite Members', Icons.person_add, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTeamMemberPage()),
                  );
                }),
                _moderatorCard(context, 'Create Code Challenge', Icons.code, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateCodeChallengePage()),
                  );
                }),
                _moderatorCard(context, 'Start Podcast', Icons.mic, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PodcastPage()),
                  );
                }),
                _moderatorCard(context, 'Post Job/Internship', Icons.work, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostJobInternshipPage()),
                  );
                }),
                _moderatorCard(context, 'Share Learning Resources', Icons.book, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ShareLearningResourcesPage()),
                  );
                }),
                _moderatorCard(context, 'Upload Photos', Icons.photo_camera, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UploadPhotosPage()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget _moderatorCard(BuildContext context, String title, IconData iconData, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
