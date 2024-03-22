import 'package:flutter/material.dart';
import '../components/widget/domain_builder.dart';

class AppDevelopmentPage extends StatefulWidget {
  @override
  State<AppDevelopmentPage> createState() => _AppDevelopmentPageState();
}

class _AppDevelopmentPageState extends State<AppDevelopmentPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold('App Development Team','team_members','projects','App');
  }
}
