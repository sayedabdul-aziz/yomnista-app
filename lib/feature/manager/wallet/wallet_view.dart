import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerWalletView extends StatelessWidget {
  const ManagerWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            itemCount: 3,
            itemBuilder: (context, index) {
              return const OrderCartWidget();
            },
            separatorBuilder: (context, index) => const Gap(15),
          )),
    );
  }
}

class OrderCartWidget extends StatelessWidget {
  const OrderCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: ClipPath(
        clipper: DolDurmaClipper(right: 100, holeRadius: 30),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                color: AppColors.color2,
              ),
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: RotatedBox(
                        quarterTurns: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Pizza',
                                    style: getbodyStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'x1',
                                    style: getbodyStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Pizza Mashrome',
                                    style: getbodyStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'x2',
                                    style: getbodyStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    color: AppColors.white,
                                  ),
                                  Text(
                                    'Delivered',
                                    style: getbodyStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.done_all_rounded,
                                    color: AppColors.white,
                                  ),
                                  Text(
                                    'Delivered',
                                    style: getbodyStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColors.color1,
                                ),
                                const Text('Mohamed Tarek'),
                              ],
                            ),
                            const Gap(10),
                            Text(
                              'SEP  08',
                              style: getbodyStyle().copyWith(
                                  fontSize: 18,
                                  fontFamily:
                                      GoogleFonts.courierPrime().fontFamily),
                            ),
                            Text(
                              '08: 00 PM',
                              style: getbodyStyle().copyWith(
                                  fontSize: 18,
                                  fontFamily:
                                      GoogleFonts.courierPrime().fontFamily),
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
    );
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
