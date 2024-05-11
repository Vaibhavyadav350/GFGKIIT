import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutGFG extends StatelessWidget {
  const AboutGFG({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: WebView(
            initialUrl: 'https://gfgkiit.netlify.app/',
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
      ),
    );
  }
}