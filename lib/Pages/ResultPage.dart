import 'package:flutter/material.dart';
import 'package:quizmasterapp/Pages/playQuizPage.dart';
import 'package:quizmasterapp/Widgets/blueButton.dart';

class ResultPage extends StatefulWidget {
  final int total;
  final int correct;
  const ResultPage({super.key, required this.total, required this.correct});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/results.png',
                height: 100.0,
                width: 100.0,
              ),
              const SizedBox(height: 15.0),
              Text(
                "$correct/$total",
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15.0,
              ),
              (correct * 100) / total < 50.0
                  ? const Text(
                      "More efforts needed \n Not Qualified!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.red),
                    )
                  : const Text(
                      "Congratulations \n You are qualified!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.green),
                    ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: blueBtn(
                    context: context,
                    label: "Go To Home",
                    buttonWeidth: MediaQuery.of(context).size.width / 2),
              ),
              const SizedBox(height: 40.0),
            ],
          ),
        ));
  }
}
