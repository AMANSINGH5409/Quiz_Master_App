import 'package:flutter/material.dart';

Widget blueBtn({context, label, buttonWeidth}) {
  return Container(
    alignment: Alignment.center,
    height: 45,
    width: buttonWeidth ?? MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.orange,
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
    ),
  );
}
