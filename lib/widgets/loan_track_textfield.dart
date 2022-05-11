import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

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
      textAlignVertical: TextAlignVertical.top,
      style: const TextStyle(
          fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusColor: widget.color.withOpacity(.05),
          enabled: widget.enable,
          labelText: widget.label,
          labelStyle:
              const TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
          suffixIcon: widget.icon,
          suffixIconColor: widget.color,
          fillColor: LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          )),
    );
  }
}
