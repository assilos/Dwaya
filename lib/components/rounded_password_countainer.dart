import 'package:dwaya/components/text_field_countainer.dart';
import 'package:dwaya/constants.dart';
import 'package:flutter/material.dart';

class RoundedPasswordCountainer extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordCountainer({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        decoration: InputDecoration(
            hintText: "Password",
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            border: InputBorder.none,
            suffixIcon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            )),
      ),
    );
  }
}
