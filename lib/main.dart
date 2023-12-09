import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/core/utils/app_text_styles.dart';
import 'package:borcelle_restaurant/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:borcelle_restaurant/feature/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.scaffoldBG,
    statusBarIconBrightness: Brightness.dark,
  ));
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCSEBjGvGkvbSCeiSwmR-X7-L9h2BVC678',
          appId: 'com.example.restaurant_app',
          messagingSenderId: '768932994403',
          projectId: 'restaurant-app-12-2023'));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.scaffoldBG,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              backgroundColor: AppColors.scaffoldBG,
            ),
            snackBarTheme:
                SnackBarThemeData(backgroundColor: AppColors.redColor),
            appBarTheme: AppBarTheme(
                titleTextStyle: getTitleStyle(color: AppColors.color1),
                centerTitle: true,
                elevation: 0.0,
                actionsIconTheme: IconThemeData(color: AppColors.color1),
                backgroundColor: AppColors.color3),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.only(
                  left: 20, top: 10, bottom: 10, right: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppColors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppColors.black),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppColors.redColor),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppColors.redColor),
              ),
              filled: true,
              suffixIconColor: AppColors.color1,
              prefixIconColor: AppColors.color1,
              fillColor: AppColors.color3,
              hintStyle: GoogleFonts.poppins(
                color: AppColors.color2,
                fontSize: 14,
              ),
            ),
            dividerTheme: DividerThemeData(
              color: AppColors.black,
              indent: 10,
              endIndent: 10,
            ),
            fontFamily: GoogleFonts.inter().fontFamily),
        home: const SplashView(),
      ),
    );
  }
}
