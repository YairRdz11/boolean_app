import 'package:flutter/material.dart';

class DataCellContent extends StatefulWidget {
  final String initialValue;
  String value = "0";

  DataCellContent({super.key, required this.initialValue});

  @override
  State<DataCellContent> createState() => _DataCellContentState();
}

class _DataCellContentState extends State<DataCellContent> {
  late String _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
     return InkWell(
      child: Text(_currentValue),
      onTap: () {
        setState(() {
          switch(_currentValue){
            case "0":
              _currentValue = "1";
              widget.value = _currentValue;
              break;
            case "1":
              _currentValue = "X";
              widget.value = _currentValue;
              break;
            case "X":
              _currentValue = "0";
              widget.value = _currentValue;
              break;
          }
        }
        );
      },
    );
  }
}