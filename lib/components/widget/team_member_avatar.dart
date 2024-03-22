import 'package:flutter/material.dart';

Widget buildTeamMemberAvatar(String imagePath, String firstname) {
  return Column(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(imagePath),
      ),
      SizedBox(height: 5), // Adding some space between avatar and name
      Text(
        firstname,
        style: TextStyle(fontSize: 12), // Adjust the font size as needed
      ),
    ],
  );
}
