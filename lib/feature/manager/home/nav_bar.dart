import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/feature/admin/salary/salary_view.dart';
import 'package:borcelle_restaurant/feature/customer/profile/profile_view.dart';
import 'package:borcelle_restaurant/feature/manager/home/home_view.dart';
import 'package:flutter/material.dart';

class ManagerNavBarView extends StatefulWidget {
  const ManagerNavBarView({super.key});

  @override
  State<ManagerNavBarView> createState() => _ManagerNavBarViewState();
}

class _ManagerNavBarViewState extends State<ManagerNavBarView> {
  List<Widget> views = [
    const ManagerHomeView(),
    const AdminSalaryView(),
    const ProfileView()
  ];
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
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
