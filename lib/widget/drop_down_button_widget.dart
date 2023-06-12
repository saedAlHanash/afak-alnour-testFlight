import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget dropDownButton(context,
        {required List<String>? items,
        required Function? onchange,
        required String? hint,
        required double width,
        required double height,
          String? value,
        required String? Function(String? val)? validator}) =>
    SizedBox(
      width: width,
      height: height,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
          size: 22,
        ),
        dropdownColor: HexColor('#c0e1f4'),
        validator: validator,
        value: value,
        menuMaxHeight: 250,
        hint: Text(hint!,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: HexColor('#7871aa'), width: 1))),
        items: items!
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ))
            .toList(),
        onChanged: (item) {
          onchange!(item);
        },
      ),
    );
