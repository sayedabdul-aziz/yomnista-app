import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_button.dart';

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

  double totalSalary = 0;
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
            } else if (snapshot.data?.data() == null ||
                snapshot.data!.data()?['total'] == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout_rounded,
                      size: 150,
                      color: AppColors.color3,
                    ),
                    const Gap(20),
                    Text(
                      'No Items in your cart\nOpen Menu and add to your cart',
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
              double allTotal = snapshot.data!.data()!['total'];
              List<String> keyy = snapshot.data!
                  .data()!
                  .keys
                  .where((e) => e != 'total')
                  .toList();
              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView.separated(
                          itemCount: snapshot.data!.data()!.length - 1,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> item =
                                snapshot.data!.data()![keyy[index]];

                            return Container(
                              height: 100,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor: AppColors.color2,
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
                                          onPressed: () {
                                            deleteItemFromCart(keyy[index],
                                                item['total'], allTotal);
                                          },
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
                                  const Gap(20)
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Gap(15),
                        ),
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          const Text('Total : '),
                          Text('EGP ${allTotal.toString()}',
                              style: getTitleStyle()),
                          const Spacer(),
                          CustomButton(
                            text: 'Checkout',
                            width: 150,
                            radius: 20,
                            onTap: () {
                              String date =
                                  DateFormat.MMMMd().format(DateTime.now());
                              String time = DateFormat('hh:mm:ss a')
                                  .format(DateTime.now());
                              checkoutTheOrder(
                                  date: date,
                                  time: time,
                                  customerId: user!.uid);
                            },
                          ),
                        ],
                      )
                    ],
                  ));
            }
          }),
    );
  }

  deleteItemFromCart(item, itemTotal, total) {
    FirebaseFirestore.instance.collection('cart-list').doc(user?.uid).set({
      item: FieldValue.delete(),
      'total': total - itemTotal,
    }, SetOptions(merge: true));
  }

  checkoutTheOrder({
    required String date,
    required String time,
    required String customerId,
  }) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('cart-list')
        .doc(user?.uid)
        .get();

    Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
    List<String> keyy = productData.keys.where((e) => e != 'total').toList();
    for (int i = 0; i < keyy.length; i++) {
      FirebaseFirestore.instance
          .collection('order-list')
          .doc(customerId + time)
          .set({
        keyy[i]: productData[keyy[i]],
      }, SetOptions(merge: true));
    }

    FirebaseFirestore.instance
        .collection('order-list')
        .doc(customerId + time)
        .set({
      'total': productData['total'],
      'customerId': customerId,
      'date': date,
      'time': time,
      'delivered': true,
    }, SetOptions(merge: true));
    FirebaseFirestore.instance.collection('cart-list').doc(user?.uid).delete();
  }
}
