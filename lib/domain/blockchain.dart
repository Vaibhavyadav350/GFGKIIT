import 'package:flutter/material.dart';
import '../components/widget/domain_builder.dart';

class BlockchainPage extends StatefulWidget {
  @override
  State<BlockchainPage> createState() => _BlockchainPageState();
}

class _BlockchainPageState extends State<BlockchainPage> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold('Blockchain Team','team_members','projects','Blockchain');
  }
}
