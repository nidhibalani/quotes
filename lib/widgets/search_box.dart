import 'package:flutter/material.dart';
import 'package:quotes/providers/search_quotes.dart';

class SearchBox extends StatefulWidget {
  
  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
Quotes quotes= new Quotes();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextFormField(
onFieldSubmitted: ((value) { quotes.searchQuotes(value);
setState(() {
  
});
}),

decoration: InputDecoration(label: 

         Row(
          children:const  [
            SizedBox(
              width: 5,
            ),
            Icon(Icons.search),
            SizedBox(
              width: 5,
            ),
            Text("Search for quotes"),
          ],
        ),)
      ),
    );
  }
}
