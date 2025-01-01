import 'package:family_events_app/app/app_styles/app_constant_file/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_intro_controller.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final IntroController controller = Get.put(IntroController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.walkthroughPages.length,
              itemBuilder: (context, index) {
                final page = controller.walkthroughPages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      page.imagePath,
                      height: 300,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      page.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold,
                        color: Colors.indigoAccent
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      page.description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.walkthroughPages.length,
                          (index) => Obx(
                            () => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: controller.currentPage.value == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage.value == index
                                ? Colors.indigoAccent
                                : MyColors.accentColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(
                        () => controller.currentPage.value ==
                        controller.walkthroughPages.length - 1
                        ? ElevatedButton(
                      onPressed: controller.finishWalkthrough,
                      child: const Text('Get Started'),
                    )
                        : TextButton(
                      onPressed: controller.skipWalkthrough,
                      child: const Text('Skip', style: TextStyle(
                        color: Colors.indigoAccent
                      ),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
