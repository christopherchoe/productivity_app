import 'package:flutter/material.dart';

class CustomTimeContainer extends StatelessWidget {
  CustomTimeContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(25),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(15),
        color: Colors.black38,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}