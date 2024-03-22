import 'package:flutter/material.dart';
import '../components/widget/domain_builder.dart';
class WebDevelopmentPage extends StatefulWidget {
  @override
  State<WebDevelopmentPage> createState() => _WebDevelopmentPageState();
}

class _WebDevelopmentPageState extends State<WebDevelopmentPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold('Web Development Team','team_members','projects','Web');
  }
}
