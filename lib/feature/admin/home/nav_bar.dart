import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/feature/admin/home/home_view.dart';
import 'package:yomnista/feature/admin/salary/salary_view.dart';
import 'package:yomnista/feature/profile/profile_view.dart';

class AdminNavBarView extends StatefulWidget {
  const AdminNavBarView({super.key});

  @override
  State<AdminNavBarView> createState() => _AdminNavBarViewState();
}

class _AdminNavBarViewState extends State<AdminNavBarView> {
  List<Widget> views = [
    const AdminHomeView(),
    const AdminSalaryView(),
    const ProfileView()
  ];
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColors.scaffoldBG,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: views[_selectedItem],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.symmetric(
                horizontal: BorderSide(width: 1, color: AppColors.color2))),
        child: BottomNavigationBar(
            currentIndex: _selectedItem,
            onTap: (value) {
              setState(() {
                _selectedItem = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                  activeIcon: Image.asset('assets/home1.png'),
                  icon: Image.asset('assets/home.png'),
                  label: ''),
              BottomNavigationBarItem(
                  activeIcon: Image.asset('assets/cart1.png'),
                  icon: Image.asset('assets/cart.png'),
                  label: ''),
              BottomNavigationBarItem(
                  activeIcon: Image.asset('assets/user1.png'),
                  icon: Image.asset('assets/user.png'),
                  label: ''),
            ]),
      ),
    );
  }
}
