import 'package:flutter/material.dart';

class StyledLabel extends StatelessWidget {
  final String label;
  final String value;
  final FontWeight fontWeight;
  final Color color;

  const StyledLabel(this.label, this.value,
      {Key? key, this.fontWeight = FontWeight.bold, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: label, style: TextStyle(color: color, fontWeight: fontWeight)),
      TextSpan(text: value, style: TextStyle(color: color))
    ]));
  }
}
