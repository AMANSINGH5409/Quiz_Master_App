import 'package:flutter/material.dart';

Widget appBar() {
  return RichText(
    text: const TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: "Quiz",
          style: TextStyle(
              color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        TextSpan(
          text: "Master",
          style: TextStyle(
              color: Colors.orange, fontSize: 18, fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}
