import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController homeController = Get.put(HomeController());
  late Future<List<DocumentSnapshot>> futureQuestions;
  int incorrectAttempts = 0;
  int maxAttempts = 3;
  late RxString question = "".obs;
  late RxString answer = "".obs;
  late RxList<String> choices = <String>[].obs;
  late List<DocumentSnapshot> allQuestions;
  int currentQuestionIndex = 0;

  HomeView({Key? key}) : super(key: key) {
    futureQuestions = getAllQuestions();
  }

  Future<List<DocumentSnapshot>> getAllQuestions() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Questions')
          .get();
      print(querySnapshot.docs.length);
      return querySnapshot.docs;
    } catch (e) {
      print('Error fetching all questions: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          allQuestions = snapshot.data ?? [];

          if (allQuestions.isEmpty) {
            return Text('No questions available.');
          }

          var data = allQuestions[currentQuestionIndex].data() as Map<String, dynamic>? ?? {};
          print(data);
          question.value = data['Question'] ?? '';
          choices.value = [
            data['A'] ?? '',
            data['B'] ?? '',
            data['C'] ?? '',
            data['D'] ?? '',
          ];

          answer.value = data['Answer'] ?? '';

          return Stack(
            children: [
              buildChancesIndicator(),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Obx(() => Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.08, left: screenWidth * 0.44),
                child: Text(
                  homeController.count.string,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              )),
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.15, left: screenWidth * 0.05),
                height: screenHeight * 0.4,
                width: screenWidth * 0.9,
                child: Card(
                  color: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                        color: Colors.brown.withOpacity(0.6), width: 3),
                  ),
                  child: Center(
                    child: Obx(() => Text(
                      question.string,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 121, 72, 72)),
                    )),
                  ),
                ),
              ),
              Obx(() => buildAnswerButton(
                choice: choices[0].obs,
                onPressed: () {
                  checkAnswer(choices[0], answer.toString());
                },
                topMargin: screenHeight * 0.6,
                leftMargin: screenWidth * 0.05,
              )),
              Obx(() => buildAnswerButton(
                choice: choices[1].obs,
                onPressed: () {
                  checkAnswer(choices[1], answer.toString());
                },
                topMargin: screenHeight * 0.6,
                leftMargin: screenWidth * 0.55,
              )),
              Obx(() => buildAnswerButton(
                choice: choices[2].obs,
                onPressed: () {
                  checkAnswer(choices[2], answer.toString());
                },
                topMargin: screenHeight * 0.73,
                leftMargin: screenWidth * 0.05,
              )),
              Obx(() => buildAnswerButton(
                choice: choices[3].obs,
                onPressed: () {
                  checkAnswer(choices[3], answer.toString());
                },
                topMargin: screenHeight * 0.73,
                leftMargin: screenWidth * 0.55,
              ))
              ,
            ],
          );
        },
      ),
    );
  }

  Container buildAnswerButton({
    required RxString choice,
    required VoidCallback onPressed,
    required double topMargin,
    required double leftMargin,
  }) {
    return Container(
      margin: EdgeInsets.only(top: topMargin, left: leftMargin),
      height: 70,
      width: 180,
      child: Card(
        color: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.brown.withOpacity(0.6), width: 3),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.brown.withOpacity(0.6), width: 3),
            ),
          ),
          child: Text(
            choice.string,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.brown),
          ),
        ),
      ),
    );
  }

  void checkAnswer(String selectedAnswer, String correctAnswer) {
    if (selectedAnswer == correctAnswer) {
      homeController.count += 10;
      Get.snackbar(
        'Correct!',
        'Score: ${homeController.count}',
        snackPosition: SnackPosition.BOTTOM,
      );
      updateQuestion();
    } else {
      incorrectAttempts++;
      Get.snackbar(
        'InCorrect!',
        'Score: ${homeController.count}',
        snackPosition: SnackPosition.BOTTOM,
      );
      if (incorrectAttempts >= maxAttempts) {
        showTryAgainDialog();
      }
    }
  }

  void updateQuestion() {
    if (currentQuestionIndex < allQuestions.length - 1) {
      currentQuestionIndex++;
      question.value = allQuestions[currentQuestionIndex]['Question'] ?? '';
      choices.value = [
        allQuestions[currentQuestionIndex]['A'] ?? '',
        allQuestions[currentQuestionIndex]['B'] ?? '',
        allQuestions[currentQuestionIndex]['C'] ?? '',
        allQuestions[currentQuestionIndex]['D'] ?? '',
      ];
      answer.value=allQuestions[currentQuestionIndex]['Answer'] ?? "";
      print(answer.toString());
      print(question.toString());
      updateUI();
    } else {
      showGameOverDialog();
    }
  }

  void updateUI() {
    Get.find<HomeController>().update();
  }

  Widget buildChancesIndicator() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          maxAttempts,
              (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index < maxAttempts - incorrectAttempts
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  void showTryAgainDialog() {
    Get.defaultDialog(
      title: 'Game Over',
      content: Column(
        children: [
          Text('You have reached the maximum incorrect attempts.'),
          buildChancesIndicator(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              incorrectAttempts = 0;
              currentQuestionIndex = 0;
              futureQuestions = getAllQuestions();
              updateUI();
              Get.back();
            },
            child: Text('Try Again'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }

  void showGameOverDialog() {
    Get.defaultDialog(
      title: 'You win',
      content: Column(
        children: [
          Text('You have completed all questions!'),
          buildChancesIndicator(),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              incorrectAttempts = 0;
              currentQuestionIndex = 0;
              futureQuestions = getAllQuestions();
              updateUI();
              Get.back();
            },
            child: Text('Play Again'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Exit'),
          ),
        ],
      ),
    );
  }
}
