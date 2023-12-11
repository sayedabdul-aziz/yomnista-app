import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';
import 'package:yomnista/core/widgets/menu_edit.dart';
import 'package:yomnista/feature/manager/menu/category_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ManagerMenuView extends StatefulWidget {
  const ManagerMenuView({super.key});

  @override
  State<ManagerMenuView> createState() => _ManagerMenuViewState();
}

class _ManagerMenuViewState extends State<ManagerMenuView> {
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const ManagerCategoryMenuView(category: 'Burger'),
                        ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const ManagerCategoryMenuView(category: 'Pizza'),
                        ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const ManagerCategoryMenuView(category: 'Dish'),
                        ));
                      },
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
                Expanded(
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              const ManagerCategoryMenuView(category: 'Drink'),
                        ));
                      },
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
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ManagerCategoryMenuView(
                              category: 'Dessert'),
                        ));
                      },
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
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('menu-list')
                    .orderBy('rate', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(child: EditMenuItems(data: snapshot.data!));
                }),
          ],
        ),
      ),
    );
  }
}
