import 'package:boolean_app/src/pages/data_cell_content.dart';
import 'package:boolean_app/src/pages/karnaugh_page.dart';
import 'package:boolean_app/src/utils/binary_convert.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class TablePage extends StatefulWidget {
  final String args;

  const TablePage({super.key, required this.args});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {

  List<DataRow> rowList = [];
  List<String> valueList = [];

  @override
  void dispose() {
    super.dispose();
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          valueList = [];
          valueList.add(widget.args);
          int rowLength = int.tryParse(widget.args) ?? 0;
          num length = pow(2, rowLength);
          for(var i = 0; i < length; i++){
            var inkWell = rowList[i].cells[rowLength].child as DataCellContent;
            String value = inkWell.value;
            valueList.add(value);
          }
          Navigator.push(context, MaterialPageRoute(builder: (context) => KarnaughPage(args: valueList)));
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
              currentCharacter,
              style: const TextStyle(fontStyle: FontStyle.italic),
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
    rowList = List.empty(growable: true);
    for (var i = 0; i < length; i++) {
      String binary = BinaryConvert.decimalToBinary(i, number);
      List<DataCell> cellList = List.empty(growable: true);
      for (var j = 0; j < number; j++) {
        DataCell cell = DataCell(
           Text(binary[j])
          );
        cellList.add(cell);
      }
      cellList.add(DataCell(DataCellContent(initialValue: "0")));
      DataRow row = DataRow(cells: cellList);
      rowList.add(row);
    }

    return rowList;
  }
}