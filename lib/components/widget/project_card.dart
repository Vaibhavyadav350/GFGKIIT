import 'package:flutter/material.dart';

Widget buildProjectCard({
  required String projectName,
  required String projectDescription,
  String? imageUrl,
  List<String>? tags,
  String? status,
  List<String>? links,
}) {
  return Card(
    elevation: 3,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (imageUrl != null)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                projectName,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                projectDescription,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              if (tags != null && tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: tags.map((tag) => Chip(label: Text(tag))).toList(),
                ),
              if (status != null) SizedBox(height: 8),
              if (status != null)
                Text(
                  'Status: $status',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              SizedBox(height: 8),
              if (links != null && links.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: links
                      .map(
                        (link) => ElevatedButton(
                      onPressed: () {
                        // Add logic to handle link tapping
                      },
                      child: Text(link),
                    ),
                  )
                      .toList(),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}
