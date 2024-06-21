import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_engine/Controller/Controller.dart';

import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WebController(),
      child: MyApp(),
    ),
  );
}
