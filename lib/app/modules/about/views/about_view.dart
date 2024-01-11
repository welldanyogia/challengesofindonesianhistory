import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Game "Challenges of Indonesian History" bertema Sejarah Indonesia bergenre Game Quiz dibuat untuk memenuhi Tugas Besar Pemrograman Mobile yang diampu oleh Pak Didih Rizki Chandranegara, S.kom., M.Kom. Game ini dirancang oleh : Dawamul Ikhsan, Welldan Yogia Hwan Egiyaksa, dan Farid Fadhillah',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center, // Set text alignment to center
              ),
            ),
          ),
        ],
      ),
    );
  }
}
