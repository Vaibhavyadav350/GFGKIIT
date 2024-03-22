import 'package:flutter/material.dart';
import '../components/widget/domain_builder.dart';

class CoreDevPage extends StatefulWidget {
  @override
  State<CoreDevPage> createState() => _CoreDevPageState();
}

class _CoreDevPageState extends State<CoreDevPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold('Core Development Team','team_members','projects','CoreDev');
  }
}
