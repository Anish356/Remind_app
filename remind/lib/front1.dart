import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String topic;
String time1;
String date1;
String text1;

class front1 extends StatefulWidget {
  @override
  _front1State createState() => _front1State();
}

class _front1State extends State<front1> {
  TextEditingController txt;
  String istapped = '';
  String yourtxt = '';
  DateTime pickedDate;
  TimeOfDay time;
  String value = ' ';
  String value1 = '';
  DateTime pickeDate;

  //get value => null;

  @override
  void initState() {
    super.initState();

    time = TimeOfDay.now();
    pickeDate = DateTime.now();
    value1 = '${pickeDate.day}/${pickeDate.month}/${pickeDate.year}';
    value = '${time.hour}:${time.minute}';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REMINDER'),
        toolbarHeight: 60.2,
        titleSpacing: 00.0,
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(360)),
      ), //,

      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            child: TextFormField(
              controller: txt,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                labelText: 'for whar?',
                hintText: 'For what?',
              ),
              onChanged: (data3) {
                setState(() {
                  topic = data3;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30, left: 5, right: 5),
            height: 50,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Text(
                'Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text('$value'),
              trailing: IconButton(
                  icon: Icon(Icons.alarm),
                  onPressed: () async {
                    picktime();
                    value = '${time.hour}:${time.minute}';
                    time1 = value;
                  }),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 5, right: 5),
            height: 50,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              leading: Text(
                'Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text('$value1'),
              trailing: IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    pickDate();
                    value1 =
                        '${pickeDate.day}/${pickeDate.month}/${pickeDate.year}';
                    date1 = value1;
                  }),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 40, left: 5, right: 5),
              child: TextField(
                controller: txt,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  labelText: 'Text',
                ),
                onChanged: (text) {
                  setState(() {
                    yourtxt = text;
                    text1 = text;
                    //you can access nameController in its scope to get
                    // the value of text entered as shown below
                    //fullName = nameController.text;
                  });
                },
              )),
          Container(
            height: 60,
            width: 5,
            margin: EdgeInsets.only(top: 20, left: 110, right: 110),
            child: RaisedButton(
              //     disabledColor: Colors.red,
              // disabledTextColor: Colors.black,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),

              padding: const EdgeInsets.all(20),
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () async {
                await FirebaseFirestore.instance.collection('student').add({
                  'toipc': topic,
                  'Time': time1,
                  'Date': date1,
                  'Text': text1,
                }).whenComplete(() {
                  //txt.clear();
                  Navigator.pop(context);
                });
              },
              child: Text('SAVE'),
            ),
          ),
        ],
      ),
    );
  }

  picktime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: time);

    if (t != null)
      setState(() {
        time = t;
      });
    return time;
  }

  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: pickeDate,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5));
    if (date != null)
      setState(() {
        pickeDate = date;
      });
    return pickeDate;
  }
}
