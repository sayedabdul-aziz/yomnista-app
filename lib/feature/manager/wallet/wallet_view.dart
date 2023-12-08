import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerWalletView extends StatelessWidget {
  const ManagerWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [MyHomePage()],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: ClipPath(
              clipper: DolDurmaClipper(right: 100, holeRadius: 30),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: AppColors.color2,
                    ),
                    width: double.infinity,
                    height: 200,
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: RotatedBox(
                              quarterTurns: 2,
                              child: Column(
                                children: [
                                  Text('second '),
                                  Text('second example'),
                                ],
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: RotatedBox(
                              quarterTurns: 1,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: AppColors.color1,
                                      ),
                                      const Text('seond '),
                                    ],
                                  ),
                                  const Gap(10),
                                  Text(
                                    'SEP  08',
                                    style: getbodyStyle().copyWith(
                                        fontFamily: GoogleFonts.courierPrime()
                                            .fontFamily),
                                  ),
                                  const Gap(10),
                                  Text(
                                    '08: 00 PM',
                                    style: getbodyStyle().copyWith(
                                        fontFamily: GoogleFonts.courierPrime()
                                            .fontFamily),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                      right: 105,
                      child: RotatedBox(
                          quarterTurns: 3,
                          child: Text('- - - - - - - - - - - - - - - - - -'))),
                ],
              ),
            ),
          ),
        ]);
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({required this.right, required this.holeRadius});

  final double right;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - right - holeRadius, 0.0)
      ..arcToPoint(
        Offset(size.width - right, 0),
        clockwise: false,
        radius: const Radius.circular(1),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - right, size.height)
      ..arcToPoint(
        Offset(size.width - right - holeRadius, size.height),
        clockwise: false,
        radius: const Radius.circular(1),
      );

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
