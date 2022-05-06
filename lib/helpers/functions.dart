import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loantrack/apps/widgets/newsdetail.dart';
import 'package:loantrack/data/database.dart';
import 'package:loantrack/helpers/common_widgets.dart';

import '../apps/widgets/blogdetail.dart';
import '../apps/widgets/loan_detail.dart';
import '../widgets/bulleted_list.dart';
import 'colors.dart';

Container LoanList(
    {required double width,
    required double height,
    int? numberOfItems,
    required String userId}) {
  return Container(
    width: width,
    height: height,
    child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('loans')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ));
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No data',
                style: TextStyle(
                    fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
              ),
            );
          }
          return ListView.builder(
              //padding: const EdgeInsets.only(bottom: 10),
              itemCount: (numberOfItems != null &&
                      numberOfItems > 0 &&
                      numberOfItems <= snapshot.data!.docs.length)
                  ? numberOfItems
                  : snapshot.data?.docs.length,
              //controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                double progress =
                    document.get('amountRepaid') / document.get('loanAmount');
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoanDetail(
                                  document: document,
                                )));
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            width: width * height,
                            height: 1.5,
                            decoration: BoxDecoration(
                              color: (progress >= 0.5)
                                  ? LoanTrackColors.PrimaryOneLight
                                  : LoanTrackColors.PrimaryTwoVeryLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            width: width * progress,
                            height: 1.5,
                            decoration: BoxDecoration(
                              color: (progress >= 0.5)
                                  ? LoanTrackColors.PrimaryOne
                                  : LoanTrackColors.PrimaryTwoLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ]),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .65,
                              child: Text(
                                snapshot.data!.docs[index]
                                        .get('lender')
                                        .toUpperCase() +
                                    ' | LOAN: ' +
                                    snapshot.data!.docs[index]
                                        .get('loanAmount')
                                        .toString() +
                                    ' | REPAID: ' +
                                    snapshot.data!.docs[index]
                                        .get('amountRepaid')
                                        .toString(),
                                style: const TextStyle(
                                    color: LoanTrackColors.PrimaryTwoLight,
                                    fontSize: 12),
                                softWrap: true,
                              ),
                            ),
                            (progress >= 1)
                                ? const Text(
                                    'PAID',
                                    style: TextStyle(
                                        color: LoanTrackColors.PrimaryOne,
                                        fontSize: 12),
                                  )
                                : (progress == 0)
                                    ? const Text('UNPAID',
                                        style: TextStyle(
                                            color:
                                                LoanTrackColors.PrimaryTwoLight,
                                            fontSize: 12),
                                        softWrap: true)
                                    : Text(
                                        snapshot.data!.docs[index]
                                            .get('lastPaidWhen'),
                                        style: const TextStyle(
                                            color:
                                                LoanTrackColors.PrimaryTwoLight,
                                            fontSize: 12),
                                        softWrap: true),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        }),
  );
}

Container LoanBulletedList(
    {required double height, int? numberOfItems, required String userId}) {
  ScrollController _controller = ScrollController();
  return Container(
    height: height,
    padding: EdgeInsets.only(bottom: 5),
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('loans')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: const Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
          );

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
          );
        }

        return ListView.builder(
            itemCount: (numberOfItems != null &&
                    numberOfItems > 0 &&
                    numberOfItems <= snapshot.data!.docs.length)
                ? numberOfItems
                : snapshot.data?.docs.length, //snapshot.data!.docs.length,
            controller: _controller,
            itemBuilder: (_, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];

              DateTime dueWhen =
                  DateTime.parse(document.get('dueWhen').toString());
              Duration duration = DateTime.now().difference(dueWhen);
              int due = duration.inDays;

              if (snapshot.data!.docs[index].get('userId') ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoanDetail(
                              document: snapshot.data!.docs[index]);
                        }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            //width: MediaQuery.of(context).size.width * .4,

                            child: BulletedList(
                              text:
                                  '${snapshot.data!.docs[index].get('lender').toUpperCase()} - ${((snapshot.data!.docs[index].get('loanAmount') - document.get('amountRepaid') + (due * document.get('dailyOverdueCharge')))).toString()}',
                              style: const TextStyle(
                                  color: LoanTrackColors2.PrimaryOne),
                            ),
                          ),
                          (due > 0)
                              ? Text('${due} DAYS OVERDUE',
                                  style: TextStyle(
                                      color: LoanTrackColors2.PrimaryOne))
                              : (due == 0)
                                  ? const Text('DUE TODAY',
                                      style: TextStyle(
                                          color: LoanTrackColors2.PrimaryOne))
                                  : const Text('',
                                      style: TextStyle(
                                          color: LoanTrackColors2.PrimaryOne))
                        ],
                      ),
                    ));
              }
              return const SizedBox(height: 0);
            });
      },
    ),
  );
}

Container RepaymentBulletedList(
    {required double height, int? numberOfItems, required String userId}) {
  ScrollController _controller = ScrollController();
  return Container(
    height: height,
    padding: const EdgeInsets.only(bottom: 5),
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('repayments')
          .where('userId', isEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            'No data',
            style: TextStyle(
                fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
          ));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
          );
        }

        return ListView.builder(
            itemCount: (numberOfItems != null &&
                    numberOfItems > 0 &&
                    numberOfItems <= snapshot.data!.docs.length)
                ? numberOfItems
                : snapshot.data?.docs.length, //snapshot.data!.docs.length,
            controller: _controller,
            itemBuilder: (_, index) {
              DocumentSnapshot document = snapshot.data!.docs[index];

              if (document.get('userId') ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return Container(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return LoanDetail(document: document.get('loanId'));
                        // }));
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: BulletedList(
                                  text: document
                                      .get('amountRepaid')
                                      .toString()
                                      .toUpperCase(),
                                  style: const TextStyle(
                                      color: LoanTrackColors.PrimaryOne),
                                ),
                              ),
                              Text(document.get('dateOfRepayment').toString(),
                                  style: const TextStyle(
                                      color: LoanTrackColors.PrimaryOne)),
                              GestureDetector(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('repayments')
                                        .doc(document.id)
                                        .delete();
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                  ))
                            ],
                          ),
                          (index < snapshot.data!.docs.length - 1 ||
                                  (numberOfItems != null &&
                                      index < numberOfItems - 1))
                              ? separatorLine
                              : const SizedBox(height: 0),
                        ],
                      ),
                    ));
              }
              return const SizedBox(height: 0);
            });
      },
    ),
  );
}

Container BlogList({required double height}) {
  ScrollController controller = ScrollController();
  DatabaseService db = DatabaseService();
  return Container(
    height: height,
    child: StreamBuilder<QuerySnapshot>(
      stream: db.blog.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            'No data',
            style: TextStyle(
                fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
          ));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
          );
        }
        return ListView.builder(
            itemCount: (snapshot.hasData) ? snapshot.data!.docs.length : 0,
            controller: controller,
            itemBuilder: (context, index) {
              DocumentSnapshot blogDocument = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlogDetail(
                              blog: blogDocument,
                            )),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //decoration: BoxDecoration(color: Colors.white, boxShadow: []),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: double
                            .infinity, //MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.height / 5.8,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  blogDocument.get('featuredImage')),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        width: MediaQuery.of(context).size.width / 1.87,
                        height: double
                            .infinity, //MediaQuery.of(context).size.height / 8,
                        decoration: BoxDecoration(
                          color:
                              LoanTrackColors.PrimaryTwoVeryLight.withOpacity(
                                  .1),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                blogDocument.get('title').toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: LoanTrackColors.PrimaryOne.withOpacity(
                                      .9),
                                ),
                              ),
                              separatorSpace5,
                              Text(
                                  blogDocument
                                          .get('content')
                                          .toString()
                                          .substring(0, 60) +
                                      '...',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                  ),
                                  softWrap: true),
                              separatorSpace5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    blogDocument
                                        .get('category')
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color:
                                          LoanTrackColors.PrimaryTwoVeryLight,
                                    ),
                                  ),
                                  Text(
                                    blogDocument
                                        .get('whenPublished')
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: LoanTrackColors
                                            .PrimaryTwoVeryLight),
                                  ),
                                ],
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    ),
  );
}

Container NewsList({required double height}) {
  ScrollController controller = ScrollController();
  DatabaseService db = DatabaseService();
  return Container(
    height: height,
    child: StreamBuilder<QuerySnapshot>(
      stream: db.news.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            'No data',
            style: TextStyle(
                fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
          ));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No data',
              style: TextStyle(
                  fontSize: 14, color: LoanTrackColors.PrimaryTwoVeryLight),
            ),
          );
        }
        return ListView.builder(
            itemCount: (snapshot.hasData) ? snapshot.data!.docs.length : 0,
            controller: controller,
            itemBuilder: (context, index) {
              DocumentSnapshot newsDocument = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetail(
                              news: newsDocument,
                            )),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //decoration: BoxDecoration(color: Colors.white, boxShadow: []),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: double
                            .infinity, //MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.height / 5.8,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            image: DecorationImage(
                              image: NetworkImage(
                                  newsDocument.get('featuredImage')),
                              fit: BoxFit.cover,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        width: MediaQuery.of(context).size.width / 1.87,
                        height: double
                            .infinity, //MediaQuery.of(context).size.height / 8,
                        decoration: BoxDecoration(
                          color:
                              LoanTrackColors.PrimaryTwoVeryLight.withOpacity(
                                  .1),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                newsDocument.get('title').toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      LoanTrackColors2.PrimaryOne.withOpacity(
                                          .9),
                                ),
                              ),
                              separatorSpace5,
                              Text(
                                  newsDocument
                                          .get('excerpt')
                                          .toString()
                                          .substring(0, 60) +
                                      '...',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: LoanTrackColors.PrimaryTwoVeryLight,
                                  ),
                                  softWrap: true),
                              separatorSpace5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    newsDocument
                                        .get('source')
                                        .toString()
                                        .toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color:
                                          LoanTrackColors.PrimaryTwoVeryLight,
                                    ),
                                  ),
                                  Text(
                                    newsDocument
                                        .get('whenPublished')
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: LoanTrackColors
                                            .PrimaryTwoVeryLight),
                                  ),
                                ],
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              );
            });
      },
    ),
  );
}
