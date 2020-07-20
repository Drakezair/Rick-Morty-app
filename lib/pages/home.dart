import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mvpmake/components/card_char.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int current;
  List data;
  String info;
  ScrollController _scrollController =new ScrollController();
  int currentPage = 1;


  @override
  void initState(){
    super.initState();
    initFetch();

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
          fetchTwenty();
      }
    });
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

   initFetch() async {
    var response = await http.get("https://rickandmortyapi.com/api/character/");
    var predata = json.decode(response.body);
    setState(() {
      current = 0;
      data = predata["results"];
      info = predata['info']["next"];
    });
  }

  fetchTwenty() async{
      currentPage <= 30 ? currentPage++ : null;
      var response = http.get("https://rickandmortyapi.com/api/character/?page=$currentPage");
      var predataServer = await response.then((value) => value.body);
      var dataJson = json.decode(predataServer);
      var predata = dataJson['results'];
      setState(() {
      data += predata;
      });
  }

  @override
  Widget build(BuildContext context) {


    final top_bar = Stack(
      children: [Container(
          height: 200.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6a097d),
                Color(0xFFc060a1),
              ]
            )
          ),
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index){
              return InkWell(
                child: CardChar(data, index),
                onTap: (){
                  setState(() {
                    current = index;
                  });
                },
              );
            },
          )
        
        )
      ]
    );
    


    final description_place = Container(
      margin: EdgeInsets.only(top: 330.0, left: 20.0,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Text(
              data == null ? '' : data[current]["name"],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
                
              ),
            ),
            Container(
              margin: EdgeInsets.only(right:20.0, top:20.0),
              child: Table(
                border: TableBorder.all(color: Color(0xFFffdcb4)),
                children: [
                  TableRow(children: [
                    Container(
                      padding: EdgeInsets.only(left:9.0),
                      child: Text(
                        'Status',
                        style: TextStyle(fontWeight: FontWeight.w900,  ),
                      ), 
                    ),
                    Container(
                      child: Text(data == null ? "" : data[current]['status']),
                      padding: EdgeInsets.only(left:9.0),
                    )
                  ]),
                  TableRow(children: [
                    Container(
                      padding: EdgeInsets.only(left:9.0),
                      child: Text(
                        'species',
                        style: TextStyle(fontWeight: FontWeight.w900,  ),
                      ), 
                    ),
                    Container(
                      child: Text(data == null ? "" : data[current]['species']),
                      padding: EdgeInsets.only(left:9.0),
                    )
                  ]),
                  TableRow(children: [
                    Container(
                      padding: EdgeInsets.only(left:9.0),
                      child: Text(
                        'type',
                        style: TextStyle(fontWeight: FontWeight.w900,  ),
                      ), 
                    ),
                    Container(
                      child: Text(data == null ? "" : data[current]['type']),
                      padding: EdgeInsets.only(left:9.0),
                    )
                  ]),
                  TableRow(children: [
                    Container(
                      padding: EdgeInsets.only(left:9.0),
                      child: Text(
                        'gender',
                        style: TextStyle(fontWeight: FontWeight.w900,  ),
                      ), 
                    ),
                    Container(
                      child: Text(data == null ? "" : data[current]['gender']),
                      padding: EdgeInsets.only(left:9.0),
                    )
                  ]),
                  TableRow(children: [
                    Container(
                      padding: EdgeInsets.only(left:9.0),
                      child: Text(
                        'origin',
                        style: TextStyle(fontWeight: FontWeight.w900,  ),
                      ), 
                    ),
                    Container(
                      child: Text(data == null ? "" : data[current]['origin']["name"]),
                      padding: EdgeInsets.only(left:9.0),
                    )
                  ]),
                  TableRow(children: [
                    Container(
                      padding: EdgeInsets.only(left:9.0),
                      child: Text(
                        'location',
                        style: TextStyle(fontWeight: FontWeight.w900,  ),
                      ), 
                    ),
                    Container(
                      child: Text(data == null ? "" : data[current]['location']["name"]),
                      padding: EdgeInsets.only(left:9.0),
                    )
                  ]),
                ]
              ),
            )
            
          ],
        ),
    );
    
    

    final table_info = Container(
      child: Table(
        children:[
          TableRow(children: [Text('hola'), Text('hola')])
        ],
      ),
    );

    return Stack(
      children: [
        top_bar,
        description_place,
        table_info
      ]
    );
    
  }
}