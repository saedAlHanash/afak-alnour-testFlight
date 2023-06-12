import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class AdabtiveTextFormFiled extends StatelessWidget {
  String os;
  var controller;
  String? Function(String? val)? validator;
  String? label;
  IconData? prefixicon;
  bool ispassword = false;
  Function? ontap;
  TextInputType type;
  TextInputAction action;
  List<String> hint = [];
  IconData? suffixIcon;
  void Function()? onSuffixPressid;

  AdabtiveTextFormFiled(context,
      {required this.os,
      required this.controller,
      required this.validator,
      this.label,
      required this.hint,
      required this.action,
      this.prefixicon,
      required this.ispassword,
      this.ontap,
      required this.type,
      this.onSuffixPressid,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: ispassword,
      keyboardType: type,
      autofillHints: hint,
      textInputAction: action,
      textCapitalization: TextCapitalization.sentences,
      style: Theme.of(context).textTheme.bodyText1,
      maxLines: 1,
      onTap: () {
        ontap;
      },
      decoration: InputDecoration(
          label: Text(label!),
          filled: true,
          fillColor: Colors.white.withOpacity(0.3),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: Theme.of(context).textTheme.bodyText1,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('#7871aa'))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: HexColor('#7871aa'))),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(prefixicon),
          suffix: suffixIcon != null
              ? GestureDetector(
                  child: Icon(suffixIcon),
                  onTap: onSuffixPressid,
                )
              : SizedBox()),
    );

    // return CupertinoTextFormFieldRow(
    //   controller: controller,
    //   validator: validator,
    //   obscureText: ispassword,
    //   keyboardType: type,
    //   style: Theme.of(context).textTheme.bodyText1,
    //   maxLines: 1,
    //   onTap: () {
    //     ontap;
    //   },
    //   prefix: Icon(this.prefixicon),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     color: Colors.indigo,
    //   ),
    //   // decoration: BoxDecoration(
    //   //   label: Text(label),
    //   //   floatingLabelBehavior: FloatingLabelBehavior.always,
    //   //   labelStyle: TextStyle(
    //   //       color: Colors.black, fontSize: 16, fontFamily: primaryfont),
    //   //   enabledBorder: OutlineInputBorder(
    //   //       borderSide: BorderSide(color: HexColor('#7871aa'))),
    //   //   focusedBorder: OutlineInputBorder(
    //   //       borderSide: BorderSide(color: HexColor('#7871aa'))),
    //   //   border: OutlineInputBorder(
    //   //     borderRadius: BorderRadius.circular(5),
    //   //   ),
    //   //   prefixIcon: Icon(prefixicon),
    //   //   suffixIcon: IconButton(
    //   //     icon: Icon(suffixicon),
    //   //     onPressed: () {
    //   //       onsuffixicon;
    //   //     },
    //   //   ),
    //   // ),
    // );
  }
}
