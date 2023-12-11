import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yomnista/core/utils/app_colors.dart';
import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:yomnista/core/widgets/custom_back_action.dart';

class ManagerReportedView extends StatefulWidget {
  const ManagerReportedView({
    super.key,
  });
  @override
  State<ManagerReportedView> createState() => _ManagerReportedViewState();
}

class _ManagerReportedViewState extends State<ManagerReportedView> {
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

  String name = '';
  String image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        leading: const CustomBackAction(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('reports-list')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.feedback_rounded,
                        size: 150,
                        color: AppColors.color3,
                      ),
                      const Gap(20),
                      Text(
                        'No Reports have been added yet.',
                        textAlign: TextAlign.center,
                        style: getbodyStyle(
                          fontSize: 16,
                          color: AppColors.color1,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot item = snapshot.data!.docs[index];
                  return ReportCard(item: item, id: item['customeId']);
                },
              );
            }),
      ),
    );
  }
}

class ReportCard extends StatefulWidget {
  const ReportCard({
    super.key,
    required this.item,
    required this.id,
  });
  final String id;
  final DocumentSnapshot item;

  @override
  State<ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> {
  @override
  void initState() {
    super.initState();
    getDataUser(widget.id);
  }

  String name = '';
  String image = '';
  getDataUser(id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    if (doc.exists) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      setState(() {
        name = data['fname'] + ' ' + data['lname'];
        image = data['image'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
      ),
      width: MediaQuery.sizeOf(context).width * .9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.color2,
                  radius: 20,
                  backgroundImage: NetworkImage(
                    image,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: getTitleStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.item['date']}',
                            style: GoogleFonts.lato(fontSize: 12),
                          ),
                          const Gap(10),
                          Text(
                            '${widget.item['time']}',
                            style: GoogleFonts.lato(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item['message'],
                  style: getTitleStyle(
                      color: const Color(0xff5357B6),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                const Gap(10),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      (widget.item['rate'] <= index)
                          ? Icons.star_border_purple500_sharp
                          : Icons.star_purple500_sharp,
                      color: AppColors.color1,
                      size: 22,
                    ),
                  ).toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
