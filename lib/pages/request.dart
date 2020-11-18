import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lifeshare/utils/customWaveIndicator.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  List<String> seekers = [];
  Map<String, String> phones = {};
  List<String> bloodgroup = [];
  List<String> quantity = [];
  List<String> due_date = [];
  List<String> location = [];
  List<String> address = [];

  Widget _child;

  @override
  void initState() {
    _child = WaveIndicator();
    getSeekers();
    super.initState();
  }

  Future<Null> getSeekers() async {
    await Firestore.instance
        .collection('Blood Request Details')
        .getDocuments()
        .then((docs) {
      if (docs.documents.isNotEmpty) {
        print(docs.documents.length);
        for (int i = 0; i < docs.documents.length; ++i) {
          // print(docs.documents[i].data);
          seekers.add(docs.documents[i].data['name']);
          due_date.add(docs.documents[i].data['dueDate']);
          bloodgroup.add(docs.documents[i].data['bloodGroup']);
          quantity.add(docs.documents[i].data['quantity']);
          quantity[i] = "Quantity : " + quantity[i] + " L";
          phones[docs.documents[i].data['name']] =
              docs.documents[i].data['phone'];
          due_date[i] = "Due Date : " + due_date[i];
        }
      }
    });
    setState(() {
      _child = myWidget();
    });
  }

  Widget myWidget() {
    return Scaffold(
      backgroundColor: Color.fromARGB(1000, 221, 46, 68),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Blood Seekers",
          style: TextStyle(
            fontSize: 50.0,
            fontFamily: "SouthernAire",
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.reply,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ClipRRect(
        borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(40.0),
            topRight: const Radius.circular(40.0)),
        child: Container(
          height: 800.0,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: seekers.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100,
                  // alignment: Alignment.topCenter,

                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      title: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                seekers[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(quantity[index]),
                              Text(due_date[index]),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                            width: 5,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                launch(
                                    ('sms://${int.parse(phones[seekers[index]])}'));
                              },
                              color: Color.fromARGB(1000, 221, 46, 68),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: () {
                                launch(
                                    ('tel://${int.parse(phones[seekers[index]])}'));
                              },
                              color: Color.fromARGB(1000, 221, 46, 68),
                            ),
                          ),
                        ],
                      ),
                      leading: Padding(
                        padding: EdgeInsets.all(2),
                        child: CircleAvatar(
                          radius: 25,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: FittedBox(
                              child: Text(
                                bloodgroup[index],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          backgroundColor: Color.fromARGB(1000, 221, 46, 68),
                        ),
                      ),
                      // trailing: Container(
                      //   width: 40,
                      //   child: IconButton(
                      //   icon: Icon(Icons.phone),
                      //   onPressed: () {
                      //     launch(
                      //         ('tel://${int.parse(phones[seekers[index]])}'));
                      //   },
                      //   color: Color.fromARGB(1000, 221, 46, 68),
                      // ),),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}