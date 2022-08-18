import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmasterapp/Pages/createQuizPage.dart';
import 'package:quizmasterapp/Pages/playQuizPage.dart';
import 'package:quizmasterapp/Services/auth.dart';
import 'package:quizmasterapp/Services/database.dart';
import 'package:quizmasterapp/Widgets/appBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseServices databaseServices = DatabaseServices();
  Stream quizStream = const Stream.empty();

  @override
  void initState() {
    databaseServices.getQuizData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    const SnackBar(content: Text("Data loaded Successfully"));
    super.initState();
  }

  Widget quizList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      child: StreamBuilder(
          stream: quizStream,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: ((context, index) {
                      return QuizTile(
                        title: snapshot.data.docs[index].data()["quizTitle"],
                        desc: snapshot.data.docs[index].data()["quizDesc"],
                        imgUrl: snapshot.data.docs[index].data()["quizImg"],
                        quizId: snapshot.data.docs[index].data()["quizId"],
                      );
                    }),
                  );
          }),
    );
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
        actions: [
          GestureDetector(
            onTap: () {
              AuthServices().signOut(context: context);
            },
            child: Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: const Icon(Icons.logout)),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: quizList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateQuizPage()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;
  const QuizTile(
      {super.key,
      required this.title,
      required this.desc,
      required this.imgUrl,
      required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayQuiz(quizId: quizId)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        height: 150.0,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: imgUrl == "no image"
                  ? Image.asset(
                      "assets/images/placeholder.jpg",
                      width: MediaQuery.of(context).size.width,
                      height: 150.0,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: imgUrl,
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(8.0)),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    desc,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
