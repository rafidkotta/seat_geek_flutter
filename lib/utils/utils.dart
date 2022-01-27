import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showSnackBar({required BuildContext context,required String message,required MaterialColor color}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: color,
  ),);
}

String parseDate(String date){
  final dateTime = DateTime.parse(date);
  final format = DateFormat('E, d MMM y HH:mm a');
  return format.format(dateTime.toLocal());
}