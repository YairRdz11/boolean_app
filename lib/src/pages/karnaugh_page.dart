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
  int _literalNumber = 0;
  List<int?> _valueList = List.empty(growable: true);
  List<List<int>> _matrix = List.generate(1, (_) => List.filled(1, 0), growable: true);
   int _rowLength = 0;
    int _columnLength = 0;
  
  @override
  void initState() {
    _literalNumber = int.parse(widget.args[0]);
    _valueList = widget.args.skip(1).map((e) => int.tryParse(e)).toList();
    var length = pow(2, _literalNumber);
    List<int> listTemp = List.empty(growable: true);

    for(int i = 0; i < length; i++){
      listTemp.add(i);
    }

    switch(_literalNumber){
      case 2:
        _rowLength = 2;
        _columnLength = 2;
      break;
      case 3:
        _rowLength = 2;
        _columnLength = 4;
      break;
      case 4:
        _rowLength = 4;
        _columnLength = 4;
      break;
      case 5:
        _rowLength = 4;
        _columnLength = 8;
      break;
      case 6:
        _rowLength = 4;
        _columnLength = 4;
      break;
    }

    _matrix = List.generate(_rowLength, (_) => List.filled(_columnLength, 0));

    int iterator = 0;
    for(int i = 0; i < _rowLength; i++){
      for(int j = 0; j < _columnLength; j++){
        _matrix[i][j] = listTemp[iterator];
        iterator++;
      }
    }

   switch(_literalNumber){
      case 3:
        rotateColumn(_matrix, 2, 3);
      break;
      case 4:
      case 6:
        rotateColumn(_matrix, 2, 3);
        rotateRow(_matrix, 2, 3);
      break;
      case 5:
        rotateColumn(_matrix, 2, 3);
        rotateColumn(_matrix, 4, 7);
        rotateColumn(_matrix, 4, 5);
        rotateColumn(_matrix, 4, 6);
        rotateRow(_matrix, 2, 3);
      break;
    }
    super.initState();
  }

  void rotateRow(List<List<int>> matrix, int row1, int row2) {

    for(int i = 0; i < matrix[0].length; i++){
      int temp = matrix[row1][i];
      matrix[row1][i] = matrix[row2][i];
      matrix[row2][i] = temp;
    }
  }

  void rotateColumn(List<List<int>> matrix, int column1, int column2){
    
    for (int i = 0; i < matrix.length; i++) {
      int temp = matrix[i][column1];
      matrix[i][column1] = matrix[i][column2];
      matrix[i][column2] = temp;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Karnaugh')),
      body: _createKarnaugh()
    );
  }
  
  ListView _createKarnaugh() {

    return ListView(
      padding: const EdgeInsets.all(8),
        children: _buildKarnaugh()
    );
  }

  List<Widget> _buildKarnaugh() {
    List<Widget> listWidget = List.empty(growable: true);
    if(_literalNumber == 6){
      listWidget.add(const Text('a'));
      listWidget.add(DataTable(columns: _createColumns(), rows: _createRows()));
      listWidget.add(const Text('b'));
      listWidget.add(DataTable(columns: _createColumns(), rows: _createRows()));
      return listWidget;
    }
    else{
      listWidget.add(Text(widget.args.toString()));
      listWidget.add(DataTable(columns: _createColumns(), rows: _createRows()));
      return listWidget;
    }
  }

  List<DataColumn> _createColumns() {
    List<DataColumn> columns = List.empty(growable: true);
    int lengthBinary = 0;
    String title = '';

    switch(_literalNumber){
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

    for(int i = 0; i < _columnLength; i++){
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
  
  List<DataRow> _createRows() {
    List<DataRow> rows = List.empty(growable: true);
    int lengthBinary = 0;

    switch(_literalNumber){
      case 2:
        lengthBinary = 1;
      break;
      case 3:
        lengthBinary = 1;
      break;
      case 4:
      case 6:
        lengthBinary = 2;
      break;
      case 5:
        lengthBinary = 2;
      break;
    }

    for(int i = 0; i < _rowLength; i++){
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

      for (var j = 0; j < _columnLength; j++) {
        DataCell cell = DataCell(
           Text(_matrix[i][j].toString())
          );
        cellList.add(cell);
      }

      DataRow row = DataRow(cells: cellList);
      rows.add(row);
    }
    return rows;
  }
}