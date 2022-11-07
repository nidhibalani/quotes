import 'dart:convert';

import 'package:quotes/models/quote.dart';
import 'package:http/http.dart' as http;

class Quotes{

static List<Quote> _listQuotes=[];

static List<Quote> _favQuotes=[];



void searchQuotes(String query) async
{
final response=await   http.get(Uri.parse('https://api.quotable.io/search/quotes?query=$query'));
//print(response.body);
_listQuotes=[];
for (var data in json.decode(response.body)["results"])
{
  print(data['content']);
 
  _listQuotes.add(
    Quote(quote: data['content'] , id: data['_id']));
    
}
}

List<Quote> get quotes
{
  return [..._listQuotes];
}

updateFavorite(String id)
{
  var element= _listQuotes.firstWhere((k)=>k.id==(id),orElse:()=>Quote());
    var index = _listQuotes.indexOf(element);
     
          element.isFav=!element.isFav;

    _listQuotes[index]=element;

}
}