import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class CodeBarModel {
  final String id;
  final String scannedCode;
  final String date;

  CodeBarModel(
      {required this.id, required this.scannedCode, required this.date});
// create new instance of CoceBarmodel from json
  CodeBarModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        scannedCode = json['scannedCode'],
        date = json['date'];

// invoke automiticall toJson from jsonEncode when i want assing CodeBarModel as String json
  Map<String, dynamic> toJson() =>
      {'id': id, 'scannedCode': scannedCode, 'date': date};
}
