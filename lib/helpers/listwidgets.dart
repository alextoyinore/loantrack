import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loantrack/apps/loan_record_app.dart';
import 'package:loantrack/apps/widgets/blogdetail.dart';
import 'package:loantrack/apps/widgets/button.dart';
import 'package:loantrack/apps/widgets/updateprofile.dart';
import 'package:loantrack/apps/widgets/loandetail.dart';
import 'package:loantrack/apps/widgets/newsdetail.dart';
import 'package:loantrack/data/applists.dart';
import 'package:loantrack/data/database.dart';
import 'package:loantrack/helpers/colors.dart';
import 'package:loantrack/widgets/bulleted_list.dart';
import 'package:loantrack/widgets/common_widgets.dart';
import 'package:loantrack/widgets/dialogs.dart';
import 'package:loantrack/widgets/loan_track_modal.dart';
import 'package:loantrack/widgets/loan_track_textfield.dart';

SizedBox LoanList(
    {required double width,
    required double height,
    int? numberOfItems,
    required String userId}) {
  return SizedBox(
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
                  onLongPress: () {
                    LoanTrackModal.modal(
                      context,
                      height: MediaQuery.of(context).size.height / 2.5,
                      content: Container(
                        child: Column(
                            children: List.generate(
                                AppLists.loanListOptionItem.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoanDetail(
                                                          document: document,
                                                        )));
                                            // Navigator.pop(context);
                                            break;
                                          case 1:
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoanRecord(
                                                          edit: false,
                                                          documentSnapshot:
                                                              document,
                                                        )));
                                            //Navigator.pop(context);
                                            break;
                                          case 2:
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoanRecord(
                                                          edit: true,
                                                          documentSnapshot:
                                                              document,
                                                        )));
                                            //Navigator.pop(context);
                                            break;
                                          case 3:
                                            FirebaseFirestore.instance
                                                .collection('archive')
                                                .add({
                                              'userId': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'loanId': document.id,
                                              'loanAmount':
                                                  document.get('loanAmount'),
                                              'amountRepaid':
                                                  document.get('amountRepaid'),
                                              'interestRate':
                                                  document.get('interestRate'),
                                              'dailyOverdueCharge': document
                                                  .get('dailyOverdueCharge'),
                                              'applyWhen':
                                                  document.get('applyWhen'),
                                              'dueWhen':
                                                  document.get('dueWhen'),
                                              'lastRepaidWhen':
                                                  document.get('lastPaidWhen'),
                                              'entryDate':
                                                  document.get('entryDate'),
                                              'modifiedWhen':
                                                  document.get('modifiedWhen'),
                                              'lenderType':
                                                  document.get('lenderType'),
                                              'lender': document.get('lender'),
                                              'loanPurpose':
                                                  document.get('loanPurpose'),
                                              'note': document.get('note'),
                                            }).whenComplete(
                                              () => const SnackBar(
                                                backgroundColor: LoanTrackColors
                                                    .PrimaryOneVeryLight,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                content: Text(
                                                    'Loan record archived.'),
                                              ),
                                            );
                                            // Navigator.pop(context);
                                            break;
                                          case 4:
                                            FirebaseFirestore.instance
                                                .collection('archive')
                                                .add({
                                              'userId': FirebaseAuth
                                                  .instance.currentUser!.uid,
                                              'loanId': document.id,
                                              'loanAmount':
                                                  document.get('loanAmount'),
                                              'amountRepaid':
                                                  document.get('amountRepaid'),
                                              'interestRate':
                                                  document.get('interestRate'),
                                              'dailyOverdueCharge': document
                                                  .get('dailyOverdueCharge'),
                                              'applyWhen':
                                                  document.get('applyWhen'),
                                              'dueWhen':
                                                  document.get('dueWhen'),
                                              'lastRepaidWhen':
                                                  document.get('lastPaidWhen'),
                                              'entryDate':
                                                  document.get('entryDate'),
                                              'modifiedWhen':
                                                  document.get('modifiedWhen'),
                                              'lenderType':
                                                  document.get('lenderType'),
                                              'lender': document.get('lender'),
                                              'loanPurpose':
                                                  document.get('loanPurpose'),
                                              'note': document.get('note'),
                                            }).whenComplete(
                                              () => const SnackBar(
                                                backgroundColor: LoanTrackColors
                                                    .PrimaryOneVeryLight,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                content: Text(
                                                    'Loan record archived.'),
                                              ),
                                            );
                                            FirebaseFirestore.instance
                                                .collection('loans')
                                                .doc(document.id)
                                                .delete();
                                          // Navigator.pop(context);
                                          //break;
                                        }
                                      },
                                      child: ListTile(
                                        title: Text(
                                          AppLists.loanListOptionItem[index],
                                          style: const TextStyle(
                                            color: LoanTrackColors
                                                .PrimaryTwoVeryLight,
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),
                      title: 'Options',
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          width: width * height,
                          height: 1.5,
                          decoration: BoxDecoration(
                            color: (progress >= 0.5)
                                ? LoanTrackColors.PrimaryOneLight
                                : LoanTrackColors2.PrimaryOneVeryLight,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Container(
                          width: width * progress,
                          height: 1.5,
                          decoration: BoxDecoration(
                            color: (progress >= 0.5)
                                ? LoanTrackColors.PrimaryOne
                                : LoanTrackColors2.PrimaryOne,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
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
                              style: TextStyle(
                                  color: (progress >= 1)
                                      ? LoanTrackColors.PrimaryOne
                                      : LoanTrackColors2.PrimaryOne,
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
                                          color: LoanTrackColors2.PrimaryOne,
                                          fontSize: 12),
                                      softWrap: true)
                                  : Text(
                                      snapshot.data!.docs[index]
                                          .get('lastPaidWhen'),
                                      style: const TextStyle(
                                          color: LoanTrackColors2.PrimaryOne,
                                          fontSize: 12),
                                      softWrap: true),
                        ],
                      )
                    ],
                  ),
                );
              });
        }),
  );
}

Container LoanBulletedList({
  required double height,
  int? numberOfItems,
  required String userId,
}) {
  ScrollController _controller = ScrollController();
  return Container(
    height: height,
    padding: const EdgeInsets.only(bottom: 5),
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
            ),
          );
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

              DateTime dueWhen =
                  DateTime.parse(document.get('dueWhen').toString());
              Duration duration = DateTime.now().difference(dueWhen);
              int due = duration.inDays;

              if (snapshot.data!.docs[index].get('userId') ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
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
                          BulletedList(
                            text:
                                '${snapshot.data!.docs[index].get('lender').toUpperCase()} - ${((snapshot.data!.docs[index].get('loanAmount') - document.get('amountRepaid') + (due * document.get('dailyOverdueCharge')))).toString()}',
                            style: const TextStyle(
                                color: LoanTrackColors2.PrimaryOne),
                          ),
                          (due > 0)
                              ? Text('$due DAYS OVERDUE',
                                  style: const TextStyle(
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
    {required double height,
    int? numberOfItems,
    required String userId,
    String? loanId}) {
  ScrollController _controller = ScrollController();
  return Container(
    height: height,
    padding: const EdgeInsets.only(bottom: 5),
    child: StreamBuilder<QuerySnapshot>(
      stream: (loanId != null)
          ? FirebaseFirestore.instance
              .collection('repayments')
              .where('userId', isEqualTo: userId)
              .where('loanId', isEqualTo: loanId)
              .snapshots()
          : FirebaseFirestore.instance
              .collection('repayments')
              .where('userId', isEqualTo: userId)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            'No data',
            style: TextStyle(fontSize: 14, color: LoanTrackColors.PrimaryOne),
          ));
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No data',
              style: TextStyle(fontSize: 14, color: LoanTrackColors.PrimaryOne),
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

              return Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
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
                                    .get('repaidWhen')
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: LoanTrackColors.PrimaryOne),
                              ),
                            ),
                            Text(document.get('amountRepaid').toString(),
                                style: const TextStyle(
                                    color: LoanTrackColors.PrimaryOne)),
                            GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('repayments')
                                      .doc(document.id)
                                      .delete();
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
            });
      },
    ),
  );
}

SizedBox BlogList({required double height}) {
  ScrollController controller = ScrollController();
  DatabaseService db = DatabaseService();
  return SizedBox(
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

            if (blogDocument.get('featuredImage') != null &&
                blogDocument.get('title') != null &&
                blogDocument.get('content') != null &&
                blogDocument.get('category') != null &&
                blogDocument.get('whenPublished') != null) {
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
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                        width: MediaQuery.of(context).size.width / 1.95,
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
                                          .replaceAll('<p>', '')
                                          .replaceAll('</p>', '')
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
            } else {
              return const SizedBox(height: 0);
            }
          },
        );
      },
    ),
  );
}

SizedBox NewsList({required double height}) {
  ScrollController controller = ScrollController();
  DatabaseService db = DatabaseService();
  return SizedBox(
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

            if (newsDocument.get('featuredImage') != null &&
                newsDocument.get('title') != null &&
                newsDocument.get('excerpt') != null &&
                newsDocument.get('source') != null &&
                newsDocument.get('whenPublished') != null) {
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
                        width: MediaQuery.of(context).size.width / 1.95,
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
                                  color: LoanTrackColors.PrimaryOne.withOpacity(
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
            }
            return const SizedBox(height: 0);
          },
        );
      },
    ),
  );
}

SizedBox userProfile({double? height}) {
  DatabaseService db = DatabaseService();
  return SizedBox(
    height: height,
    child: StreamBuilder<QuerySnapshot>(
        stream: db.users
            .where(
              'userId',
              isEqualTo: db.userId,
            )
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
            return Center(
              child: Column(
                children: [
                  const Text(
                    'You havent updated your profile yet.',
                    style: TextStyle(
                        fontSize: 14,
                        color: LoanTrackColors.PrimaryTwoVeryLight),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileUpdate(),
                          ));
                    },
                    child: const Text(
                      'Update your profile now',
                      style: TextStyle(
                        color: LoanTrackColors.PrimaryOne,
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data!.docs[index];

                return Column(
                  children: [
                    //Full name
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Name: ',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                            softWrap: true,
                          ),
                          Text(
                            '${user.get('firstname')} ${user.get('lastname')}',
                            style: const TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                            softWrap: true,
                          ),
                          GestureDetector(
                            onTap: () {
                              TextEditingController firstnameController =
                                  TextEditingController();
                              TextEditingController lastnameController =
                                  TextEditingController();
                              LoanTrackModal.modal(
                                context,
                                /*  height:
                                    MediaQuery.of(context).size.height / 1.2, */
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Column(
                                    children: [
                                      LoanTrackTextField(
                                          controller: firstnameController,
                                          label: 'First Name',
                                          color: LoanTrackColors
                                                  .PrimaryTwoVeryLight
                                              .withOpacity(.1)),
                                      separatorSpace10,
                                      LoanTrackTextField(
                                          controller: lastnameController,
                                          label: 'Last Name',
                                          color: LoanTrackColors
                                                  .PrimaryTwoVeryLight
                                              .withOpacity(.1)),
                                      separatorSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.id)
                                              .update({
                                                'firstname':
                                                    firstnameController.text,
                                                'lastname':
                                                    lastnameController.text,
                                              })
                                              .whenComplete(() => {
                                                    showSuccessDialog(
                                                        context: context,
                                                        title: 'Success',
                                                        successMessage:
                                                            'You have successfully updated your first name and last name',
                                                        whenTapped: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  })
                                              .onError((error, stackTrace) => {
                                                    showErrorDialog(
                                                        context: context,
                                                        title: 'Error',
                                                        errorMessage:
                                                            'An error occured while updating your first name and last name'),
                                                  });
                                          Navigator.pop(context);
                                        },
                                        child: LoanTrackButton.primary(
                                            context: context,
                                            label: 'Continue'),
                                      ),
                                    ],
                                  ),
                                ),
                                title: 'Edit Names',
                              );
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    // Age
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /*  color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Age:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('age')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              TextEditingController ageController =
                                  TextEditingController();

                              LoanTrackModal.modal(
                                context,
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
                                content: Container(
                                  child: Column(
                                    children: [
                                      LoanTrackTextField(
                                          controller: ageController,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                          label: 'Age',
                                          color: LoanTrackColors
                                                  .PrimaryTwoVeryLight
                                              .withOpacity(.1)),
                                      separatorSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.id)
                                              .update({
                                                'age': ageController.text,
                                              })
                                              .whenComplete(() => {
                                                    showSuccessDialog(
                                                        context: context,
                                                        title: 'Success',
                                                        successMessage:
                                                            'You have successfully updated your age',
                                                        whenTapped: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  })
                                              .onError((error, stackTrace) => {
                                                    showErrorDialog(
                                                        context: context,
                                                        title: 'Error',
                                                        errorMessage:
                                                            'An error occured while updating your age'),
                                                  });
                                          Navigator.pop(context);
                                        },
                                        child: LoanTrackButton.primary(
                                            context: context,
                                            label: 'Continue'),
                                      ),
                                    ],
                                  ),
                                ),
                                title: 'Edit Age',
                              );
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Gender
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Gender:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('gender')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.genders.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'gender': AppLists
                                                          .genders[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your gender detail',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Failed',
                                                              errorMessage:
                                                                  'An error occured while updating your gender details')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.genders[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Gender');
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorSpace10,

                    //Occupation
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Occupation:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('occupation')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              TextEditingController occupationController =
                                  TextEditingController();

                              LoanTrackModal.modal(
                                context,
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
                                content: Container(
                                  child: Column(
                                    children: [
                                      LoanTrackTextField(
                                          controller: occupationController,
                                          label: 'Occupation',
                                          color: LoanTrackColors
                                                  .PrimaryTwoVeryLight
                                              .withOpacity(.1)),
                                      separatorSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.id)
                                              .update({
                                                'occupation':
                                                    occupationController.text,
                                              })
                                              .whenComplete(() => {
                                                    showSuccessDialog(
                                                        context: context,
                                                        title: 'Success',
                                                        successMessage:
                                                            'You have successfully updated your occupation',
                                                        whenTapped: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  })
                                              .onError((error, stackTrace) => {
                                                    showErrorDialog(
                                                        context: context,
                                                        title: 'Error',
                                                        errorMessage:
                                                            'An error occured while updating your occupation details'),
                                                  });
                                          Navigator.pop(context);
                                        },
                                        child: LoanTrackButton.primary(
                                            context: context,
                                            label: 'Continue'),
                                      ),
                                    ],
                                  ),
                                ),
                                title: 'Edit Occupation',
                              );
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorSpace10,

                    //Industry
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Industry:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('industry')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.occupationIndustry.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'industry': AppLists
                                                              .occupationIndustry[
                                                          index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your occupation industry',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Error',
                                                              errorMessage:
                                                                  'An error occured while updating your occupation industry details')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.occupationIndustry[
                                                      index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Industry');
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorSpace10,
                    // Age
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Total Monthly Income:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('totalMonthlyIncome')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              TextEditingController monthlyController =
                                  TextEditingController();

                              LoanTrackModal.modal(
                                context,
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
                                content: Container(
                                  child: Column(
                                    children: [
                                      LoanTrackTextField(
                                          controller: monthlyController,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(),
                                          label: 'Total Monthly Income',
                                          color: LoanTrackColors
                                                  .PrimaryTwoVeryLight
                                              .withOpacity(.1)),
                                      separatorSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(user.id)
                                              .update({
                                                'totalMonthlyIncome':
                                                    monthlyController.text,
                                              })
                                              .whenComplete(() => {
                                                    showSuccessDialog(
                                                        context: context,
                                                        title: 'Success',
                                                        successMessage:
                                                            'You have successfully updated your monthly income',
                                                        whenTapped: () {
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  })
                                              .onError((error, stackTrace) => {
                                                    showErrorDialog(
                                                        context: context,
                                                        title: 'Error',
                                                        errorMessage:
                                                            'An error occured while updating your monthly income'),
                                                  });
                                          Navigator.pop(context);
                                        },
                                        child: LoanTrackButton.primary(
                                            context: context,
                                            label: 'Continue'),
                                      ),
                                    ],
                                  ),
                                ),
                                title: 'Edit MOnthly Income',
                              );
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Country of Residence
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Country of Residence:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('countryOfResidence')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.countries.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'countryOfResidence':
                                                          AppLists
                                                              .countries[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your gender detail',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Error',
                                                              errorMessage:
                                                                  'An error occured while updating your gender details')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.countries[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Residence Country');
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Gender
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'City of Residence:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('cityOfResidence')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.cities.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'cityOfResidence':
                                                          AppLists
                                                              .cities[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your city of residence',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Error',
                                                              errorMessage:
                                                                  'An error occured while updating your city of residence')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.cities[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit City');
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Nationality
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Nationality:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('nationality')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  content: Column(
                                    children: List.generate(
                                        AppLists.countries.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'nationality': AppLists
                                                          .countries[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your nationality',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Failed',
                                                              errorMessage:
                                                                  'An error occured while updating your nationality')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.countries[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Gender');
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),

                    separatorSpace10,

                    //Nationality
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 8,
                      ),
                      /* color:
                          LoanTrackColors.PrimaryTwoVeryLight.withOpacity(.1), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'I\'m a Samaritan:',
                            style: TextStyle(
                                color: LoanTrackColors.PrimaryTwoVeryLight),
                          ),
                          Text('${user.get('isSamaritan')}',
                              style: const TextStyle(
                                  color: LoanTrackColors.PrimaryTwoVeryLight)),
                          GestureDetector(
                            onTap: () {
                              LoanTrackModal.modal(context,
                                  /* height:
                                      MediaQuery.of(context).size.height / 4, */
                                  content: Column(
                                    children: List.generate(
                                        AppLists.yesNo.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user.id)
                                                    .update({
                                                      'isSamaritan':
                                                          AppLists.yesNo[index],
                                                    })
                                                    .whenComplete(() => {
                                                          showSuccessDialog(
                                                              context: context,
                                                              title: 'Success',
                                                              successMessage:
                                                                  'You have successfully updated your Samaritan status',
                                                              whenTapped: () {
                                                                Navigator.pop(
                                                                    context);
                                                              })
                                                        })
                                                    .onError((error,
                                                            stackTrace) =>
                                                        {
                                                          showErrorDialog(
                                                              context: context,
                                                              title: 'Failed',
                                                              errorMessage:
                                                                  'An error occured while updating your Samaritan status')
                                                        });

                                                Navigator.pop(context);
                                              },
                                              child: ListTile(
                                                title: Text(
                                                  AppLists.yesNo[index],
                                                  style: const TextStyle(
                                                    color: LoanTrackColors
                                                        .PrimaryTwoVeryLight,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                  title: 'Edit Samaritan Status');
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: LoanTrackColors.PrimaryTwoVeryLight
                                  .withOpacity(.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorSpace10,
                  ],
                );
              });
        }),
  );
}
