import 'package:flutter/cupertino.dart';
import 'package:swani/widgets/Cl.dart';

import '../views/HomePage.dart';
import '../views/mydteail.dart';
import '../widgets/EventCol.dart';
import '../widgets/basic.dart';
import '../widgets/complexEven.dart';

Map<String, WidgetBuilder> getrouteAppliaction() {
  return <String, WidgetBuilder>{
    "/": (context) => HomePage(),
    "s": (context) => TableBasicsExample(),
    "ev": (_) => TableEventsExample(),
    "com": (_) => TableComplexExample(),
    "det": ((context) => MyDetailPage())
  };
}
