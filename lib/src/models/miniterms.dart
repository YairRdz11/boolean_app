import 'package:boolean_app/src/utils/binary_convert.dart';

class Miniterms {
  Map<int, String> minitermsTable = Map();

  Miniterms(List<int?> valueList, int literalNumber){
    for(int i = 0; i < valueList.length; i++){
      if(valueList[i] == 1){
        if(!minitermsTable.containsKey(i)){
          minitermsTable[i] = BinaryConvert.decimalToBinary(i, literalNumber);
        }
      }
    }
  }
}