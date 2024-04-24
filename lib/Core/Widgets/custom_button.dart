

import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../Utils/Colors.dart';
import '../Utils/Responsive.dart';
import '../Utils/constants.dart';

class CustomButon extends StatelessWidget {
  CustomButon({this.onTap, required this.text});
  VoidCallback? onTap;
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child:Container(
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorApp.ButtonColor,
            borderRadius: BorderRadius.circular(ValueApp.kcircular),

          ),
          child: Text(
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 26),
            text,
          ),
        ),
      ),
    );
  }
}


class HomeButons extends StatelessWidget {
  HomeButons({this.onTap, required this.text,required this.icon,required this.color,required this.shadow});
  VoidCallback? onTap;
  String text;
  IconData icon;
  Color color;
  Color shadow;
  @override
  Widget build(BuildContext context) {
    return  TextButton(
      style: ButtonStyle(
           fixedSize: Responsive.isTablet(context) == true ? MaterialStatePropertyAll(Size(300, 100)) : null,
          backgroundColor: MaterialStatePropertyAll(Colors.white), shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
          )
      )) ,
      onPressed: onTap, child: Row(
      children: [
        Container(

            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(  color: color,borderRadius: BorderRadius.circular(ValueApp.kcircular),boxShadow: [BoxShadow(color: shadow,spreadRadius:1 ,blurRadius: 2)]),
            child: Icon(icon,color: Colors.white,)),
        SizedBox(width: 5,),
        Text(text, style:Responsive.isTablet(context) == true ? TextStyle(
          fontSize: 35
        ) : null,)

      ],



    ),);
  }
}




