import 'package:boolean_app/src/utils/binary_convert.dart';
import "package:collection/collection.dart";

class Miniterms {
  final List<int>  _miniterms = [];
  final List<String> _minitermsString = [];
  Map<int, List<String>> _table = Map();

  Miniterms(List<int?> valueList, int literalNumber){
    for(int i = 0; i < valueList.length; i++){
      if(valueList[i] == 1){
        _miniterms.add(i);
        _minitermsString.add(BinaryConvert.decimalToBinary(i, literalNumber));
      }
    }
  }

  void buildInitialTable() {

    _table = groupBy(_minitermsString, (x) => _countOnesOnString(x));
  }

  int _countOnesOnString(String binaryNumber){
    int count = 0;

    for(int i = 0; i < binaryNumber.length; i++){
      if(binaryNumber[i] == "1") {
        count++;
      }
    }

    return count;
  }
}