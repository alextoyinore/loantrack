import 'package:flutter/material.dart';

class LoanTrackTextField extends StatefulWidget {
  LoanTrackTextField(
      {Key? key,
      required this.label,
      this.keyboardType,
      this.icon,
      this.enable = true,
      this.maxLines,
      this.controller,
      this.isHidden = false,
      required this.color,
      this.whenTapped})
      : super(key: key);

  String label;
  Icon? icon;
  Color color;
  TextInputType? keyboardType;
  bool enable;
  int? maxLines;
  TextEditingController? controller;
  bool isHidden;
  Function()? whenTapped;

  @override
  State<LoanTrackTextField> createState() => _LoanTrackTextFieldState();
}

class _LoanTrackTextFieldState extends State<LoanTrackTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: widget.whenTapped,
        controller: widget.controller,
        obscureText: widget.isHidden,
        textAlignVertical: TextAlignVertical.top,
        //maxLines: widget.maxLines,
        style: TextStyle(fontSize: 16, color: widget.color),
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            filled: true,
            focusColor: widget.color.withOpacity(.3),
            enabledBorder: OutlineInputBorder(
              //borderSide: BorderSide(color: widget.color),
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            //hintText: widget.label,
            enabled: widget.enable,
            labelText: widget.label,
            labelStyle: TextStyle(color: widget.color),
            suffixIcon: widget.icon,
            suffixIconColor: widget.color,
            fillColor: widget.color.withOpacity(.1),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none, //BorderSide(color: widget.color),
            )));
  }
}
