import 'dart:async';

import 'package:flutter/material.dart';

class SlideLeft {
  slideLeft()  {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () {

              },
              icon: Icon(Icons.delete, color: Colors.white,),
            ),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(width: 20,)
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget slideRight() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit, color: Colors.white,),
            ),
            Text(
              'Edit',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(width: 20,)
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
