import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmasterapp/Pages/ResultPage.dart';
import 'package:quizmasterapp/Services/database.dart';
import 'package:quizmasterapp/Widgets/appBar.dart';
import 'package:quizmasterapp/Widgets/quiz_play_widget.dart';
import 'package:quizmasterapp/models/Question.dart';

import '../Widgets/status_widget.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  const PlayQuiz({super.key, required this.quizId});

  @override
  State<PlayQuiz> createState() => _PlayQuizState();
}

int total = 0;
int correct = 0;
int incorrect = 0;
int notAttempted = 0;
var infoStream;

class _PlayQuizState extends State<PlayQuiz> {
  DatabaseServices databaseServices = DatabaseServices();
  var questionSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(DocumentSnapshot queSnapshot) {
    QuestionModel questionModel = QuestionModel();

    questionModel.question = queSnapshot.get("question");
    questionModel.correctAns = queSnapshot.get("option1");

    List<String> options = [
      queSnapshot.get("option1"),
      queSnapshot.get("option2"),
      queSnapshot.get("option3"),
      queSnapshot.get("option4"),
    ];

    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    databaseServices.getQuizQuesData(widget.quizId).then((value) {
      setState(() {
        questionSnapshot = value;
        notAttempted = questionSnapshot.docs.length;
        correct = 0;
        incorrect = 0;
        total = questionSnapshot.docs.length;
        print("$total this is total");
      });
    });

    if (infoStream == null) {
      infoStream =
          Stream<List<int>>.periodic(const Duration(milliseconds: 100), (x) {
        print("this is x $x");
        return [correct, incorrect];
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    infoStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ResultPage(total: total, correct: correct)));
        },
        child: const Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark),
        title: appBar(),
      ),
      body: Container(
        child: questionSnapshot != null
            ? Column(
                children: [
                  QuizStatus(
                      total: total,
                      correct: correct,
                      incorrect: incorrect,
                      notAttempted: notAttempted),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: questionSnapshot.docs.length,
                      itemBuilder: (context, index) {
                        return QuizPlayTile(
                            index: index,
                            questionModel: getQuestionModelFromDataSnapshot(
                                questionSnapshot.docs[index]));
                      },
                    ),
                  )
                ],
              )
            : Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}

class QuizStatus extends StatefulWidget {
  final int total;
  final int correct;
  final int incorrect;
  final int notAttempted;
  const QuizStatus(
      {super.key,
      required this.total,
      required this.correct,
      required this.incorrect,
      required this.notAttempted});

  @override
  State<QuizStatus> createState() => _QuizStatusState();
}

class _QuizStatusState extends State<QuizStatus> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: infoStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Container(
                height: 40.0,
                margin: const EdgeInsets.only(left: 14.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    addQuizStatus(total, "Total"),
                    addQuizStatus(correct, "Correct"),
                    addQuizStatus(incorrect, "Incorrect"),
                    addQuizStatus(notAttempted, "NotAttempted"),
                  ],
                ),
              )
            : Container();
      },
    );
  }
}
