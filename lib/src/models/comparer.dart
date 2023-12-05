import 'package:boolean_app/src/models/table_group.dart';
import 'package:boolean_app/src/utils/counter_ones.dart';

class Comparer {
  static TableGroup compare(TableGroup tableGroup){

    int iteratorPrev = tableGroup.quineMcCluskeyTable.keys.first;
    int iteratorCurrent = iteratorPrev + 1;
    Map<String, String> mapTemp = new Map();

    while(iteratorCurrent <= tableGroup.quineMcCluskeyTable.length){
      var prev = tableGroup.quineMcCluskeyTable[iteratorPrev];
      var current = tableGroup.quineMcCluskeyTable[iteratorCurrent];

      for(var i = 0; i < prev!.length; i++){
        var valPrev = prev[i];
        for(var j = 0; j < current!.length; j++){
          var valCurrent = current[j];
          var strPrev = valPrev.values.first;
          var strCurr = valCurrent.values.first;
          if(_hasOnlyOneChange(strPrev, strCurr)){
            var keyPrev = valPrev.keys.first;
            var keyCurr = valCurrent.keys.first;
            var keyCombined = _getCombinedKey(keyPrev, keyCurr);
            var strResult = _getCombinedBinary(strPrev, strCurr);

            if(!mapTemp.containsKey(keyCombined)){
              mapTemp[keyCombined] = strResult;
            }
          }
        }
      }
      iteratorPrev = iteratorPrev + 1;
      iteratorCurrent = iteratorCurrent + 1;
    }

    return _groupFromTable(mapTemp);
  }

  static bool _hasOnlyOneChange(String prev,  String current) {
    int cont = 0;
    for(int i = 0; i < prev.length; i++){
      if(prev[i] != current[i]){
        cont++;
      }
    }
    if(cont == 1){
      return true;
    }

    return false;
  }

  static String _getCombinedBinary(String prev,  String current){
     String result = "";

    for(int i = 0; i < prev.length; i++){
      if(prev[i] == current[i]){
        result += prev[i];
      }
      else{
        result += "-";
      }
    }

    return result;
  }
  
  static String _getCombinedKey(String keyPrev, String keyCurr) {
    List<int> list = List.empty(growable: true);
    List<String> firstKeyList = keyPrev.split(',');
    List<String> secondKeyList = keyCurr.split(',');

    if(firstKeyList.length == secondKeyList.length){
      for(int i = 0; i < firstKeyList.length; i++){
        int value1 = int.parse(firstKeyList[i]);
        int value2 = int.parse(secondKeyList[i]);
        list.add(value1);
        list.add(value2);
      }
    }
    else{
      for(int i = 0; i < firstKeyList.length; i++){
        int value1 = int.parse(firstKeyList[i]);
        list.add(value1);
      }
      for(int i = 0; i < secondKeyList.length; i++){
         int value2 = int.parse(secondKeyList[i]);
         list.add(value2);
      }
    }

    list.sort();

    return list.join(',');
  }
  
  static TableGroup _groupFromTable(Map<String, String> table) {
    TableGroup tableGroup = TableGroup();

    Map<int, List<Map<String, String>>> quineMcCluskeyTable = Map();
    table.forEach((key, value) {
       int onesAmount = CounterOnes.countOnesOnString(value);

      Map<String, String> internMap = {key: value};

       // Verificar si ya existe una lista para esa cantidad de unos
      if (quineMcCluskeyTable.containsKey(onesAmount)) {
        quineMcCluskeyTable[onesAmount]!.add(internMap);
      } else {
        // Si no existe, crear una nueva lista y agregar el mapa interno
        quineMcCluskeyTable[onesAmount] = [internMap];
      }
    });

    tableGroup.setQuineMcCluskeyTable(quineMcCluskeyTable);

    return tableGroup;
  }
}