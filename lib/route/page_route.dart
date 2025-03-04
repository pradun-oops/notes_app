// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:notes/pages/add_note_page.dart';
import 'package:notes/pages/details_page.dart';
import 'package:notes/pages/note_page.dart';
import 'package:notes/pages/splash_screen.dart';
import 'package:notes/pages/update_note_page.dart';

class AppRoutes {
  static const String ROUTE_SPLASH = '/';
  static const String ROUTE_NOTE = '/notes_page';
  static const String ROUTE_DETAIL_PAGE = '/details_page';
  static const String ROUTE_ADD_NOTE = '/add_note';
  static const String ROUTE_UPDATE_NOTE = '/update_note';

  static Map<String, WidgetBuilder> getRoute() => {
        ROUTE_SPLASH: (context) => SplashScreen(),
        ROUTE_NOTE: (context) => NotePage(),
        ROUTE_ADD_NOTE: (context) => AddNotePage(),
        ROUTE_UPDATE_NOTE: (context) => UpdateNotePage(),
        ROUTE_DETAIL_PAGE: (context) => DetailsPage(),
      };
}
