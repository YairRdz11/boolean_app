import 'package:flutter/material.dart';
import 'dart:math';


class TablePage extends StatefulWidget {
  final String args;

  const TablePage({super.key, required this.args});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tabla')),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          _createTable(widget.args)
        ]
      ),
      //_createTable(widget.args),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_forward),
      )
    );
  }

  DataTable _createTable(String varibleNumber) {
    int number = int.tryParse(varibleNumber) ?? 0;
    return DataTable(
      columns: _createColumns(number), 
      rows: _createRows(number)
    );
  }
  
  List<DataColumn> _createColumns(int varibleNumber) {
    List<DataColumn> columns = List.empty(growable: true);
    DataColumn columnResult =  const DataColumn(
          label: Expanded(
            child: Text(
              'f(x)',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        );
    int character = "z".codeUnitAt(0);
    for (var i = 0; i < varibleNumber; i++) {
      String currentCharacter = String.fromCharCode(character);
      DataColumn column = DataColumn(
          label: Expanded(
            child: Text(
              '$currentCharacter',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        );
      columns.add(column);
      character--;
    }
    columns = columns.reversed.toList();
    columns.add(columnResult);
    return columns;
  }
  
  List<DataRow> _createRows(int number) {
    num length = pow(2, number);
    List<DataRow> rows = List.empty(growable: true);
    for (var i = 0; i < length; i++) {
      //Number.toRadixString(2);
      List<DataCell> cellList = List.empty(growable: true);
      for (var j = 0; j < number; j++) {
        DataCell cell = DataCell(Text('0'));
        cellList.add(cell);
      }
      cellList.add(const DataCell(Text('0')));
      DataRow row = DataRow(cells: cellList);
      rows.add(row);
    }

    return rows;
  }
}