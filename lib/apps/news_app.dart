import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/news.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: News(),
      ),
    );
  }
}
