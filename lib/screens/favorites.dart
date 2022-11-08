import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quotes/models/quote.dart';
import 'package:quotes/providers/search_quotes.dart';

class FavoritesScreen extends StatefulWidget {
  static const route = '/favoritesScreen';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Quotes quotes = Quotes();

  List<Quote> _favQuotes = [];

  getFavouriteQuotes() async {
    await quotes.getFavQuotes();
    _favQuotes = quotes.favQuotes;
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        appBar: AppBar(title: Text("Favourite Quotes")),
        body: FutureBuilder(
          future: getFavouriteQuotes(),
          builder: (context, snapshot) => ListView.builder(
              itemExtent: 70,
              itemCount: _favQuotes.length,
              itemBuilder: ((context, index) => Container(
                      child: Card(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Container(
                                child: Text(
                                  _favQuotes[index].quote,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: (() { quotes.deleteFavorite(
                                    _favQuotes[index].id, _favQuotes[index].quote);
                                    setState(() {
                                      
                                    });
                                    }),
                                icon: Icon(Icons.delete))
                          ],
                        ))),
                  )))),
        ));
  }
}
