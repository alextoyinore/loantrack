import 'package:flutter/cupertino.dart';

class Apps {
  IconData iconData;
  String name;
  String? route;

  Apps({
    required this.iconData,
    required this.name,
    this.route,
  });
}
