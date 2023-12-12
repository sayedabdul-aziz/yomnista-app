import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';
import 'package:yomnista/core/widgets/custom_error.dart';
import 'package:yomnista/feature/customer/menu/details_view.dart';

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('favourite-list')
              .doc(user?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.data()!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_outlined,
                      size: 150,
                      color: AppColors.color3,
                    ),
                    const Gap(20),
                    Text(
                      'No Items in your favourite\nOpen Menu and add to your favourite',
                      textAlign: TextAlign.center,
                      style: getbodyStyle(
                        fontSize: 16,
                        color: AppColors.color1,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: ListView.separated(
                  itemCount: snapshot.data!.data()!.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data!.data()!;
                    List<String> keyy = snapshot.data!.data()!.keys.toList();
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CustomerFoodDetailsView(
                              id: item[keyy[index]]['name']),
                        ));
                      },
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(item[keyy[index]]['image']),
                            ),
                            const Gap(10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item[keyy[index]]['name'],
                                      style: getTitleStyle().copyWith(
                                        fontSize: 16,
                                        color: AppColors.black,
                                        fontFamily:
                                            GoogleFonts.lato().fontFamily,
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
                                    onPressed: () {
                                      deleteItemFromFav(
                                          item[keyy[index]]['name']);
                                      showErrorDialog(
                                          context,
                                          'Removed from your favourite successfully',
                                          AppColors.color2);
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color: AppColors.redColor,
                                    )),
                              ],
                            ),
                            const Gap(10)
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Gap(15),
                ),
              );
            }
          }),
    );
  }

  deleteItemFromFav(item) {
    FirebaseFirestore.instance.collection('favourite-list').doc(user?.uid).set({
      item: FieldValue.delete(),
    }, SetOptions(merge: true));
  }
}
