import 'package:flutter/material.dart';
import 'package:loantrack/data/local.dart';
import 'package:loantrack/models/loan.dart';
import 'package:loantrack/widgets/loan_progress_bar.dart';

class LoanList extends StatefulWidget {
  LoanList({Key? key, required this.loanList}) : super(key: key);

  List<Loan> loanList;

  @override
  State<LoanList> createState() => _LoanListState();
}

class _LoanListState extends State<LoanList> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: ListView.builder(
        //padding: const EdgeInsets.only(bottom: 10),
        itemCount: LocalData.loans.length,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: LoanProgressBar(loan: LocalData.loans[index]),
          );
        },
      ),
    );
  }
}
