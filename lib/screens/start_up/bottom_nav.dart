import 'package:flutter/material.dart';
import 'package:quiz_generator/screens/Signout_page.dart';
import 'package:quiz_generator/screens/mock_exam.dart';

import '../../constant/color.dart';
import '../home_page.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedIndex = 0;

  static const List<Widget> screens = [
    HomePage(),

    MockExam(),
    // CustomText(
    //   title: "My Store",
    //   size: 20,
    //   color: AppColors.primaryOrange,
    //   fontWeight: FontWeight.bold,
    // ),
    SignoutPage(),
    // CustomText(
    //   title: "Account",
    //   size: 20,
    //   color: AppColors.primaryOrange,
    //   fontWeight: FontWeight.bold,
    // ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: screens.elementAt(selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryDeepBlack,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primaryOrange,
        unselectedItemColor: AppColors.primaryGrey,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: AppColors.primaryOrange,
          fontWeight: FontWeight.w800
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryGrey,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: ImageIcon(
                AssetImage('assets/icons/Home.png'),
                color: AppColors.primaryGrey,
              ),
            ),
            label: 'Home',
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: ImageIcon(
                AssetImage('assets/icons/Home2.png'),
                color: AppColors.primaryOrange,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: ImageIcon(
                AssetImage('assets/icons/Edit Square.png'),
                color: AppColors.primaryGrey,
              ),
            ),
            label: 'Mock Exam',
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: ImageIcon(
                AssetImage('assets/icons/Edit Square2.png'),
                color: AppColors.primaryOrange,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: ImageIcon(
                AssetImage('assets/icons/Logout.png'),
                color: AppColors.primaryGrey,
              ),
            ),
            label: 'Sign Out',
            activeIcon: Padding(
              padding: EdgeInsets.only(top: 6.0),
              child: ImageIcon(
                AssetImage('assets/icons/Logout2.png'),
                color: AppColors.primaryOrange,
              ),
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        iconSize: 24,
        elevation: 5,
      ),
    );
  }
}
