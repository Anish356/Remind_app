import 'package:flutter/material.dart';
//import 'package:remind/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remind/front1.dart';

class front extends StatefulWidget {
  final String date2;
  final String time2;
  final String text2;
  final String topic2;
  final String id2;

  const front(
      {Key key, this.topic2, this.text2, this.id2, this.date2, this.time2})
      : super(key: key);
  @override
  _frontState createState() => _frontState();
}

class _frontState extends State<front> {
  String topic;
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
              initialValue: ' ${widget.topic2 ?? ''}',
              controller: txt,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                labelText: 'for what?',
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
                  }),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 40, left: 5, right: 5),
              child: TextFormField(
                controller: txt,
                initialValue: ' ${widget.text2 ?? ''}',
                maxLines: 7,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  labelText: 'Text',
                ),
                onChanged: (text) {
                  setState(() {
                    yourtxt = text;
                    //you can access nameController in its scope to get
                    // the value of text entered as shown below
                    //fullName = nameController.text;
                  });
                },
              )),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
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
                      await FirebaseFirestore.instance
                          .collection('student')
                          .doc(widget.id2)
                          .update({
                        'toipc': topic,
                        'Time': value,
                        'Date': value1,
                        'Text': text1,
                      }).whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Update'),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    //     disabledColor: Colors.red,
                    // disabledTextColor: Colors.black,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.all(20),
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('student')
                          .doc(widget.id2)
                          .delete()
                          .whenComplete(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text('Delete'),
                  ),
                ),
              ],
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
