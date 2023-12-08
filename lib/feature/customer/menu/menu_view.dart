import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:borcelle_restaurant/core/utils/app_text_styles.dart';
import 'package:borcelle_restaurant/core/widgets/custom_back_action.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomerMenuView extends StatefulWidget {
  const CustomerMenuView({super.key});

  @override
  State<CustomerMenuView> createState() => _CustomerMenuViewState();
}

class _CustomerMenuViewState extends State<CustomerMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MENU'),
        leading: const CustomBackAction(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories',
              textAlign: TextAlign.center,
              style: getTitleStyle(
                  color: AppColors.color1,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
            const Gap(10),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              decoration:
                                  BoxDecoration(color: AppColors.color2),
                              child: Image.asset('assets/burger.png'),
                            ),
                            const Gap(5),
                            Text(
                              'Burger',
                              style: getsmallStyle(
                                  color: AppColors.color1,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                ),
                const Gap(5),
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(color: AppColors.color3),
                            child: Image.asset('assets/pizza.png'),
                          ),
                          const Gap(5),
                          Text(
                            'Pizza',
                            style: getsmallStyle(
                                color: AppColors.color1,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ),
                const Gap(5),
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(color: AppColors.color2),
                            child: Image.asset('assets/dish.png'),
                          ),
                          const Gap(5),
                          Text(
                            'Dishes',
                            style: getsmallStyle(
                                color: AppColors.color1,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ),
                const Gap(5),
                // Expanded(
                //   child: InkWell(
                //       onTap: () {},
                //       child: Container(
                //         height: 50,
                //         decoration: BoxDecoration(color: AppColors.color3),
                //         child: Image.asset('assets/Cup.png'),
                //       )),
                // ),
                // const Gap(5),
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(color: AppColors.color3),
                            child: Image.asset('assets/juice.png'),
                          ),
                          const Gap(5),
                          Text(
                            'Drinks',
                            style: getsmallStyle(
                                color: AppColors.color1,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ),
                const Gap(5),
                Expanded(
                  child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(color: AppColors.color2),
                            child: Image.asset('assets/cake.png'),
                          ),
                          const Gap(5),
                          Text(
                            'Dessert',
                            style: getsmallStyle(
                                color: AppColors.color1,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )),
                ),
              ],
            ),
            const Gap(20),
            Text(
              'Suggests',
              textAlign: TextAlign.center,
              style: getTitleStyle(
                  color: AppColors.color1,
                  fontWeight: FontWeight.w900,
                  fontSize: 18),
            ),
            const Gap(10),
            Expanded(
                child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
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
                                flex: 2,
                              ),
                              Text(
                                'Strawberry Waffle',
                                style: getTitleStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'EGP 250',
                                    style: getTitleStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14),
                                  ),
                                  // const SizedBox(
                                  //   width: 5,
                                  // ),
                                  // Text(
                                  //   'EGP 250',
                                  //   style: getTitleStyle(
                                  //           color:
                                  //               AppColors.black.withOpacity(.5),
                                  //           fontWeight: FontWeight.w800,
                                  //           fontSize: 12)
                                  //       .copyWith(
                                  //           decorationColor:
                                  //               AppColors.black.withOpacity(.5),
                                  //           decoration:
                                  //               TextDecoration.lineThrough),
                                  // ),
                                  // const Spacer(),
                                  // Container(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 7, vertical: 3),
                                  //   decoration: BoxDecoration(
                                  //       color: AppColors.color2,
                                  //       borderRadius: BorderRadius.circular(20)),
                                  //   child: Text(
                                  //     '10% OFF',
                                  //     style: getsmallStyle(
                                  //         color: AppColors.white,
                                  //         fontWeight: FontWeight.bold),
                                  //   ),
                                  // )
                                ],
                              ),
                              const Spacer(),
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
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.color2,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      'ADD TO CART',
                                      style: getsmallStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                            ],
                          ),
                        ))
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/food1.png'),
                      ),
                    ),
                  ]),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
