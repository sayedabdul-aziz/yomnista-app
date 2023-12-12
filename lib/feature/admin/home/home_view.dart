import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/order_card_clip.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('order-list')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty ||
                    snapshot.data!.docs[0]['total'] == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.remove_shopping_cart,
                          size: 150,
                          color: AppColors.color3,
                        ),
                        const Gap(20),
                        Text(
                          'No orders have been added yet.',
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
                  return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return OrderCartWidget(
                        data: snapshot.data!.docs[index],
                      );
                    },
                    separatorBuilder: (context, index) => const Gap(15),
                  );
                }
              })),
    );
  }
}

class OrderCartWidget extends StatefulWidget {
  const OrderCartWidget({
    super.key,
    required this.data,
  });

  final QueryDocumentSnapshot data;

  @override
  State<OrderCartWidget> createState() => _OrderCartWidgetState();
}

class _OrderCartWidgetState extends State<OrderCartWidget> {
  @override
  void initState() {
    super.initState();
    getDataUser(widget.data['customerId']);
    getItemsInOrder();
  }

  String name = '';
  String? image;
  List<String> keyy = [];
  getItemsInOrder() {
    Map<String, dynamic> productData =
        widget.data.data() as Map<String, dynamic>;
    keyy = productData.keys.where((element) {
      if (element == 'total' ||
          element == 'customerId' ||
          element == 'time' ||
          element == 'delivered' ||
          element == 'date') {
        return false;
      }
      return true;
    }).toList();
  }

  getDataUser(id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      setState(() {
        name = data['fname'] + ' ' + data['lname'];
        image = data['image'];
      });
    }
  }

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
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              for (int i = 0; i < keyy.length; i++) ...{
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.data[keyy[i]]['p_name'],
                                        style: getbodyStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Gap(3),
                                    Text(
                                      'x${widget.data[keyy[i]]['quantity']}',
                                      style: getbodyStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              },
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.done,
                                    size: 18,
                                    color: AppColors.white,
                                  ),
                                  Text(
                                    'Delivered',
                                    style: getbodyStyle(
                                      color: AppColors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      updateData();
                                    },
                                    child: Ink(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.done_all_rounded,
                                            size: 18,
                                            color: widget.data['delivered']
                                                ? AppColors.color1
                                                : AppColors.white,
                                          ),
                                          Text(
                                            'Delivered',
                                            style: getbodyStyle(
                                              color: widget.data['delivered']
                                                  ? AppColors.color1
                                                  : AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                  backgroundImage: (image != null)
                                      ? NetworkImage(image!) as ImageProvider
                                      : const AssetImage('assets/user.png'),
                                ),
                                Text(name),
                              ],
                            ),
                            const Gap(10),
                            Text(
                              widget.data['date'],
                              style: getbodyStyle().copyWith(
                                  fontSize: 16,
                                  fontFamily:
                                      GoogleFonts.courierPrime().fontFamily),
                            ),
                            Text(
                              widget.data['time'],
                              style: getbodyStyle().copyWith(
                                  fontSize: 16,
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

  Future<void> updateData() async {
    FirebaseFirestore.instance
        .collection('order-list')
        .doc(widget.data['customerId'] + widget.data['time'])
        .set({
      'delivered': true,
    }, SetOptions(merge: true));
  }
}
