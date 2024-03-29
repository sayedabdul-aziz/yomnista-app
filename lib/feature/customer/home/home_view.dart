import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/feature/customer/home/favourite_view.dart';
import 'package:yomnista/feature/customer/home/offer_details.dart';
import 'package:yomnista/feature/customer/home/search_view.dart';
import 'package:yomnista/feature/customer/menu/menu_view.dart';
import 'package:yomnista/feature/customer/menu/offer_view.dart';
import 'package:yomnista/feature/customer/menu/sales_view.dart';

class CustomerHomeView extends StatefulWidget {
  const CustomerHomeView({super.key});

  @override
  State<CustomerHomeView> createState() => _CustomerHomeViewState();
}

class _CustomerHomeViewState extends State<CustomerHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.scaffoldBG,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerFavouriteView(),
                      ));
                },
                icon: Icon(
                  Icons.favorite,
                  color: AppColors.color1,
                  size: 30,
                )),
            Expanded(
                child: TextFormField(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchView(),
                    ));
              },
              readOnly: true,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search ..',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                      borderRadius: BorderRadius.circular(25)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.color2),
                      borderRadius: BorderRadius.circular(25))),
            )),
            // IconButton(
            //     onPressed: () {
            //       // FirebaseFirestore.instance
            //       //     .collection('menu-list')
            //       //     .doc('Quesadillas')
            //       //     .set({
            //       //   'id': 'Quesadillas',
            //       //   'name': 'Quesadillas',
            //       //   'image': '',
            //       //   'category': 'Dish',
            //       //   'description':
            //       //       'Chicken and Pepper Jack Quesadillas with Cilantro Slaw',
            //       //   'price': 260,
            //       //   'is_offer': false,
            //       //   'offer_persent': 0,
            //       //   'rate': 4,
            //       //   'rate_num': 0,
            //       //   'rate_sum': 4,
            //       // }, SetOptions(merge: true));
            //     },
            //     icon: Icon(
            //       Icons.filter_list_rounded,
            //       color: AppColors.color1,
            //       size: 30,
            //     )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CustomerMenuView(),
                      ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: AppColors.color2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          'Menu',
                          textAlign: TextAlign.center,
                          style: getTitleStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CustomerOfferView(),
                      ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: AppColors.color2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          'Offers',
                          textAlign: TextAlign.center,
                          style: getTitleStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CustomerSalesView(),
                      ));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: AppColors.color2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          'Sales',
                          textAlign: TextAlign.center,
                          style: getTitleStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Today’s Special',
              textAlign: TextAlign.center,
              style: getTitleStyle(
                  color: AppColors.color1,
                  fontWeight: FontWeight.w900,
                  fontSize: 28),
            ),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('offer-list')
                        .orderBy('offer_persent', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DocumentSnapshot item = snapshot.data!.docs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CustomerOfferDetailsView(id: item['id']),
                              ));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 20, right: 20, top: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.color2,
                              ),
                              height: 300,
                              width: MediaQuery.sizeOf(context).width * .7,
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        child: Image.network(
                                          item['image'],
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        Text(
                                          item['name'],
                                          style: getTitleStyle(
                                              color: AppColors.color1,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          children: [
                                            Text(
                                              'EGP ${((item['offer_persent'] != 0) ? (item['price'] * (100 - item['offer_persent']) * .01).toString() : item['price']).toString()}',
                                              style: getTitleStyle(
                                                  color: AppColors.color2,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            if ((item['offer_persent']) != 0)
                                              Text(
                                                'EGP ${item['price']}',
                                                style: getTitleStyle(
                                                        color: AppColors.black
                                                            .withOpacity(.5),
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 12)
                                                    .copyWith(
                                                        decorationColor:
                                                            AppColors.black
                                                                .withOpacity(
                                                                    .5),
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                              ),
                                            const Spacer(),
                                            if ((item['offer_persent']) != 0)
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 7,
                                                        vertical: 3),
                                                decoration: BoxDecoration(
                                                    color: AppColors.color2,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  '${(item['offer_persent'])}% OFF',
                                                  style: getsmallStyle(
                                                      color: AppColors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                          ],
                                        ),
                                        const Gap(10),
                                        if (item['description'] != '')
                                          Text(item['description'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: getTitleStyle(
                                                  color: AppColors.black
                                                      .withOpacity(.7),
                                                  fontSize: 12)),
                                        const Gap(15),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star_purple500_sharp,
                                              color: Colors.yellow,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '${item['rate']}(${item['rate_num']})',
                                              style: getTitleStyle(
                                                  color: AppColors.black,
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 12),
                                            ),
                                            const Spacer(),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: AppColors.color2,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Text(
                                                'ADD TO CART',
                                                style: getsmallStyle(
                                                    color: AppColors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
