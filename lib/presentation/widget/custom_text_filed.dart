import 'package:afaq_teacher/presentation/resources/font_manger.dart';
import 'package:flutter/material.dart';

import '../resources/color_manger.dart';

class CustomTextFiled extends StatelessWidget {
  String? Function(String?)? validator;
  void Function()? onTap;
  String? Function(String?)? onChanged;
  String? label;
  String? hint;
  bool? readOnly;
  TextEditingController? controller;
  TextInputType? keyboardType;
  TextInputAction? action;
  bool? isPassword;
  IconData? suffixIcon;

  CustomTextFiled(
      {super.key,
      this.validator,
      this.label,
      this.onTap,
      this.action,
      this.controller,
      this.hint,
      this.isPassword = false,
      this.keyboardType,
      this.readOnly = false,
        this.suffixIcon,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.displayLarge!.copyWith(
        fontSize: FontSize.s15
      ),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: Icon(suffixIcon,color: ColorManger.purple,)
      ),
      readOnly: readOnly!,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: action,
      obscureText: isPassword!,
    );
  }
}
