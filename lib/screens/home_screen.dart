import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quotes/widgets/clipper.dart';

class HomeScreen extends StatelessWidget {
  
  List screens=["Author" , "Search" , "Favorites"];
  List onTapScreen=['/authorScreen','/searchScreen','/favoritesScreen'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ClippedContainer(),
        Container(
          height: 260,
          width: 280,
          child: GridView.builder(
           // padding: EdgeInsets.zero,
              gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(
                 // maxCrossAxisExtent: 100,
                 mainAxisExtent: 100,
                 
                  childAspectRatio: 1/2,
                  crossAxisSpacing: 30,
                  crossAxisCount: 2,
                  mainAxisSpacing: 20
                  ),
              itemCount: 3,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  elevation: 3,
                  child: InkWell(
                    onTap:()=> Navigator.of(context).pushNamed(onTapScreen[index]),
                    child: GridTile(child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(screens[index] ,textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),),
                    ))),
                  ));
              }),
        )
      ]),
    );
  }
}