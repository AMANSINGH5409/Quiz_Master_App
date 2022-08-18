import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmasterapp/Pages/addQuestionPage.dart';
import 'package:quizmasterapp/Services/database.dart';
import 'package:quizmasterapp/Widgets/appBar.dart';
import 'package:quizmasterapp/Widgets/blueButton.dart';
import 'package:random_string/random_string.dart';

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final _formKey = GlobalKey<FormState>();
  String imgUrl = "", quizTitle = "", quizDesc = "", quizId = "";
  bool isLoading = false;

  DatabaseServices databaseServices = DatabaseServices();

  createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, dynamic> quizMap = {
        "quizId": quizId,
        "quizImg": imgUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDesc,
      };
      await databaseServices.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddQuestionPage(quizId: quizId)));
      });
    }
  }

  noImage() {
    imgUrl = "no image";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        title: appBar(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? noImage() : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Quiz Image url (Optional)",
                      ),
                      onChanged: (val) {
                        imgUrl = val;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Quiz Title" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Quiz Title",
                      ),
                      onChanged: (val) {
                        quizTitle = val;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "Enter Quiz Description" : null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Quiz Description",
                      ),
                      onChanged: (val) {
                        quizDesc = val;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          createQuizOnline();
                        },
                        child: blueBtn(context: context, label: "Create Quiz")),
                    const SizedBox(height: 40.0),
                  ],
                ),
              ),
            ),
    );
  }
}
