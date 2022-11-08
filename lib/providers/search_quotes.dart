import 'dart:convert';
import 'dart:developer';

import 'package:quotes/models/quote.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Quotes {
  static List<Quote> _listQuotes = [];

  static List<Quote> _favQuotes = [];

  Future<void> searchQuotes(String query) async {
    final response = await http
        .get(Uri.parse('https://api.quotable.io/search/quotes?query=$query'));
//print(response.body);
    _listQuotes = [];
    for (var data in json.decode(response.body)["results"]) {
      await getFavQuotes();
      _listQuotes.add(Quote(quote: data['content'], id: data['_id']));

      for (var j in _favQuotes) {
        for (int i = 0; i < _listQuotes.length; i++) {
          log("90");
          if (_listQuotes[i].id == j.id) _listQuotes[i].isFav = true;
        }
      }
    }
  }


  Future<void> searchAuthorQuotes(String query) async {
    final response = await http
        .get(Uri.parse('https://api.quotable.io/search/authors?query=$query'));
//print(response.body);
    _listQuotes = [];
    for (var data in json.decode(response.body)["results"]) {
      await getFavQuotes();
      _listQuotes.add(Quote(quote: data['bio'], id: data['_id']));

      for (var j in _favQuotes) {
        for (int i = 0; i < _listQuotes.length; i++) {
          log("90");
          if (_listQuotes[i].id == j.id) _listQuotes[i].isFav = true;
        }
      }
    }
  }


  List<Quote> get quotes {
    return [..._listQuotes];
  }

  void addFavorite(String id, String quote) async {
    var element =
        _listQuotes.firstWhere((k) => k.id == id, orElse: () => Quote());

    var index = _listQuotes.indexOf(element);

    element.isFav = true;

    _listQuotes[index] = element;

    _favQuotes.add(element);

    final prefs = await SharedPreferences.getInstance();
    log("0");
    final String items = prefs.getString('Favo') ?? "[{}]";
    log("1");
    log(items);
    final itemList = json.decode(items);
    itemList.add({"id": id, "quote": quote});
    log("2");

    await prefs.setString('Favo', json.encode(itemList));
    log("3");
  }

  void emptyList() {
    _listQuotes = [];
  }

  void deleteFavorite(String id, String quote) async {
    var element =
        _favQuotes.firstWhere((k) => k.id == id, orElse: () => Quote());

    var index = _favQuotes.indexOf(element);

    element.isFav = false;
    log(index.toString());
    _favQuotes[index] = element;

    _favQuotes.removeWhere((element) => element.id == id);
    log("04");

    final prefs = await SharedPreferences.getInstance();
    log("0");
    final String items = prefs.getString('Favo') ?? "[{}]";
    log("1");
    final itemList = json.decode(items);
    log("2");
    itemList.removeWhere((element) => element['id'] == id);
    await prefs.setString('Favo', json.encode(itemList));
//itemList.removeWhere((key, value) => key == "propertyName");

/* itemList.add({"id":id,"quote":quote});
log("2");
await prefs.setString('Fav', json.encode(itemList));
log("3");
 */
  }

  Future<void> getFavQuotes() async {
    _favQuotes = [];
    final prefs = await SharedPreferences.getInstance();

    final String itemList = prefs.getString('Favo') ?? "[{}]";
    List items = [];
    items = json.decode(itemList);
    items.removeAt(0);
    log("err1");
    for (var i in items) {
      log("err2");

      _favQuotes.add(Quote(id: i['id'], quote: i['quote'], isFav: true));
      log("err3");
    }
  }

  List<Quote> get favQuotes {
    return [..._favQuotes];
  }
}
