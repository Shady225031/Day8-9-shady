// ignore_for_file: prefer_const_constructors

import 'package:day8/navigation/bottomNav.dart';
import 'package:day8/navigation/tabBarNav.dart';
import 'package:day8/screens/categories.dart';
import 'package:day8/screens/home.dart';
import 'package:day8/screens/movie_screen.dart';
import 'package:day8/screens/product_details.dart';
import 'package:day8/screens/product_list.dart';
import 'package:day8/screens/settings.dart';
import 'package:day8/screens/tvshow_screen.dart'; 
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'settings': (context) => SettingPage(),
        'categories': (context) => CategoriesPage(),
        'products': (context) => ProductListPage(),
        'movies': (context) => MovieListPage(),
        'tvshows': (context) => TvShowListPage(), 
      },
    );
  }
}
