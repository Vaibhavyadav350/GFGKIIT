import 'package:flutter/material.dart';
import '../components/widget/domain_builder.dart';

class AiMlPage extends StatefulWidget {
  @override
  State<AiMlPage> createState() => _AiMlPageState();
}

class _AiMlPageState extends State<AiMlPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold('AI/ML Team','team_members','projects','AI/ML');
  }
}
