import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/svg.dart';

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

Widget svgImage(double height,double width,String msg,String asset){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(asset,height: height,width: width),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(msg),
      ),
    ],
  );
}