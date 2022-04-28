import 'package:flutter/material.dart';
import 'package:loantrack/helpers/colors.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: LoanTrackColors2.TetiaryOne,
        title: Row(
          children: [
            Icon(
              Icons.newspaper,
            ),
            SizedBox(width: 10),
            Text(
              'NEWS',
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
        child: Column(
          children: const [
            Text(
              'Here you we give you the latest news on loaning in your region. Find news concerning your lenders, updates to loaning regulations and other loaning concerns here',
              style: TextStyle(color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
            SingleChildScrollView()
          ],
        ),
      ),
    );
  }
}
