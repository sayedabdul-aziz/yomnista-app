import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerFavouriteView extends StatefulWidget {
  const CustomerFavouriteView({super.key});

  @override
  State<CustomerFavouriteView> createState() => _CustomerFavouriteViewState();
}

class _CustomerFavouriteViewState extends State<CustomerFavouriteView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackAction(),
        title: const Text('My Favourite'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Flexible(
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/food.png'),
                          ),
                          const Gap(10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Strawberry Waffle',
                                    style: getTitleStyle().copyWith(
                                      fontSize: 16,
                                      color: AppColors.black,
                                      fontFamily: GoogleFonts.lato().fontFamily,
                                    )),
                                // Text('x 1',
                                //     style: getTitleStyle().copyWith(
                                //       fontSize: 14,
                                //       fontFamily: GoogleFonts.lato().fontFamily,
                                //     )),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: AppColors.redColor,
                                  )),
                            ],
                          ),
                          const Gap(10)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Gap(15),
                ),
              ),
              const Gap(10),
            ],
          )),
    );
  }
}
