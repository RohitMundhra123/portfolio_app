import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/home_screen_controller.dart';
import 'package:my_portfolio/screens/homescreenpages/firstpage.dart';
import 'package:my_portfolio/screens/homescreenpages/secondpage.dart';
import 'package:my_portfolio/screens/homescreenpages/thirdpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController = Get.put(
    HomeScreenController(),
  );

  Widget _body() {
    return SafeArea(
      child: Column(
        children: [_pageView(), _pageIndicator(), _bottomMenuBar()],
      ),
    );
  }

  Widget _circlePageIndicator({bool filled = false}) {
    return Container(
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: filled == true ? Colors.black : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black),
      ),
    );
  }

  Widget _pageIndicator() {
    return SizedBox(
      height: 50,
      width: 50,
      child: Stack(
        children: [
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _circlePageIndicator(),
                _circlePageIndicator(),
                _circlePageIndicator(),
              ],
            ),
          ),
          Obx(
            () => AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment:
                  homeScreenController.currentPage.value == 0
                      ? Alignment.centerLeft
                      : homeScreenController.currentPage.value == 1
                      ? Alignment.center
                      : Alignment.centerRight,
              child: _circlePageIndicator(filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageView() {
    return Expanded(
      child: PageView.builder(
        controller: homeScreenController.pageController,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          if (index == 0) {
            return FirstPage();
          } else if (index == 1) {
            return SecondPage();
          } else {
            return ThirdPage();
          }
        },
      ),
    );
  }

  Widget _bottomNavTile(String title, IconData icon, Function onTap) {
    return GestureDetector(
      onTap: onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 4),
          Flexible(
            child: Text(title, overflow: TextOverflow.ellipsis, maxLines: 1),
          ),
        ],
      ),
    );
  }

  Widget _bottomMenuBar() {
    return GridView.count(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      crossAxisCount: Get.width ~/ 75,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 10,
      mainAxisSpacing: 5,
      children: [
        _bottomNavTile('Contact', Icons.phone, () {}),
        _bottomNavTile('Journey', Icons.contacts, () {}),
        _bottomNavTile('Skills', Icons.analytics, () {}),
        _bottomNavTile('Projects', Icons.work, () {}),
        _bottomNavTile('Profile', Icons.person, () {}),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _body()));
  }
}
