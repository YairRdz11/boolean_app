import 'package:boolean_app/src/models/miniterms.dart';
import 'package:boolean_app/src/models/table_reducer.dart';

class QuineMcCluskey
{
  List<TableReducer> tables = [];

  reduce(Miniterms miniterms)
  {
    int i = 0;
    TableReducer initialTable = TableReducer.groupFromMiniterms(miniterms);
    initialTable.compare();
  }
}