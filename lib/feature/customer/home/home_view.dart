import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/core/utils/app_text_styles.dart';
import 'package:borcelle_restaurant/feature/customer/home/favourite_view.dart';
import 'package:borcelle_restaurant/feature/customer/home/search_view.dart';
import 'package:borcelle_restaurant/feature/customer/menu/menu_view.dart';
import 'package:borcelle_restaurant/feature/customer/menu/offer_view.dart';
import 'package:borcelle_restaurant/feature/customer/menu/sales_view.dart';
import 'package:flutter/material.dart';

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
            IconButton(
                onPressed: () {
                  // FirebaseFirestore.instance
                  //     .collection('menu-list')
                  //     .doc('Margherita')
                  //     .set({
                  //   'id': 'Margherita',
                  //   'name': 'Margherita',
                  //   'image': null,
                  //   'category': 'Pizza',
                  //   'description': 'Pizza Sauce & Mozzarella',
                  //   'price': 250,
                  //   'is_offer': false,
                  //   'offer_persent': 0,
                  //   'rate': 4,
                  //   'rate_num': 0,
                  //   'rate_sum': 4,
                  // }, SetOptions(merge: true));
                },
                icon: Icon(
                  Icons.filter_list_rounded,
                  color: AppColors.color1,
                  size: 30,
                )),
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
                child: ListView.builder(
              itemCount: 2,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20, top: 20),
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
                          Image.asset(
                            'assets/food.png',
                            height: 150,
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
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Strawberry Waffle',
                              style: getTitleStyle(
                                  color: AppColors.color1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Text(
                                  'EGP 250',
                                  style: getTitleStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'EGP 250',
                                  style: getTitleStyle(
                                          color:
                                              AppColors.black.withOpacity(.5),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 12)
                                      .copyWith(
                                          decorationColor:
                                              AppColors.black.withOpacity(.5),
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: AppColors.color2,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    '10% OFF',
                                    style: getsmallStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Choose an option, Single, Double. Clear. Strawberry Waffle.',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: getTitleStyle(
                                  color: AppColors.black.withOpacity(.7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            const SizedBox(height: 20),
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
                                  '5.0(34)',
                                  style: getTitleStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: AppColors.color2,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'ADD TO CART',
                                    style: getsmallStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
