import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';


class CardChar extends StatelessWidget {
  var data;

  int index;

  CardChar(this.data, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      width: 220.0,
      margin: EdgeInsets.only(
        top: 80.0,
        left: 10.0,
        right: 10.0,
        bottom: 30.0
      ),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(data[index]['image'])
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius:  15.0,
            offset:  Offset(0.0, 7.0)
          )
        ]
      )
    );
  }
}