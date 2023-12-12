import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_button.dart';

class AdminSalaryView extends StatefulWidget {
  const AdminSalaryView({super.key});

  @override
  _AdminSalaryViewState createState() => _AdminSalaryViewState();
}

class _AdminSalaryViewState extends State<AdminSalaryView> {
  @override
  void initState() {
    super.initState();
  }

  bool isShow = false;
  double total = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBG,
        // title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('order-list').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              total = 0;
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                total += snapshot.data!.docs[i]['total'];
              }
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.color1,
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              image: AssetImage('assets/cart-bg.png'))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Total Balance',
                                style: getbodyStyle(
                                    color: AppColors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isShow = !isShow;
                                    });
                                  },
                                  icon: Icon(
                                    isShow
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off,
                                    color: AppColors.color2,
                                  ))
                            ],
                          ),
                          // const Gap(10),
                          Row(
                            children: [
                              Text(
                                '  EGP',
                                style: getbodyStyle(
                                    color: AppColors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Gap(10),
                              Text(
                                isShow ? total.toString() : '',
                                style: getbodyStyle(
                                    color: AppColors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const Gap(20),
                          CustomButton(
                            onTap: () {
                              // FirebaseFirestore.instance
                              //     .collection('offer-list')
                              //     .doc('Yomnista Combo')
                              //     .set({
                              //   'id': 'Yomnista Combo',
                              //   'name': 'Yomnista Combo',
                              //   'image': '',
                              //   'description':
                              //       'Buy Italian Pizza Get one free !',
                              //   'price': 420,
                              //   'is_offer': true,
                              //   'offer_persent': 50,
                              //   'rate': 4,
                              //   'rate_num': 0,
                              //   'rate_sum': 4,
                              // }, SetOptions(merge: true));
                            },
                            text: 'SHOW DETAILS',
                            color: AppColors.white,
                            style: getbodyStyle(
                                color: AppColors.color1, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const Gap(15),
                    Row(
                      children: [
                        Text(
                          'Recent Transaction',
                          style: getbodyStyle(fontSize: 24),
                        ),
                      ],
                    ),
                    const Gap(20),
                    const Expanded(
                      child: Column(
                        children: [
                          CardItem(
                              name: 'Base Salary', image: 'assets/coin.png'),
                          Gap(10),
                          CardItem(name: 'Bonus', image: 'assets/money2.png'),
                          Gap(10),
                          CardItem(name: 'Discount', image: 'assets/money.png'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.name,
    required this.image,
  });
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: AppColors.white,
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 18),
        child: Row(
          children: [
            Image.asset(image),
            const Gap(10),
            Text(name),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                )),
          ],
        ));
  }
}
