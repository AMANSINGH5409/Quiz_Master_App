import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmasterapp/Services/database.dart';
import 'package:quizmasterapp/Widgets/appBar.dart';
import 'package:quizmasterapp/Widgets/blueButton.dart';

class AddQuestionPage extends StatefulWidget {
  final String quizId;
  const AddQuestionPage({super.key, required this.quizId});

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  String question = "", option1 = "", option2 = "", option3 = "", option4 = "";
  bool isLoading = false;

  DatabaseServices databaseServices = DatabaseServices();

  uploadQuizData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      Map<String, dynamic> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
      await databaseServices
          .addQuestionData(questionMap, widget.quizId)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        title: appBar(),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Question !" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Question",
                      ),
                      onChanged: (val) {
                        question = val;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Option-1 !" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Option1  (Correct Answer)",
                      ),
                      onChanged: (val) {
                        option1 = val;
                      },
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Option-2 !" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Option2",
                      ),
                      onChanged: (val) {
                        option2 = val;
                      },
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Option-3 !" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Option3",
                      ),
                      onChanged: (val) {
                        option3 = val;
                      },
                    ),
                    const SizedBox(height: 6.0),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Option-4 !" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Option4",
                      ),
                      onChanged: (val) {
                        option4 = val;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: const [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.orange,
                          size: 20,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "All the options will be shuffled.",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: blueBtn(
                              context: context,
                              label: "Submit",
                              buttonWeidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: () {
                            uploadQuizData();
                          },
                          child: blueBtn(
                              context: context,
                              label: "Add Question",
                              buttonWeidth:
                                  MediaQuery.of(context).size.width / 2 - 36),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
    );
  }
}
