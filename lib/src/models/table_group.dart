import 'package:boolean_app/src/models/miniterms.dart';
import 'package:boolean_app/src/utils/counter_ones.dart';

class TableGroup
{
  Map<int, List<Map<String, String>>> quineMcCluskeyTable = Map();

  TableGroup();
  
  setQuineMcCluskeyTable(Map<int, List<Map<String, String>>> table){
    quineMcCluskeyTable = table;
  }


  createFromMiniterms(Miniterms miniterms){
    miniterms.minitermsTable.forEach((decimal, binary) {
      int onesAmount = CounterOnes.countOnesOnString(binary);

      Map<String, String> internMap = {decimal.toString(): binary};

       if (quineMcCluskeyTable.containsKey(onesAmount)) {
        quineMcCluskeyTable[onesAmount]!.add(internMap);
      } else {
        // Si no existe, crear una nueva lista y agregar el mapa interno
        quineMcCluskeyTable[onesAmount] = [internMap];
      }
    });
  }

  String resolve() {
    List<String> listResult = List.empty(growable: true);
    Map<int, int> dictionary = Map();
    Map<String, String> dictionaryResult = Map();

    quineMcCluskeyTable.forEach((key, value) {
      value.forEach((element) {
        element.forEach((key2, value2) {
          if(!dictionaryResult.containsKey(key2)){
            dictionaryResult[key2] = value2;
          }
          Iterable<int> listAux = key2.split(',').map((e) => int.parse(e));
          listAux.forEach((element2) {
            if(dictionary.containsKey(element2)){
              dictionary[element2] = dictionary[element2]! + 1;
            }
            else{
              dictionary[element2] = 1;
            }
           });
        });
      });
    });

    dictionary.forEach((key, value) {
      if(value == 1){
        for (var keyResult in dictionaryResult.keys) {
          if(keyResult.contains(key.toString())){
            listResult.add(dictionaryResult[keyResult]!);
            break;
          }
        }
      }
    });
    
    List<String> aux = List.empty(growable: true);
    listResult.forEach((element) {
      var result = "";
      for(int i = 0; i < element.length; i++){
        if(element[i] != '-'){
          var position = (element.length -1) - i;
          int character = "z".codeUnitAt(0);
          switch(element[i]){
            case '0':
              var newCharacterAscii = character - position;
              var newCharacter = String.fromCharCode(newCharacterAscii);
              newCharacter = "$newCharacter'";
              result += newCharacter;
            break;
            case '1':
              var newCharacterAscii = character - position;
              var newCharacter = String.fromCharCode(newCharacterAscii);
              result += newCharacter;
            break;
          }
        }
      }
      aux.add(result);
    });

    return aux.join('+');
  }
  
}