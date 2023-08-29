
import 'package:flutter/material.dart';
import '../utils/binary_convert.dart';
import 'karnaugh.dart';

class KarnaughBuilder {
  late Karnaugh _karnaugh;

  KarnaughBuilder(Karnaugh karnaugh) {
    _karnaugh = karnaugh;
  }

  List<Widget> buildKarnaugh() {
    List<Widget> listWidget = List.empty(growable: true);
    if(_karnaugh.literalNumber == 6){
      listWidget.add(const Text('a'));
      listWidget.add(DataTable(columns: _createColumns(), rows: _createRows()));
      listWidget.add(const Text('b'));
      listWidget.add(DataTable(columns: _createColumns(), rows: _createRows()));
    }
    else{
      listWidget.add(DataTable(columns: _createColumns(), rows: _createRows()));
    }

    listWidget.add(
      const Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Icon(Icons.skip_previous),
          Icon(Icons.play_circle),
          Icon(Icons.pause_circle),
          Icon(Icons.stop_circle),
          Icon(Icons.skip_next)
          ],));
    return listWidget;
  }

  List<DataColumn> _createColumns() {
    List<DataColumn> columns = List.empty(growable: true);
    int lengthBinary = 0;
    String title = '';

    switch(_karnaugh.literalNumber){
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

    for(int i = 0; i < _karnaugh.columnLength; i++){
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

    switch(_karnaugh.literalNumber){
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

    for(int i = 0; i < _karnaugh.rowLength; i++){
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

      for (var j = 0; j < _karnaugh.columnLength; j++) {
        DataCell cell = DataCell(
           Text(_karnaugh.matrix[i][j].toString())
          );
        cellList.add(cell);
      }

      DataRow row = DataRow(cells: cellList);
      rows.add(row);
    }
    return rows;
  }
}