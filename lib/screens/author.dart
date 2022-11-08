import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quotes/models/quote.dart';
import 'package:quotes/providers/search_quotes.dart';
import 'package:quotes/widgets/search_box.dart';

class AuthorScreen extends StatefulWidget {
  static const route = '/authorScreen';

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  Quotes quotes = Quotes();

  var items = [
    'Show 10 results',
    'Show 100 results',
  ];

  String dropdownvalue = 'Show 10 results';

@override
  void initState() {
    quotes.emptyList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          SizedBox(
            height: 30,
          ),
          searchBox(),
          filter(),
          Container(
            height: MediaQuery.of(context).size.height - 140,
            child: ListView.builder(
                itemCount: quotes.quotes.length >= 10
                    ? dropdownvalue == "Show 10 results"
                        ? 10
                        : quotes.quotes.length
                    : quotes.quotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    child: Card(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          trailing: IconButton(
                              color: quotes.quotes[index].isFav
                                  ? Colors.red
                                  : Colors.black,
                              icon: Icon(Icons.favorite),
                              onPressed: () {
                                !quotes.quotes[index].isFav? quotes.addFavorite(quotes.quotes[index].id ,quotes.quotes[index].quote):quotes.deleteFavorite(quotes.quotes[index].id ,quotes.quotes[index].quote);
                                setState(() {});
                              }),
                          title: Text(quotes.quotes[index].quote),
                        ),
                      ),
                    ),
                  );
                }),
          ),

          //TextButton(onPressed:()=> quotes.searchQuotes("happy"), child: Text("Vlick"))
        ]),
      ),
    );
  }

  Widget searchBox()
  {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextFormField(
onFieldSubmitted: ((value) async { await quotes.searchAuthorQuotes(value);
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

  Widget filter() {
    return DropdownButton(
      value: dropdownvalue,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownvalue = newValue!;
        });
      },
    );
  }
}
