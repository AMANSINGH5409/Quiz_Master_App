import 'package:flutter/material.dart';
import 'package:quizmasterapp/Pages/playQuizPage.dart';
import 'package:quizmasterapp/Widgets/status_widget.dart';
import 'package:quizmasterapp/models/Question.dart';

class OptionTile extends StatefulWidget {
  final String option;
  final String description;
  final String correctAns;
  final String optionSelected;
  const OptionTile(
      {super.key,
      required this.option,
      required this.description,
      required this.correctAns,
      required this.optionSelected});

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 26.0,
            height: 26.0,
            decoration: BoxDecoration(
              color: widget.description == widget.optionSelected
                  ? widget.optionSelected == widget.correctAns
                      ? Colors.green.withOpacity(0.7)
                      : Colors.red.withOpacity(0.7)
                  : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                  color: widget.description == widget.optionSelected
                      ? widget.optionSelected == widget.correctAns
                          ? Colors.green.withOpacity(0.7)
                          : Colors.red.withOpacity(0.7)
                      : Colors.grey,
                  width: 2.0),
            ),
            child: Text(
              widget.option,
              style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? widget.correctAns == widget.optionSelected
                          ? Colors.white
                          : Colors.white
                      : Colors.grey),
            ),
          ),
          const SizedBox(width: 8.0),
          Text(widget.description,
              style: const TextStyle(fontSize: 16.0, color: Colors.black54)),
        ],
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  const QuizPlayTile({
    super.key,
    required this.questionModel,
    required this.index,
  });

  @override
  State<QuizPlayTile> createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Q${widget.index + 1}. ${widget.questionModel.question}",
              style: const TextStyle(fontSize: 17.0),
            )),
        const SizedBox(height: 4.0),
        InkWell(
          splashColor: Colors.orange.withOpacity(0.1),
          onTap: () {
            if (!widget.questionModel.answered) {
              if (widget.questionModel.option1 ==
                  widget.questionModel.correctAns) {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                correct += 1;
                notAttempted -= 1;
              } else {
                widget.questionModel.answered = true;
                optionSelected = widget.questionModel.option1;
                incorrect += 1;
                notAttempted -= 1;
              }
            }
            setState(() {});
          },
          child: OptionTile(
              option: "A",
              description: widget.questionModel.option1,
              correctAns: widget.questionModel.correctAns,
              optionSelected: optionSelected),
        ),
        InkWell(
          splashColor: Colors.orange.withOpacity(0.1),
          onTap: () {
            if (!widget.questionModel.answered) {
              if (widget.questionModel.option2 ==
                  widget.questionModel.correctAns) {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                correct += 1;
                notAttempted -= 1;
              } else {
                widget.questionModel.answered = true;
                optionSelected = widget.questionModel.option2;
                incorrect += 1;
                notAttempted -= 1;
              }
            }
            setState(() {});
          },
          child: OptionTile(
              option: "B",
              description: widget.questionModel.option2,
              correctAns: widget.questionModel.correctAns,
              optionSelected: optionSelected),
        ),
        InkWell(
          splashColor: Colors.orange.withOpacity(0.1),
          onTap: () {
            if (!widget.questionModel.answered) {
              if (widget.questionModel.option3 ==
                  widget.questionModel.correctAns) {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                correct += 1;
                notAttempted -= 1;
              } else {
                widget.questionModel.answered = true;
                optionSelected = widget.questionModel.option3;
                incorrect += 1;
                notAttempted -= 1;
              }
            }
            setState(() {});
          },
          child: OptionTile(
              option: "C",
              description: widget.questionModel.option3,
              correctAns: widget.questionModel.correctAns,
              optionSelected: optionSelected),
        ),
        InkWell(
          splashColor: Colors.orange.withOpacity(0.1),
          onTap: () {
            if (!widget.questionModel.answered) {
              if (widget.questionModel.option4 ==
                  widget.questionModel.correctAns) {
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                correct += 1;
                notAttempted -= 1;
              } else {
                widget.questionModel.answered = true;
                optionSelected = widget.questionModel.option4;
                incorrect += 1;
                notAttempted -= 1;
              }
            }
            setState(() {});
          },
          child: OptionTile(
              option: "D",
              description: widget.questionModel.option4,
              correctAns: widget.questionModel.correctAns,
              optionSelected: optionSelected),
        ),
      ]),
    );
  }
}
