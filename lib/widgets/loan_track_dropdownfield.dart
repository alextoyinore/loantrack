import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class LoanTrackDropDownField extends StatefulWidget {
  LoanTrackDropDownField({
    Key? key,
    this.icon,
    this.enable = true,
    required this.label,
    required this.list,
    required this.color,
    required this.dropdownValue,
  }) : super(key: key);

  List<String> list;
  String label;
  Color color;
  bool enable;
  Icon? icon;
  String dropdownValue;

  @override
  State<LoanTrackDropDownField> createState() => _LoanTrackDropDownFieldState();
}

class _LoanTrackDropDownFieldState extends State<LoanTrackDropDownField> {
  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      dropDownList: [],
      textFieldDecoration: InputDecoration(
          focusColor: widget.color.withOpacity(.3),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
            //borderSide: BorderSide(color: widget.color),
          ),
          //hintText: widget.label,
          enabled: widget.enable,
          labelText: widget.label,
          labelStyle: TextStyle(color: widget.color),
          suffixIcon: widget.icon,
          suffixIconColor: widget.color,
          fillColor: widget.color.withOpacity(.1),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.color),
          )),
    );
  }
}
