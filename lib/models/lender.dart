import 'package:flutter/material.dart';

class Lender {
  String? id;
  String name;
  double? interestRate;
  String? location;
  String? phone;
  String? email;
  String? entryDate;
  String? modifiedWhen;
  String? lenderIcon;

  Lender({
    this.id,
    required this.name,
    this.email,
    this.interestRate,
    this.location,
    this.phone,
    this.entryDate,
    this.modifiedWhen,
    this.lenderIcon,
  });

  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
        'interestRate': interestRate,
        'location': location,
        'phone': phone,
        'email': email,
        'entryDate': entryDate,
        'modifiedWhen': modifiedWhen,
        'lenderIcon': lenderIcon,
      };

  static Lender fromJSON(Map<String, dynamic> data) => Lender(
        id: data['id'],
        name: data['name'],
        interestRate: data['interestRate'],
        location: data['location'],
        phone: data['phone'],
        email: data['email'],
        entryDate: data['entryDate'],
        modifiedWhen: data['modifiedWhen'],
        lenderIcon: data['lenderIcon'],
      );
}
