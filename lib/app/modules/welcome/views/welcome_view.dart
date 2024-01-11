import 'package:challengesofindonesianhistory/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../about/views/about_view.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  const WelcomeView({Key? key}) : super(key: key);
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
          // Tambahkan widget untuk gambar atau ikon di belakang MenuButton
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 250,
            // Setengah tinggi layar dikurangi setengah tinggi gambar
            left: -150,
            // Gambar diletakkan di sebelah kiri (posisi x = 0)
            child: Image.asset(
              'assets/images/mc.png',
              width: 500,
              height: 500,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(left: 50, right: 30, bottom: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(onPressed: (){
                  //   Get.to(()=> HomeView());
                  // }, child: Text("Mulai"))
                  TextButton(onPressed:(){
                    Get.to(() => HomeView());
                  }, child: Text(
                      "Muali"
                  )),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const AboutView());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.brown.withOpacity(0.6), width: 3),
                      ),
                    ),
                    child: Text("Mulai",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        )),
                  ),
                  // MenuButton(
                  //   label: 'About',
                  //   onPressed: () {
                  //     Get.to(() => const AboutView());
                  //   },
                  // ),
                  // MenuButton(
                  //   label: 'Keluar',
                  //   onPressed: () {
                  //     SystemNavigator.pop();
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
