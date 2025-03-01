import 'package:flutter/material.dart';
import 'package:notes/helper/db_helper.dart';
import 'package:notes/provider/db_provider.dart';
import 'package:notes/route/page_route.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => DbProvider(dbHelper: DbHelper.getInstance()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.ROUTE_NOTE,
      routes: AppRoutes.getRoute(),
    );
  }
}
