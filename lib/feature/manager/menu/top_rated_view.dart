import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';
import 'package:yomnista/core/widgets/menu_edit.dart';

class ManagerTopRatedView extends StatefulWidget {
  const ManagerTopRatedView({super.key});

  @override
  State<ManagerTopRatedView> createState() => _ManagerTopRatedViewState();
}

class _ManagerTopRatedViewState extends State<ManagerTopRatedView> {
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
        title: const Text('TOP RATED'),
        leading: const CustomBackAction(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
