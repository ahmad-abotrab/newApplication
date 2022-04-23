import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDownwidget extends StatelessWidget {
  Function(String) callbackChosenSubCategory;
  Function(String) callbackChosenCategory;
  Function(Object) callbackListProduct;
  bool thereSubCategory = false;

  String hintText;
  List<String> items = [];
  String chosenValue;
  String showValue;
  DropDownwidget({
    Key key,
    this.callbackChosenSubCategory,
    this.callbackChosenCategory,
    this.hintText,
    this.items,
    this.showValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(items);
    return Container(
      child: DropdownButton<String>(
        elevation: 8,
        hint: Text(
          hintText,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        value: showValue,
        isExpanded: true,
        style: TextStyle(color: Colors.black),
        items: items.map((e) {
          return DropdownMenuItem<String>(
            onTap: () {},
            value: e,
            child: Container(
                decoration: BoxDecoration(), child: Text(e.toString())),
          );
        }).toList(),
        onChanged: (String value) {
          if (hintText == 'Category') {
            callbackChosenCategory?.call(value);
            chosenValue = value;
        
          } else {
            callbackChosenSubCategory?.call(value);

          }
        },
      ),
    );
  }
}
