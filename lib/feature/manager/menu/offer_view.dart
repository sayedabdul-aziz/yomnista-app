import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';
import 'package:yomnista/core/widgets/menu_edit.dart';

class ManagerOfferView extends StatefulWidget {
  const ManagerOfferView({super.key});

  @override
  State<ManagerOfferView> createState() => _ManagerOfferViewState();
}

class _ManagerOfferViewState extends State<ManagerOfferView> {
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
        title: const Text('OFFERS'),
        leading: const CustomBackAction(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('offer-list').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return EditMenuItems(
                data: snapshot.data!,
                isOffer: true,
              );
            }),
      ),
    );
  }
}
