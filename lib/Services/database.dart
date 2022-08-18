import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(
      Map<String, dynamic> question, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .add(question)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future getQuizData() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  Future getQuizQuesData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
