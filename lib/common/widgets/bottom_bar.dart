import 'package:flutter/material.dart';
import 'package:taskshift_v1/features/chatapp/screens/inbox_screen.dart';
import 'package:taskshift_v1/features/profile/screens/profile_screen.dart';
import '../../constants/global_variables.dart';

class BottomBar extends StatefulWidget {
  static const routeName = '/bottom-bar';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const InboxScreen(),
    const ProfileScreen(),
    const Center(child: Text('Profile Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: AppColors.backgroundColor,
        selectedItemColor: AppColors.colorBlue,
        unselectedItemColor: AppColors.colorGrey,
        iconSize: 28,
        onTap: updatePage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble_outlined,
              size: 20.0,
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 20.0,
            ),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
