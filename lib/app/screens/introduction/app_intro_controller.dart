import 'package:family_events_app/app/app_styles/app_constant_file/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../services/app_perferences.dart';
import 'app_into_walkthroug.dart';

class IntroController extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();
  final List<WalkthroughPageModel> walkthroughPages = [
    WalkthroughPageModel(

      imagePath:  'assets/images/first.png',
      title: 'Welcome to Beecham Family App',
      description:
      'Your ultimate solution for managing all kind of events efficiently for your family.',
    ),
    WalkthroughPageModel(
      imagePath: 'assets/images/second.png',
      title: 'Manage Statistics Seamlessly',
      description:
      'Monitor the status of statistics in real-time with our intuitive home page.',
    ),
    WalkthroughPageModel(
      imagePath: 'assets/images/third.png',
      title: 'Check Your Recently Activities',
      description:
      'Add, edit, and update all kind of event effortlessly to ensure prompt resolution and customer satisfaction.',
    ),
    WalkthroughPageModel(
      imagePath: 'assets/images/fourh.png',
      title: 'Manage All Family Member',
      description:
      'Ensure your team addresses customer issues effectively, boosting satisfaction and loyalty.',
    ),
    WalkthroughPageModel(
      imagePath: 'assets/images/five.png',
      title: 'Manage All Upcoming Events',
      description:
      'Leverage data analytics to identify trends and improve your service quality continuously.',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void skipWalkthrough() {
    pageController.animateToPage(
      walkthroughPages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }


  void finishWalkthrough() async {
    Get.find<Preferences>().setBool(Keys.isFirstTime, false);
    bool status = Get.find<Preferences>().getBool(Keys.status) ?? false;
    if (status) {
      Get.offAllNamed(AppRoutes.homeScreen);
    } else {
      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }
}
