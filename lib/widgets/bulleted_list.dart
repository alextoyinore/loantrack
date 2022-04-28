import 'package:flutter/material.dart';

class BulletedList extends StatefulWidget {
  BulletedList(
      {Key? key, required this.text, required this.style, this.bulletSize = 6})
      : super(key: key);

  String text;
  TextStyle style;
  int bulletSize = 6;

  @override
  State<BulletedList> createState() => _BulletedListState();
}

class _BulletedListState extends State<BulletedList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle,
            size: (widget.style.fontSize != null)
                ? widget.style.fontSize! / 3
                : 6,
            color: widget.style.color),
        SizedBox(width: 5),
        Text(
          widget.text,
          style: widget.style,
          softWrap: true,
        ),
      ],
    );
  }
}
