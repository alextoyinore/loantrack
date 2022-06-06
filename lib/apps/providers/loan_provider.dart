import 'package:flutter/material.dart';

class LoanDetailsProviders with ChangeNotifier {
  double _loanTotal = 0;
  double _repaidTotal = 0;
  int _numberOfLenders = 0;
  double _totalSettled = 0;
  double _totalArchived = 0;
  double _netIncome = 0;
  String _maritalStatus = '';

  double get loanTotal => _loanTotal;
  double get repaidTotal => _repaidTotal;
  int get numberOfLenders => _numberOfLenders;
  double get totalSettled => _totalSettled;
  double get totalArchived => _totalArchived;
  double get netIncome => _netIncome;
  String get maritalStatus => _maritalStatus;

  void setLoanTotal(double value) {
    _loanTotal = value;
  }

  void setRepaidTotal(double value) {
    _repaidTotal = value;
  }

  void setNumberOfLenders(int value) {
    _numberOfLenders = value;
  }

  void setTotalSettled(double value) {
    _totalSettled = value;
  }

  void setTotalArchived(double value) {
    _totalArchived = value;
  }

  void setNetIncome(double value) {
    _netIncome = value;
  }

  void setMaritalStatus(String value) {
    _maritalStatus = value;
  }
}
