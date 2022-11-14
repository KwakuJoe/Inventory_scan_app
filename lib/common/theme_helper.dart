import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ThemeHelper {
  InputDecoration textInputDecoration([String hintText = "", IconData? icon]) {
    return InputDecoration(
      prefixIcon: Icon(icon),
      hintText: hintText,
      border: InputBorder.none,
      fillColor: HexColor('51557E'),
      filled: true,
      contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 10),
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: HexColor('51557E'),
    );
  }

  ButtonStyle buttonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(50, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
    );
  }
}
