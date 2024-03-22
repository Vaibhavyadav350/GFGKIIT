import 'package:flutter/material.dart';
import '../components/widget/domain_builder.dart';

class GameDevPage extends StatefulWidget {
  @override
  State<GameDevPage> createState() => _GameDevPageState();
}

class _GameDevPageState extends State<GameDevPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold('Game Development Team','team_members','projects','GameDev');
  }
}
