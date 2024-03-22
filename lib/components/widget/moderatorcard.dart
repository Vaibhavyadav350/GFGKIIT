import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _moderatorCard(BuildContext context, String title, IconData iconData, Function() onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
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