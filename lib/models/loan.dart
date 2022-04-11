import 'package:loantrack/models/loaner.dart';
import 'package:loantrack/models/loanerType.dart';

class Loan {
  double loanAmount;
  double amountRepaid;
  double interestRate;
  DateTime? applyDate;
  DateTime? dueDate;
  DateTime? lastPaymentDate;
  double overdueRate;
  LoanerType loanerType;
  Loaner loaner;

  Loan(
      {required this.loanAmount,
      required this.interestRate,
      this.applyDate,
      this.dueDate,
      this.lastPaymentDate,
      required this.loaner,
      this.loanerType = LoanerType.ONLINE_APP,
      this.amountRepaid = 0,
      this.overdueRate = 1});

  String loanInfo(String formatter) {
    return loaner.name +
        ': ' +
        formatter +
        ' LOAN: ' +
        loanAmount.toString() +
        ' ' +
        formatter +
        ' REPAID: ' +
        amountRepaid.toString();
  }
}
