import 'package:flutter/material.dart';

class Responsive extends StatefulWidget {

  final Widget mobile;
 
  final Widget desktop;
  
  const Responsive({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width<650;  //mobile < 650


  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width>=1100; 
  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
 //Desktop >=1100
  @override
  Widget build(BuildContext context){
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth >= 1100)
      {
         return widget.desktop;
      }
      else
      {
        return widget.mobile;
      }
    },);
  }
}