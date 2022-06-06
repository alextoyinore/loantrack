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
    return TextField(
      onTap: widget.whenTapped,
      controller: widget.controller,
      obscureText: widget.isHidden,
      textAlign: TextAlign.justify,
      textAlignVertical: TextAlignVertical.top,
      style: TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.onBackground.withOpacity(.5),
      ),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(100)),
          focusColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(.05),
          enabled: widget.enable,
          hintText: '  ' + widget.label,
          suffixIcon: widget.icon,
          suffixIconColor: widget.color,
          fillColor:
              Theme.of(context).colorScheme.onBackground.withOpacity(.05),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(100),
          )),
    );
  }
}
