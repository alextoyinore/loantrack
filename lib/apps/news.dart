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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.newspaper, color: LoanTrackColors2.TetiaryOne),
              SizedBox(width: 10),
              Text(
                'NEWS',
                style:
                    TextStyle(color: LoanTrackColors2.TetiaryOne, fontSize: 20),
              )
            ],
          ),
          SizedBox(height: 20),
          const Text(
            'Here you we give you the latest news on loaning in your region. Find news concerning your lenders, updates to loaning regulations and other loaning concerns here',
            style: TextStyle(
              color: LoanTrackColors.PrimaryTwoVeryLight,
              fontSize: 12,
            ),
          ),
          SingleChildScrollView()
        ],
      ),
    );
  }
}
