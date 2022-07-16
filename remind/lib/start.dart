import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remind/front1.dart';
import 'package:flutter/material.dart';
import 'package:remind/front.dart';

class start extends StatefulWidget {
  @override
  _startState createState() => _startState();
}

class _startState extends State<start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("REMINDER")),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => front1()));
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("student").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final services = snapshot.data.docs;
            List<Widget> servicesWidget = [];
            for (var st in services) {
              final date1 = st.data()['Date'];
              final time1 = st.data()['Time'];
              final text1 = st.data()['Text'];
              final topic = st.data()['toipc'];
              final docid = st.id;
              final datas =
                  builTile(date1, time1, text1, topic, docid, context);
              servicesWidget.add(datas);
            }
            return ListView(
              children: servicesWidget,
              shrinkWrap: true,

              //physics: NeverScrollableScrollPhysics(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

builTile(date1, time1, text1, topic, docid, BuildContext context) {
  return Card(
    child: ListTile(
      trailing: Icon(Icons.more_vert),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => front(
                      date2: date1,
                      time2: time1,
                      text2: text1,
                      topic2: topic,
                      id2: docid,
                    )));
      },
      title: Text("Topic  $topic"),
      subtitle: Text("Date  $date1"),
    ),
  );
}
