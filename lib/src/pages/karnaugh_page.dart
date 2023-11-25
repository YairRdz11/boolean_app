import 'dart:math';
import 'package:boolean_app/src/models/karnaugh.dart';
import 'package:boolean_app/src/models/karnaughBuilder.dart';
import 'package:boolean_app/src/models/miniterms.dart';
import 'package:boolean_app/src/models/quine_mccluskey.dart';
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
  late Miniterms _miniterms;
  
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
    _miniterms = Miniterms(valueList, literalNumber);
    var qmc = QuineMcCluskey();
    var table = qmc.reduce(_miniterms);

    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Karnaugh')),
      body:  ListView(
      padding: const EdgeInsets.all(8),
        children: _karnaughBuilder.buildKarnaugh(),
      )
    );
  }
}