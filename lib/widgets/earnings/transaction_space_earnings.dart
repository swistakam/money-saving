import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_saving/services/firebase_query.dart';
import '../../themes/constans.dart';

class TransactionSpaceEarnings extends StatefulWidget {
  final double height;

  const TransactionSpaceEarnings(this.height);
  @override
  _TransactionSpaceEarningsState createState() =>
      _TransactionSpaceEarningsState();
}

class _TransactionSpaceEarningsState extends State<TransactionSpaceEarnings> {
  @override
  Widget build(BuildContext context) {
    final meadiaQuery = MediaQuery.of(context);

    return Positioned(
      bottom: 0,
      left: meadiaQuery.size.width * 0.02,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: meadiaQuery.size.width * 0.95,
        height: meadiaQuery.size.height * widget.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: getSnapshotDataEarnings(),
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return Text('Something went wrong');
            }
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            List<DocumentSnapshot> listOfDocumentSnap = asyncSnapshot.data.docs;
            return ListView.builder(
              itemCount: listOfDocumentSnap.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(2.0),
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green.shade50,
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 4),
                    ],
                  ),
                  height: 70,
                  child: ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colorSelectEarnings((listOfDocumentSnap[index]
                            .data() as Map)['category']),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        iconSelectEarnings((listOfDocumentSnap[index].data()
                            as Map)['category']),
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      '${(listOfDocumentSnap[index].data() as Map)['name']}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${(listOfDocumentSnap[index].data() as Map)['category']}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          '${(listOfDocumentSnap[index].data() as Map)['price']} z??',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${DateFormat("dd.MM.yyyy").format((listOfDocumentSnap[index].data() as Map)['time'].toDate())}',
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 800),
                          content: Text(
                            'Przytrzymaj aby usun????',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
                    },
                    onLongPress: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 800),
                          content: Text(
                            'USUNI??TO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
                      deleteEarnings(listOfDocumentSnap[index].id);
                    },
                  ),
                );

                //return TransactionItem(providerTransaction);
                // return Text(
                //   '${(listOfDocumentSnap[index].data() as Map)['name']}',
                //   style: TextStyle(color: Colors.black),
                // );
              },
            );
          },
        ),
      ),
    );
  }
}
