import 'package:borcelle_restaurant/core/widgets/custom_back_action.dart';
import 'package:borcelle_restaurant/core/widgets/menu_list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerSalesView extends StatefulWidget {
  const CustomerSalesView({super.key});

  @override
  State<CustomerSalesView> createState() => _CustomerSalesViewState();
}

class _CustomerSalesViewState extends State<CustomerSalesView> {
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
        title: const Text('SALES'),
        leading: const CustomBackAction(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('menu-list')
                .where('is_offer', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return MenuListItems(data: snapshot.data!);
            }),
      ),
    );
  }
}
