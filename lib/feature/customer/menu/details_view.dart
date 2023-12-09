import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/core/utils/app_text_styles.dart';
import 'package:borcelle_restaurant/core/widgets/custom_back_action.dart';
import 'package:borcelle_restaurant/core/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerFoodDetailsView extends StatefulWidget {
  const CustomerFoodDetailsView({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<CustomerFoodDetailsView> createState() =>
      _CustomerFoodDetailsViewState();
}

class _CustomerFoodDetailsViewState extends State<CustomerFoodDetailsView> {
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

  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackAction(),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('menu-list')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var itemData = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.color2),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            itemData!['image'],
                            height: 250,
                            width: double.infinity,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: CircleAvatar(
                                radius: 18,
                                backgroundColor: AppColors.white,
                                child: Icon(
                                  Icons.favorite_border_outlined,
                                  color: AppColors.color2,
                                )),
                          )
                        ],
                      ),
                    ),
                    const Gap(20),
                    Text(itemData['name'],
                        style: getTitleStyle().copyWith(
                          fontSize: 27,
                          letterSpacing: 1.5,
                          fontFamily: GoogleFonts.lato().fontFamily,
                        )),
                    const Gap(10),
                    Row(
                      children: [
                        Icon(
                          Icons.star_purple500_sharp,
                          color: AppColors.color1,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${itemData['rate']}(${itemData['rate_num']})',
                          style: getTitleStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 12),
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.color2,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              FloatingActionButton(
                                mini: true,
                                backgroundColor: AppColors.scaffoldBG,
                                shape: const CircleBorder(),
                                elevation: .7,
                                onPressed: () {
                                  setState(() {
                                    counter--;
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.color1,
                                ),
                              ),
                              const Gap(5),
                              Text(
                                counter.toString(),
                                style: getTitleStyle(
                                    fontSize: 18,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Gap(5),
                              FloatingActionButton(
                                mini: true,
                                backgroundColor: AppColors.color1,
                                shape: const CircleBorder(),
                                elevation: .7,
                                onPressed: () {
                                  setState(() {
                                    counter++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(10),
                    Text('Description',
                        style: getTitleStyle().copyWith(
                          fontFamily: GoogleFonts.lato().fontFamily,
                        )),
                    const Gap(5),
                    Text(
                      itemData['description'],
                      style:
                          getTitleStyle(color: AppColors.black, fontSize: 12),
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Text(
                          itemData['price'],
                          style: getTitleStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: AppColors.color2,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              'ADD TO CART',
                              style: getsmallStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Divider(
                      color: AppColors.color2,
                    ),
                    const Gap(10),
                    TextFormField(
                      maxLines: 3,
                      decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          fillColor: AppColors.white),
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (index) => InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Icon(
                                  Icons.star_border_purple500_sharp,
                                  color: AppColors.color1,
                                  size: 27,
                                ),
                              ),
                            ),
                          ).toList(),
                        ),
                        const Spacer(),
                        CustomButton(
                          width: 90,
                          height: 40,
                          radius: 10,
                          text: 'SEND',
                          onTap: () {},
                        )
                      ],
                    ),
                    const Gap(15),
                  ],
                ),
              ),
            );
          }),
    );
  }

  addToCart({
    required String pName,
    required String pImage,
    required String quantity,
    required double total,
    required double price,
    required String time,
    required String date,
    required String name,
    required String image,
  }) {
    FirebaseFirestore.instance.collection('cart-list').doc(user?.uid).set({
      'p_name': pName,
      'quantity': quantity,
      'p_image': pImage,
      'total': total,
      'price': price,
      'time': time,
      'date': date,
      'name': name,
      'image': image,
    }, SetOptions(merge: true));
  }

  updateFoodRate(String foodId, int rate, int oldRate) {
    FirebaseFirestore.instance.collection('menu-list').doc(foodId).set({
      'rate_sum': oldRate + rate,
      'rate_num': rate + 1,
      'rate': oldRate + rate / rate + 1
    }, SetOptions(merge: true));
  }

  addToReport({
    required String message,
    required int rate,
    required String time,
    required String date,
    required String name,
    required String image,
  }) {
    FirebaseFirestore.instance.collection('reports-list').doc(user?.uid).set({
      'message': message,
      'rate': rate,
      'time': time,
      'date': date,
      'name': name,
      'image': image,
    }, SetOptions(merge: true));
  }
}
