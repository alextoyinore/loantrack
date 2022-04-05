import 'package:loantrack/data/loaner.dart';
import 'package:loantrack/data/loanerType.dart';

class Loan {
  double loanAmount;
  double amountRepaid;
  double interestRate;
  DateTime? applyDate;
  DateTime? dueDate;
  double overdueRate;
  LoanerType loanerType;
  Loaner loaner;

  Loan(
      {required this.loanAmount,
      required this.interestRate,
      this.applyDate,
      required this.loaner,
      this.loanerType = LoanerType.ONLINE_APP,
      this.amountRepaid = 0,
      this.dueDate,
      this.overdueRate = 1});

  String loanInfo(String formatter) {
    return loaner.name +
        ': ' +
        formatter +
        ' LOAN: ' +
        loanAmount.toString() +
        formatter +
        ' REPAID: ' +
        amountRepaid.toString();
  }
}
