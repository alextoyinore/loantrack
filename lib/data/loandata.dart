// ignore_for_file: unnecessary_getters_setters

class LoanData {
  double _loanAmount = 0;
  double _amountRepaid = 0;
  double _interestRate = 0;
  double _dailyOverdueCharge = 0;

  String _applyWhen = '';
  String _dueWhen = '';
  String _lastRepaidWhen = '';

  String _entryDate = '';
  String _modifiedWhen = '';

  String _lenderType = '';
  String _lender = '';

  String _loanPurpose = '';
  String _note = '';

  LoanData();

  double get loanAmount {
    return _loanAmount;
  }

  double get amountRepaid {
    return _amountRepaid;
  }

  double get interestRate {
    return _interestRate;
  }

  double get dailyOverdueCharge {
    return _dailyOverdueCharge;
  }

  String get applyWhen {
    return _applyWhen;
  }

  String get dueWhen {
    return _dueWhen;
  }

  String get lastRepaidWhen {
    return _lastRepaidWhen;
  }

  String get entryDate {
    return _entryDate;
  }

  String get modifiedWhen {
    return _modifiedWhen;
  }

  String get lenderType {
    return _lenderType;
  }

  String get lender {
    return _lender;
  }

  String get loanPurpose {
    return _loanPurpose;
  }

  String get note {
    return _note;
  }

  set loanAmount(double value) {
    _loanAmount = value;
  }

  set amountRepaid(double value) {
    _amountRepaid = value;
  }

  set interestRate(double value) {
    _interestRate = value;
  }

  set dailyOverdueCharge(double value) {
    _dailyOverdueCharge = value;
  }

  set applyWhen(String value) {
    _applyWhen = value;
  }

  set dueWhen(String value) {
    _dueWhen = value;
  }

  set lastRepaidWhen(String value) {
    _lastRepaidWhen = value;
  }

  set entryDate(String value) {
    _entryDate = value;
  }

  set modifiedWhen(String value) {
    _modifiedWhen = value;
  }

  set lenderType(String value) {
    _lenderType = value;
  }

  set lender(String value) {
    _lender = value;
  }

  set loanPurpose(String value) {
    _loanPurpose = value;
  }

  set note(String value) {
    _note = value;
  }
}
