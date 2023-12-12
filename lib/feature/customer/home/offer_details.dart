import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';
import 'package:yomnista/core/widgets/custom_button.dart';
import 'package:yomnista/core/widgets/custom_error.dart';

class CustomerOfferDetailsView extends StatefulWidget {
  const CustomerOfferDetailsView({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<CustomerOfferDetailsView> createState() =>
      _CustomerOfferDetailsViewState();
}

class _CustomerOfferDetailsViewState extends State<CustomerOfferDetailsView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _message = TextEditingController();
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  int quantity = 1;
  int rate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackAction(),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('offer-list')
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
                          borderRadius: BorderRadius.circular(25),
                          color: AppColors.color2),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.network(
                              itemData!['image'],
                              height: 250,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
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
                                heroTag: 'add',
                                mini: true,
                                backgroundColor: AppColors.scaffoldBG,
                                shape: const CircleBorder(),
                                elevation: .7,
                                onPressed: () {
                                  if (quantity > 0) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.color1,
                                ),
                              ),
                              const Gap(5),
                              Text(
                                quantity.toString(),
                                style: getTitleStyle(
                                    fontSize: 18,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Gap(5),
                              FloatingActionButton(
                                heroTag: 'remove',
                                mini: true,
                                backgroundColor: AppColors.color1,
                                shape: const CircleBorder(),
                                elevation: .7,
                                onPressed: () {
                                  setState(() {
                                    quantity++;
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
                    if (itemData['description'] != '')
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
                          'EGP ${itemData['price'].toString()}',
                          style: getTitleStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 16),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            addToCart(
                              pName: itemData['name'],
                              pImage: itemData['image'],
                              quantity: quantity,
                              total: (quantity *
                                      double.parse(
                                          itemData['price'].toString()))
                                  .toDouble(),
                              price: itemData['price'].toDouble(),
                            );
                            showErrorDialog(context,
                                'Added To Cart successfully', AppColors.color2);
                            Navigator.pop(context);
                          },
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
                    ExpansionTile(
                      collapsedBackgroundColor: AppColors.color3,
                      collapsedIconColor: AppColors.color2,
                      backgroundColor: Colors.transparent,
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      childrenPadding: const EdgeInsets.symmetric(vertical: 10),
                      subtitle: Text(
                        'Send Your Feedback Now',
                        style: getsmallStyle(),
                      ),
                      title: Text(
                        'Review',
                        style: getTitleStyle(fontSize: 16),
                      ),
                      children: [
                        TextFormField(
                          controller: _message,
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
                                  onTap: () {
                                    setState(() {
                                      rate = index + 1;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      (rate <= index)
                                          ? Icons.star_border_purple500_sharp
                                          : Icons.star_purple500_sharp,
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
                              onTap: () {
                                String date =
                                    DateFormat.yMMMMd().format(DateTime.now());
                                String time = DateFormat('hh:mm:ss a')
                                    .format(DateTime.now());
                                updateFoodRate(itemData['name'], rate,
                                    itemData['rate_num'], itemData['rate_sum']);
                                addToReport(
                                    message: _message.text,
                                    rate: rate,
                                    time: time,
                                    date: date,
                                    customeId: user!.uid);
                                _message.text = '';
                                showErrorDialog(
                                    context,
                                    'Your Review sent Successfully',
                                    AppColors.color2);
                              },
                            )
                          ],
                        ),
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
    required int quantity,
    required double total,
    required double price,
  }) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('cart-list')
        .doc(user?.uid)
        .get();
    double oldTotal = 0.0;
    if (doc.exists) {
      Map<String, dynamic> productData = doc.data() as Map<String, dynamic>;
      oldTotal = (productData['total'] ?? 0.0);
    }

    FirebaseFirestore.instance.collection('cart-list').doc(user?.uid).set({
      pName: {
        'p_name': pName,
        'quantity': quantity,
        'p_image': pImage,
        'total': total,
        'price': price,
      },
      'total': total + oldTotal
    }, SetOptions(merge: true));
  }

  updateFoodRate(String foodId, int rate, int rateNum, int oldRate) {
    FirebaseFirestore.instance.collection('offer-list').doc(foodId).set({
      'rate_sum': oldRate + rate,
      'rate_num': (rateNum == 0) ? (rateNum + 2) : (rateNum + 1),
      'rate': (oldRate + rate) ~/ (rateNum + 1)
    }, SetOptions(merge: true));
  }

  addToReport({
    required String message,
    required int rate,
    required String time,
    required String date,
    required String customeId,
  }) {
    FirebaseFirestore.instance.collection('reports-list').doc().set({
      'message': message,
      'rate': rate,
      'time': time,
      'date': date,
      'customeId': customeId,
    }, SetOptions(merge: true));
  }
}
