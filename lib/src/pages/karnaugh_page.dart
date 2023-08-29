import 'dart:math';
import 'package:boolean_app/src/models/karnaugh.dart';
import 'package:boolean_app/src/models/karnaughBuilder.dart';
import 'package:flutter/material.dart';

class KarnaughPage extends StatefulWidget {
  final List<String> args;
  const KarnaughPage({super.key,required this.args});

  @override
  State<KarnaughPage> createState() => _KarnaughPageState();
}

class _KarnaughPageState extends State<KarnaughPage> {
  late Karnaugh _karnaugh;
  late KarnaughBuilder _karnaughBuilder;
  
  @override
  void initState() {
    int literalNumber = int.parse(widget.args[0]);
    var valueList = widget.args.skip(1).map((e) => int.tryParse(e)).toList();
    var length = pow(2, literalNumber);
    List<int> listTemp = List.empty(growable: true);

    for(int i = 0; i < length; i++){
      listTemp.add(i);
    }
    _karnaugh = Karnaugh(literalNumber.toString(), listTemp);
    _karnaughBuilder = KarnaughBuilder(_karnaugh);

    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Karnaugh')),
      body: _karnaughBuilder.createKarnaugh()
    );
  }
}