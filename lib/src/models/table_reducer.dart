import 'package:boolean_app/src/models/miniterms.dart';

class TableReducer
{
  Map<int, List<Map<String, String>>> quineMcCluskeyTable = Map();

  TableReducer._(Map<int, List<Map<String, String>>> table)
  {
    quineMcCluskeyTable = table;
  }

  static TableReducer groupFromMiniterms(Miniterms miniterms){
    Map<int, List<Map<String, String>>> result = {};
    miniterms.minitermsTable.forEach((decimal, binary) {
      int onesAmount = _countOnesOnString(binary);

      Map<String, String> internMap = {decimal.toString(): binary};

       // Verificar si ya existe una lista para esa cantidad de unos
      if (result.containsKey(onesAmount)) {
        result[onesAmount]!.add(internMap);
      } else {
        // Si no existe, crear una nueva lista y agregar el mapa interno
        result[onesAmount] = [internMap];
      }
    });

    return TableReducer._(result);
  }

  compare(){
    int iteratorPrev = quineMcCluskeyTable.keys.first;
    int iteratorCurrent = iteratorPrev + 1;
    Map<String, String> mapTemp = new Map();

    while(iteratorCurrent <= quineMcCluskeyTable.length){
      var prev = quineMcCluskeyTable[iteratorPrev];
      var current = quineMcCluskeyTable[iteratorCurrent];

      for(var i = 0; i < prev!.length; i++){
        var valPrev = prev[i];
        for(var j = 0; j < current!.length; j++){
          var valCurrent = current[j];
          var strPrev = valPrev.values.first;
          var strCurr = valCurrent.values.first;
          if(_hasOnlyOneChange(strPrev, strCurr)){
            var keyPrev = valPrev.keys.first;
            var keyCurr = valCurrent.keys.first;
            var keyCombined = keyPrev + keyCurr;
            var strResult = _getCombinedBinary(strPrev, strCurr);
            var keysSorted = keyCombined.split('');
            keysSorted.sort();
            keyCombined = keysSorted.join(',');

            if(!mapTemp.containsKey(keyCombined)){
              mapTemp[keyCombined] = strResult;
            }
          }
        }
      }
      iteratorPrev = iteratorPrev + 1;
      iteratorCurrent = iteratorCurrent + 1;
    }
    print(mapTemp);
  }


  static int _countOnesOnString(String binaryNumber){
    return binaryNumber.split('').where((bit) => bit == '1').length;
  }
  
  bool _hasOnlyOneChange(String prev,  String current) {
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

  String _getCombinedBinary(String prev,  String current){
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
}