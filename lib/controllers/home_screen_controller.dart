import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController{
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    pageController.addListener(() {
      currentPage.value = pageController.page!.round();
    });
    super.onInit();
  }

  void changePage(int index){
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  
}