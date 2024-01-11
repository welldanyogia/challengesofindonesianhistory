import 'package:challengesofindonesianhistory/app/modules/about/views/about_view.dart';
import 'package:challengesofindonesianhistory/app/modules/home/views/home_view.dart';
import 'package:challengesofindonesianhistory/app/modules/welcomepage/views/widget/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/welcomepage_controller.dart';

class WelcomepageView extends GetView<WelcomepageController> {
  const WelcomepageView({Key? key}) : super(key: key);

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

                  MenuButton(
                    label: 'Mulai',
                    onPressed: () {
                      Get.to(() => HomeView());
                    },
                  ),
                  MenuButton(
                    label: 'About',
                    onPressed: () {
                      Get.to(() => const AboutView());
                    },
                  ),
                  MenuButton(
                    label: 'Keluar',
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
