import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/core/utils/app_text_styles.dart';
import 'package:borcelle_restaurant/core/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerCartView extends StatefulWidget {
  const CustomerCartView({super.key});

  @override
  State<CustomerCartView> createState() => _CustomerCartViewState();
}

class _CustomerCartViewState extends State<CustomerCartView> {
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
        title: const Text('My Cart'),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('cart-list')
              .doc(user?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Flexible(
                      child: ListView.separated(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          DocumentSnapshot item = snapshot.data!;
                          return Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage:
                                      NetworkImage(item['p_image']),
                                ),
                                const Gap(10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item['p_name'],
                                          style: getTitleStyle().copyWith(
                                            fontSize: 16,
                                            color: AppColors.black,
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily,
                                          )),
                                      Text('x ${item['quantity']}',
                                          style: getTitleStyle().copyWith(
                                            fontSize: 14,
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily,
                                          )),
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
                                          Icons.delete,
                                          color: AppColors.redColor,
                                        )),
                                    Text('EGP ${item['total']}',
                                        style: getTitleStyle().copyWith(
                                          fontSize: 14,
                                          color: AppColors.black,
                                          fontFamily:
                                              GoogleFonts.lato().fontFamily,
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
                    const CustomButton(
                      text: 'Checkout',
                      width: 170,
                      radius: 30,
                    )
                  ],
                ));
          }),
    );
  }
}
