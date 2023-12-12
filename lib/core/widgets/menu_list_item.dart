import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/feature/customer/home/offer_details.dart';
import 'package:yomnista/feature/customer/menu/details_view.dart';

class MenuListItems extends StatelessWidget {
  const MenuListItems({
    super.key,
    required this.data,
    this.isOffer = false,
  });
  final bool isOffer;
  final QuerySnapshot<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(10),
        Expanded(
            child: ListView.builder(
          itemCount: data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot item = data.docs[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => isOffer
                      ? CustomerOfferDetailsView(id: item['id'])
                      : CustomerFoodDetailsView(id: item['id']),
                ));
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.color3,
                ),
                height: 300,
                width: MediaQuery.sizeOf(context).width * .9,
                child: Stack(alignment: Alignment.topCenter, children: [
                  Column(
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          color: AppColors.color3,
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(
                              flex: 3,
                            ),
                            Text(
                              item['name'],
                              style: getTitleStyle(
                                  color: AppColors.color1,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16),
                            ),
                            const SizedBox(height: 5),
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
                                if ((item['offer_persent']) != 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: AppColors.color2,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      '${(item['offer_persent'])}% OFF',
                                      style: getsmallStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                              ],
                            ),
                            const Gap(10),
                            if (item['description'] != '')
                              Text(
                                item['description'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getTitleStyle(
                                    color: AppColors.black, fontSize: 12),
                              ),
                            const Gap(10),
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
                              ],
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CircleAvatar(
                      backgroundColor: AppColors.color2,
                      radius: 70,
                      backgroundImage: NetworkImage(
                        item['image'],
                      ),
                    ),
                  ),
                ]),
              ),
            );
          },
        )),
      ],
    );
  }
}
