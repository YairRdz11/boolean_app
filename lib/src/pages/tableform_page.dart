import 'package:boolean_app/src/pages/table_page.dart';
import 'package:flutter/material.dart';

class TableFormPage extends StatefulWidget {
  const TableFormPage({super.key});

  @override
  State<TableFormPage> createState() => _TableFormPageState();
}

class _TableFormPageState extends State<TableFormPage> {
  String _optionSelected = '1';
  final _variablesNumberList = ['1', '2', '3', '4', '5', '6']; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tabla')),
      body: Row(
        children: <Widget>[
          const Icon(Icons.pin_outlined),
        const SizedBox(width: 30.0,),
        DropdownButton(
          value: _optionSelected,
          items: getOptionsDropDown(),
          onChanged: (value) {
            setState(() {
            _optionSelected = value!;
            });
          },
        )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TablePage(args: _optionSelected)));
        },
        child: const Icon(Icons.arrow_forward),
        ),
    );
  }

  List<DropdownMenuItem<String>> getOptionsDropDown() {
    List<DropdownMenuItem<String>> list = List.empty(growable: true);

    _variablesNumberList.forEach((element) {
      list.add(DropdownMenuItem(child: Text(element), value: element));
    });

    return list;
  }
}