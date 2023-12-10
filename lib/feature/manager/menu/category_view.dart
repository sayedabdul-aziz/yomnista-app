import 'package:borcelle_restaurant/core/widgets/custom_back_action.dart';
import 'package:borcelle_restaurant/core/widgets/menu_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ManagerCategoryMenuView extends StatefulWidget {
  const ManagerCategoryMenuView({super.key, required this.category});
  final String category;
  @override
  State<ManagerCategoryMenuView> createState() =>
      _ManagerCategoryMenuViewState();
}

class _ManagerCategoryMenuViewState extends State<ManagerCategoryMenuView> {
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
        title: Text(widget.category),
        leading: const CustomBackAction(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('menu-list')
                .where('category', isEqualTo: widget.category)
                .orderBy('rate', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return EditMenuItems(data: snapshot.data!);
            }),
      ),
    );
  }
}
