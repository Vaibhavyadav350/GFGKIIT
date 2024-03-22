import 'package:flutter/material.dart';
import '../components/widget/domain_builder.dart';

class UiUxPage extends StatefulWidget {
  @override
  State<UiUxPage> createState() => _UiUxPageState();
}

class _UiUxPageState extends State<UiUxPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold('UI/UX Team','team_members','projects','UI/UX');
  }
}
