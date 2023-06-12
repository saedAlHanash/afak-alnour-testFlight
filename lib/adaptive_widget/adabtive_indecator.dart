import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class AdabtiveIndecator extends StatelessWidget {
  String os;
  AdabtiveIndecator({required this.os});
  @override
  Widget build(BuildContext context) {
    if(os == "android") return CircularProgressIndicator(color: Colors.teal,) ;
    return CupertinoActivityIndicator(color: Colors.teal,);
  }
}
