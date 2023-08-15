import 'package:flutter/material.dart';

class KarnaughPage extends StatefulWidget {
  final List<String> args;
  const KarnaughPage({super.key,required this.args});

  @override
  State<KarnaughPage> createState() => _KarnaughPageState();
}

class _KarnaughPageState extends State<KarnaughPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Karnaugh')),
      body: Text(widget.args.toString()),
    );
  }
}