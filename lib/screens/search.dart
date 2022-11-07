import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quotes/models/quote.dart';
import 'package:quotes/providers/search_quotes.dart';
import 'package:quotes/widgets/search_box.dart';

class SearchScreen extends StatefulWidget {
  

static const route='/searchScreen';


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
Quotes quotes= Quotes();

var items = [   
    'Show 10 results',
    'Show 100 results',
    
  ];

    String dropdownvalue = 'Show 10 results';  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          SizedBox(height: 30,),
          SearchBox(),
      filter(),
          Container(
            height: MediaQuery.of(context).size.height-140,
            child: ListView.builder(
              itemCount:quotes.quotes.length>=10? dropdownvalue=="Show 10 results"?10:quotes.quotes.length:quotes.quotes.length,
              itemBuilder:  (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 10 ,bottom: 10 ,right: 10),
                  child: Card(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        trailing: IconButton(
                          color: quotes.quotes[index].isFav?Colors.red:Colors.black,
                          icon:Icon(Icons.favorite) ,onPressed:() { quotes.updateFavorite(quotes.quotes[index].id); setState(() {
                            
                          });}),
                        title: Text(quotes.quotes[index].quote),),
                    ),
                  ),
                );
              } ),
          ),

          
          //TextButton(onPressed:()=> quotes.searchQuotes("happy"), child: Text("Vlick"))
        ]),
      ),
    );
  }
Widget filter()
{
  return DropdownButton(
               
              // Initial Value
              value: dropdownvalue,
               
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),   
               
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            );
}


  
}

