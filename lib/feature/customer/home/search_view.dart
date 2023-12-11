import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchView();
}

class _SearchView extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackAction(),
        toolbarHeight: 100,
        backgroundColor: AppColors.scaffoldBG,
        title: Row(
          children: [
            Expanded(
                child: TextFormField(
              onTap: () {},
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
                onPressed: () {},
                icon: Icon(
                  Icons.filter_list_rounded,
                  color: AppColors.color1,
                  size: 30,
                )),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                flex: 3,
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
                                    'EGP 125',
                                    style: getTitleStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      '50% OFF',
                                      style: getsmallStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(
                                flex: 2,
                              ),
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
