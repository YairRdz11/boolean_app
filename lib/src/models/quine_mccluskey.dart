import 'package:boolean_app/src/models/comparer.dart';
import 'package:boolean_app/src/models/miniterms.dart';
import 'package:boolean_app/src/models/table_group.dart';

class QuineMcCluskey
{
  List<TableGroup> tables = List.empty(growable: true);

  reduce(Miniterms miniterms)
  {
    TableGroup table = TableGroup();

    table.createFromMiniterms(miniterms);

    while(table.quineMcCluskeyTable.isNotEmpty){
      table = Comparer.compare(table);
      if(table.quineMcCluskeyTable.isNotEmpty){
        tables.add(table);
      }
    }
    String result = tables.last.resolve();
    print(result);
  }
}