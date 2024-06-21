import 'package:flutter/cupertino.dart';
import 'package:search_engine/Pages/home_page/home_page.dart';

class MyRoutes {
  static String homePage = '/';
  static String webPage = 'web_page';

  static Map<String, WidgetBuilder> routes = {
    homePage: (context) => HomePage(),
  };
}
