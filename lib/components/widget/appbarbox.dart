import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarBox extends StatelessWidget {
  const AppBarBox({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green, // Set the color of the container to green
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50.0), // Make bottom left corner curved
          bottomRight: Radius.circular(50.0), // Make bottom right corner curved
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color with opacity
            spreadRadius: 2, // Spread radius
            blurRadius: 7, // Blur radius
            offset: Offset(0, 3), // Offset of the shadow
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0), // Add padding for text
      child: Row(
        children: [
          Text(
            heading,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Set the text color to white
            ),
          ),
        ],
      ),
    );
  }
}
