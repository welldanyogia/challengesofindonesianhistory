import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController homeController = Get.put(HomeController());
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Questions')
            .doc('tOZLBwbHzWZR3ByHM27E')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Loading indicator while fetching data
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          var data = snapshot.data?.data() as Map<String, dynamic>;
          String question = data['Question'] ?? '';
          List<String> choices = [
            data['A'] ?? '',
            data['B'] ?? '',
            data['C'] ?? '',
            data['D'] ?? '',
          ];
          String answer = data['Answer'] ?? '';

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: screenHeight * 0.08, left: screenWidth * 0.44),
                child: Text(
                  homeController.count.value.toString(), // Use this to get the numeric value as a string
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
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
                    child: Text(
                      question,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 121, 72, 72)),
                    ),
                  ),
                ),
              ),
              buildAnswerButton(
                choice: choices[0],
                onPressed: () {
                  checkAnswer(choices[0], answer);
                },
                topMargin: screenHeight * 0.6,
                leftMargin: screenWidth * 0.05,
              ),
              buildAnswerButton(
                choice: choices[1],
                onPressed: () {
                  checkAnswer(choices[1], answer);
                },
                topMargin: screenHeight * 0.6,
                leftMargin: screenWidth * 0.55,
              ),
              buildAnswerButton(
                choice: choices[2],
                onPressed: () {
                  checkAnswer(choices[2], answer);
                },
                topMargin: screenHeight * 0.73,
                leftMargin: screenWidth * 0.05,
              ),
              buildAnswerButton(
                choice: choices[3],
                onPressed: () {
                  checkAnswer(choices[3], answer);
                },
                topMargin: screenHeight * 0.73,
                leftMargin: screenWidth * 0.55,
              ),
            ],
          );
        },
      ),
    );
  }

  Container buildAnswerButton({
    required String choice,
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
            choice,
            style: TextStyle(color: Colors.brown),
          ),
        ),
      ),
    );
  }

  void checkAnswer(String selectedAnswer, String correctAnswer) {
    if (selectedAnswer == correctAnswer) {
      // Correct answer, update points
      homeController.count += 10;// Adjust the points as needed
      print(homeController.count.toString());
    } else {
      // Incorrect answer, handle accordingly
    }
  }
}
