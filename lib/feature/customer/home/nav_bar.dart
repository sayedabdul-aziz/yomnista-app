import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/feature/customer/cart/cart_view.dart';
import 'package:yomnista/feature/customer/home/home_view.dart';
import 'package:yomnista/feature/profile/profile_view.dart';
import 'package:flutter/material.dart';

class CustomerNavBarView extends StatefulWidget {
  const CustomerNavBarView({super.key});

  @override
  State<CustomerNavBarView> createState() => _CustomerNavBarViewState();
}

class _CustomerNavBarViewState extends State<CustomerNavBarView> {
  List<Widget> views = [
    const CustomerHomeView(),
    const CustomerCartView(),
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
