import 'dart:math';

import 'package:boolean_app/src/utils/binary_convert.dart';
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
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Text(widget.args.toString()),
          _createKarnaugh(widget.args)
        ]
      ),
    );
  }
  
  DataTable _createKarnaugh(List<String> args) {
    int size = int.tryParse(args.first) ?? 0;
    List<int?> valueList = args.skip(1).map((e) => int.tryParse(e)).toList();

    return DataTable(
      columns: _createColumns(size), 
      rows: _createRows(size)
    );
  }

  List<DataColumn> _createColumns(int size) {
    List<DataColumn> columns = List.empty(growable: true);
    int lengthBinary = 0;
    num lengthColumn = 0;
    String title = '';
    switch(size){
      case 2:
        title = 'a\\b';
        lengthBinary = 1;
      break;
      case 3:
        title = 'a\\bc';
        lengthBinary = 2;
      break;
      case 4:
        title = 'ab\\cd';
        lengthBinary = 2;
      break;
      case 5:
        title = 'ab\\cde';
        lengthBinary = 3;
      break;
      case 6:
        title = 'cd\\ef';
        lengthBinary = 2;
      break;
    }
    columns.add(DataColumn(
          label: Expanded(
            child: Text(
              title,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ));

    lengthColumn = pow(2, lengthBinary);
    for(int i = 0; i < lengthColumn; i++){
      var binaryNumber = '';
      switch(i)
      {
        case 0:
        case 1:
          binaryNumber = BinaryConvert.decimalToBinary(i, lengthBinary);
        break;
        case 2:
          binaryNumber = BinaryConvert.decimalToBinary(3, lengthBinary);
        break;
        case 3:
          binaryNumber = BinaryConvert.decimalToBinary(2, lengthBinary);
        break;
        case 4:
          binaryNumber = BinaryConvert.decimalToBinary(6, lengthBinary);
        break;
        case 5:
          binaryNumber = BinaryConvert.decimalToBinary(7, lengthBinary);
        break;
        case 6:
          binaryNumber = BinaryConvert.decimalToBinary(5, lengthBinary);
        break;
         case 7:
          binaryNumber = BinaryConvert.decimalToBinary(4, lengthBinary);
        break;
      }
      
      columns.add(DataColumn(
          label: Expanded(
            child: Text(
              binaryNumber,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ));
    }

    return columns;
  }
  
  List<DataRow> _createRows(int size) {
    List<DataRow> rows = List.empty(growable: true);
    int lengthBinary = 0;
    num lengthRow = 0;
    num lengthColumn = 0;
    switch(size){
      case 2:
        lengthBinary = 1;
        lengthColumn = pow(2, 1);
      break;
      case 3:
        lengthBinary = 1;
        lengthColumn = pow(2, 2);
      break;
      case 4:
      case 6:
        lengthBinary = 2;
        lengthColumn = pow(2, 2);
      break;
      case 5:
        lengthBinary = 2;
        lengthColumn = pow(2, 3);
      break;
    }
    lengthRow = pow(2, lengthBinary);

    for(int i = 0; i < lengthRow; i++){
      var binaryNumber = '';
      switch(i)
      {
        case 0:
        case 1:
          binaryNumber = BinaryConvert.decimalToBinary(i, lengthBinary);
        break;
        case 2:
          binaryNumber = BinaryConvert.decimalToBinary(3, lengthBinary);
        break;
        case 3:
          binaryNumber = BinaryConvert.decimalToBinary(2, lengthBinary);
        break;
      }

      List<DataCell> cellList = List.empty(growable: true);
      cellList.add(DataCell(Text(binaryNumber, style: const TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold))));

      for (var j = 0; j < lengthColumn; j++) {
        DataCell cell = const DataCell(
           Text('0')
          );
        cellList.add(cell);
      }

      DataRow row = DataRow(cells: cellList);
      rows.add(row);
    }
    return rows;
  }
}