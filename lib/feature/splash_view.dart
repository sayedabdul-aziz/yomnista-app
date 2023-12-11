import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yomnista/core/services/local_storage.dart';
import 'package:yomnista/feature/admin/home/nav_bar.dart';
import 'package:yomnista/feature/auth/presentation/view/signin_view.dart';
import 'package:yomnista/feature/customer/home/nav_bar.dart';
import 'package:yomnista/feature/manager/home/nav_bar.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  User? user;
  Future<void> _getUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  String role = '0';
  @override
  void initState() {
    super.initState();
    _getUser();
    AppLocal.getData(AppLocal.role).then((value) {
      setState(() {
        role = value;
      });
    });
    Future.delayed(
      const Duration(seconds: 4),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => (user != null)
              ? (role == '0')
                  ? const CustomerNavBarView()
                  : (role == '1')
                      ? const ManagerNavBarView()
                      : const AdminNavBarView()
              : const LoginView(),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 250,
        ),
      ),
    );
  }
}
