import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';
import 'package:yomnista/core/widgets/menu_list_item.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchView();
}

class _SearchView extends State<SearchView> {
  String keyy = '';
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
              onChanged: (value) {
                setState(() {
                  keyy = value;
                });
              },
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('menu-list')
                .orderBy('name')
                .startAt([keyy]).endAt(['$keyy\uf8ff']).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Expanded(child: MenuListItems(data: snapshot.data!));
            }),
      ),
    );
  }
}
