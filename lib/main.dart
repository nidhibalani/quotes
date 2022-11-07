import 'package:flutter/material.dart';
import 'package:quotes/screens/author.dart';
import 'package:quotes/screens/favorites.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/search.dart';

//import 'firebase_options.dart';

Future<void> main() async {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
           
           
          ),
          home: HomeScreen(),
          routes: {
           AuthorScreen.route:(ctx)=> AuthorScreen(),
           FavoritesScreen.route:(ctx)=> FavoritesScreen(),
           SearchScreen.route:(ctx) => SearchScreen()

   //       }),
          }
    );
  }
}
