import 'package:flutter/widgets.dart';

import 'package:boolean_app/src/pages/home_page.dart';
import 'package:boolean_app/src/pages/table_page.dart';

Map<String, WidgetBuilder> getApplicationBuilder() {
  return <String, WidgetBuilder> {
        '/' : (BuildContext context ) => HomePage(),
        'table' : (BuildContext context ) => TablePage(),
  };
}