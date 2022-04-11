import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class LoanTrackTextButton extends StatefulWidget {
  LoanTrackTextButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isOutline = false,
    this.isPrimary = true,
  }) : super(key: key);

  final Function() onPressed;
  final String label;
  final bool isOutline;
  final bool isPrimary;

  @override
  State<LoanTrackTextButton> createState() => _LoanTrackTextButtonState();
}

class _LoanTrackTextButtonState extends State<LoanTrackTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        onPressed: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: !widget.isOutline
                  ? widget.isPrimary
                      ? LoanTrackColors.PrimaryOne.withOpacity(.2)
                      : LoanTrackColors.PrimaryTwo.withOpacity(.2)
                  : Colors.transparent,
              border: !widget.isOutline
                  ? widget.isPrimary
                      ? Border.all(
                          color: LoanTrackColors.PrimaryOne.withOpacity(.4))
                      : Border.all(
                          color: LoanTrackColors.PrimaryTwo.withOpacity(.4))
                  : Border.all(width: 0)),
          child: Text(widget.label,
              style: const TextStyle(
                  fontSize: 12, color: LoanTrackColors.PrimaryOne)),
        ));
  }
}
