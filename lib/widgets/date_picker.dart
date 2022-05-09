import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';

class LoanTrackDatePicker extends StatefulWidget {
  LoanTrackDatePicker(
      {Key? key,
      required this.initialText,
      required this.isPayment,
      this.controller,
      this.yearsInFuture})
      : super(key: key);

  String initialText;
  int? yearsInFuture;
  TextEditingController? controller;
  bool isPayment;

  @override
  State<LoanTrackDatePicker> createState() => _LoanTrackDatePickerState();
}

class _LoanTrackDatePickerState extends State<LoanTrackDatePicker> {
  DateTime? date;

  String selectedDate = '';

  String getDate() {
    if (date == null) {
      return widget.initialText;
    } else {
      return '${date!.year}-${date!.month}-${date!.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          pickDate(context);
        },
        child: LoanTrackTextField(
            controller: widget.controller,
            label: widget.initialText,
            enable: false,
            color: (widget.isPayment)
                ? LoanTrackColors.PrimaryOne
                : LoanTrackColors.PrimaryOne));
  }

  // Pick Date
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: (widget.yearsInFuture != null && widget.yearsInFuture! > 0)
            ? DateTime(DateTime.now().year + widget.yearsInFuture!)
            : DateTime.now());

    if (newDate == null) return;

    setState(() {
      date = newDate;
      widget.controller?.text = newDate.toString().substring(0, 10);
    });
  }
}
