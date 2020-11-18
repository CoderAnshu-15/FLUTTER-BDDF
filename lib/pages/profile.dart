import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
//
import './home.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _phone;
  String _name;
  String _email;
  String _bloodGroup;
  FirebaseUser currentUser;
  List<Placemark> placemark;
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _getUser();
  }

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> _loadCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
      setState(() {
        // call setState to rebuild the view
        this.currentUser = user;
      });
    });
  }

  Future<void> _getUser() async {
    Map<String, dynamic> _userInfo;
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();

    DocumentSnapshot _snapshot = await Firestore.instance
        .collection("User Details")
        .document(_currentUser.uid)
        .get();

    _userInfo = _snapshot.data;

    this.setState(() {
      _name = _userInfo['name'];
      _email = _userInfo['email'];
      _bloodGroup = _userInfo['bloodgroup'];
      _phone = _userInfo['phone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(1000, 221, 46, 68),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Name : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raylen',
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                    Text(
                      _name,
                      style: TextStyle(
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raylen',
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raylen',
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                    Text(
                      _email,
                      style: TextStyle(
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raylen',
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Phone : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raylen',
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                    Text(
                      // "L",
                      _phone,
                      style: TextStyle(
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raylen',
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Blood Group : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raylen',
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                    Text(
                      // "Anshu",
                      _bloodGroup,
                      style: TextStyle(
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raylen',
                          fontStyle: FontStyle.italic,
                          fontSize: 30),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
