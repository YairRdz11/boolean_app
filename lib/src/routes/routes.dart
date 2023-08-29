import 'package:flutter/widgets.dart';

import 'package:boolean_app/src/pages/home_page.dart';
import 'package:boolean_app/src/pages/tableform_page.dart';

Map<String, WidgetBuilder> getApplicationBuilder() {
  return <String, WidgetBuilder> {
        '/' : (BuildContext context ) => HomePage(),
        'table-form' : (BuildContext context ) => TableFormPage(),
        //'table': (BuildContext context) => TablePage()
  };
}