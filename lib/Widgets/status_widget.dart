import 'package:flutter/material.dart';

Widget addQuizStatus(int value, String field) {
  return Container(
    margin: const EdgeInsets.only(left: 9.0),
    child: Row(
      children: [
        Container(
            alignment: Alignment.center,
            height: 25.0,
            padding: const EdgeInsets.only(left: 6.0, right: 6.0),
            decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Text(
              "$value",
              style: const TextStyle(fontSize: 12.0, color: Colors.white),
            )),
        Container(
          alignment: Alignment.center,
          height: 25.0,
          padding: const EdgeInsets.only(left: 6.0, right: 6.0),
          decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Text(
            field,
            style: const TextStyle(fontSize: 12.0, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
