import 'package:boolean_app/src/models/miniterms.dart';
import 'package:boolean_app/src/models/table_reducer.dart';

class QuineMcCluskey
{
  List<TableReducer> tables = [];

  reduce(Miniterms miniterms)
  {
    int i = 0;
    tables.add(buildInitialTable(miniterms));
    while(i == 3){
      
    }
  }

  TableReducer buildInitialTable(Miniterms miniterms) {
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

    return TableReducer(result);
  }

  int _countOnesOnString(String binaryNumber){
    return binaryNumber.split('').where((bit) => bit == '1').length;
  }

  /*void _compare(TableReducer table){
    int firstIndex = 0;
    int secondIndex = 1;
    var firstGroup = table.table[firstIndex];
    var secondGroup = table.table[secondIndex];

    while(secondIndex <= table.table.length){
      if(firstGroup != null){
        for(int i = 0; i < firstGroup.length; i++){
          var firstBinaryNumber = firstGroup[i];
          if(secondGroup != null){
            for(int j = 0; j < secondGroup.length; j++){
              var secondBinaryNumber = secondGroup[j];
              if(HasOnlyOneChange(firstBinaryNumber, secondBinaryNumber)){

              }
            }
          }
        }
      }
    }
  }*/

  bool HasOnlyOneChange(String firstBinaryNumber, String secondBinaryNumber)
  {
    int count = 0;
    for(int k = 0; k < firstBinaryNumber.length; k++){
      if(firstBinaryNumber[k] != secondBinaryNumber[k]){
        count++;
      }
    }

    return count == 1;
  }
}