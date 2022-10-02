import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:save_life_blood_doner/DoneeProfileCompleting.dart';
import 'package:save_life_blood_doner/Login/login.dart';
import 'package:save_life_blood_doner/SwipeUp.dart';
import 'package:save_life_blood_doner/plugins/size_config.dart';

import '../../LabModule/CheckOut.dart';
import '../../LabModule/ShowLab.dart';
import '../Map/CurrentLocationMap.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;
  final String facebook = 'assets/svg/facebook.svg';
  final String gmail = 'assets/svg/gmail.svg';
  final String whatsapp = 'assets/svg/whatsapp.svg';
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String name = "";
  late AnimationController _animationController;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  File? imageFile;
  bool _bool = true;
  String gender = '';
  List<String> group = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  double counter = 212;

  @override
  void initState() {
    super.initState();
    user != null
        ? FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .get()
            .then((value) {
            name = value.data()!['name'];
            gender = value.data()?['Gender'];
            setState(() {});
          })
        : null;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _animation1 = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          _bool = true;
        }
      });
    _animation2 = Tween<double>(begin: 0, end: .3).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animation3 = Tween<double>(begin: .9, end: 1).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.ease))
      ..addListener(() {
        setState(() {});
      });
  }

  bool selectvalue1 = false;

  bool selectvalue2 = false;

  bool selectvalue3 = false;

  bool selectvalue4 = false;

  bool selectvalue5 = false;

  bool selectvalue6 = false;

  bool selectvalue7 = false;

  bool selectvalue8 = false;

  bool selectvaluehopital = false;

  bool selectvaluebloodbank = false;

  int _value = -1;
  String price = "";
  String btt = "";
  int count = 212;
  double quantity = 1;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      drawer: Drawer(
          backgroundColor: const Color(0xffFF193B),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.05, 0.9],
                  colors: [Color(0xffFF193B), Colors.white]),
            ),
            child: ListView(
              children: [
                user != null
                    ? Container(
                        margin: EdgeInsets.only(
                            top: 0.5 * SizeConfig.heightMultiplier!),
                        height: 7.0 * SizeConfig.heightMultiplier!,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 10.0 * SizeConfig.imageSizeMultiplier!,
                          color: Colors.black,
                        ),
                      )
                    : SizedBox(
                        height: 5 * SizeConfig.heightMultiplier!,
                      ),
                user != null
                    ? Container(
                        margin: EdgeInsets.only(
                            top: 0.5 * SizeConfig.heightMultiplier!),
                        child: Center(
                          child: Text(
                            "Malik Sarfraz",
                            style: TextStyle(
                                fontFamily: "Merriweather",
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(
                            top: 0.5 * SizeConfig.heightMultiplier!),
                        child: Center(
                          child: Text(
                            "Guest",
                            style: TextStyle(
                                fontFamily: "Merriweather",
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                      ),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: TextButton.icon(
                      // <-- TextButton
                      onPressed: () {},
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 4.0 * SizeConfig.imageSizeMultiplier!,
                      ),
                      label: Text(
                        "location",
                        style: TextStyle(
                            fontFamily: "Merriweather",
                            fontSize: 2 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    // <-- TextButton
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                      size: 5.0 * SizeConfig.imageSizeMultiplier!,
                      color: Colors.black,
                    ),
                    label: Text(
                      "Address",
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 2 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                ),
                user != null
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: TextButton.icon(
                          // <-- TextButton
                          onPressed: () {},
                          icon: Image.asset('assets/profile (1).png'),
                          label: Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontFamily: "Merriweather",
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                      )
                    : Container(),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    // <-- TextButton
                    onPressed: () {},
                    icon: Image.asset('assets/group.png'),
                    label: Text(
                      "My Team",
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 2 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    // <-- TextButton
                    onPressed: () {},
                    icon: Image.asset('assets/add-reminder.png'),
                    label: Text(
                      "Reminders",
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 2 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    // <-- TextButton
                    onPressed: () {},
                    icon: Image.asset('assets/knowledge.png'),
                    label: Text(
                      "Offers",
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 2 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    // <-- TextButton
                    onPressed: () {},
                    icon: Image.asset('assets/gift-voucher.png'),
                    label: Text(
                      "Redeem Vouchers",
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 2 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    // <-- TextButton
                    onPressed: () {},
                    icon: Image.asset('assets/application.png'),
                    label: Text(
                      "Blood Request",
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 2 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                    // <-- TextButton
                    onPressed: () {},
                    icon: Image.asset('assets/invite.png'),
                    label: Text(
                      "Invite Friend",
                      style: TextStyle(
                          fontFamily: "Merriweather",
                          fontSize: 2 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                  ),
                ),
                Divider(
                  height: 2.0 * SizeConfig.heightMultiplier!,
                  thickness: 0.5 * SizeConfig.heightMultiplier!,
                ),
                user != null
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: TextButton.icon(
                          // <-- TextButton
                          onPressed: () {},
                          icon: Icon(
                            Icons.logout,
                            size: 5.0 * SizeConfig.imageSizeMultiplier!,
                            color: Colors.black,
                          ),
                          label: Text(
                            "Log out",
                            style: TextStyle(
                                fontFamily: "Merriweather",
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 7 * SizeConfig.heightMultiplier!,
                      width: 16 * SizeConfig.widthMultiplier!,
                      child: SvgPicture.asset(
                        facebook,
                        semanticsLabel: 'BIAACO Logo',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 8 * SizeConfig.heightMultiplier!,
                      width: 18 * SizeConfig.widthMultiplier!,
                      child: SvgPicture.asset(
                        gmail,
                        semanticsLabel: 'BIAACO Logo',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 8 * SizeConfig.heightMultiplier!,
                      width: 18 * SizeConfig.widthMultiplier!,
                      child: SvgPicture.asset(
                        whatsapp,
                        semanticsLabel: 'BIAACO Logo',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
      appBar: AppBar(
        toolbarHeight: 7.0 * SizeConfig.heightMultiplier!,
        backgroundColor: const Color(0xffFF4A4F),
        elevation: 0,
        title: Text(
          "SAVE-LIFE",
          style: TextStyle(
              fontFamily: "Merriweather",
              fontSize: 2.5 * SizeConfig.textMultiplier!,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
        actions: [
          user != null
              ? Container()
              : Container(
                  margin: EdgeInsets.only(
                      top: 2.0 * SizeConfig.heightMultiplier!,
                      right: 2.0 * SizeConfig.heightMultiplier!),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    child: const SlideFadeTransition(
                      delayStart: Duration(milliseconds: 1000),
                      animationDuration: Duration(milliseconds: 1000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      offset: 5,
                      child: Text(
                        'SIGN-IN...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ))
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          splashColor: Colors.transparent,
          onPressed: () {
            if (_bool == true) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
            _bool = false;
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: _height,
            width: _width,
            child: AnimatedContainer(
                curve: Curves.easeInOutCubicEmphasized,
                duration: const Duration(milliseconds: 2000),
                child: ListView(
                  children: [
                    Container(
                        color: const Color(0xffFF4A4F),
                        height: 150.0 * SizeConfig.heightMultiplier!,
                        child: Card(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35))),
                          color: Colors.white,
                          child: ListView(
                            children: [
                              Stack(
                                fit: StackFit.loose,
                                children: [
                                  Container(
                                    height: 11 * SizeConfig.heightMultiplier!,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffFF4A4F),
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(25.0),
                                          bottom: Radius.circular(20.0)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            user != null
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4.0 *
                                                            SizeConfig
                                                                .heightMultiplier!,
                                                        top: 0.0 *
                                                            SizeConfig
                                                                .heightMultiplier!),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Hi $name',
                                                          style: const TextStyle(
                                                              color: Color(0xff1B1464),
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        const Text(
                                                          "Welcome Back",
                                                          style: TextStyle(
                                                              color: Color(0xff1B1464),
                                                              fontFamily:
                                                                  "Roboto",
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ))
                                                : const Text(
                                                    "    Guest User",
                                                    style: TextStyle(
                                                        fontFamily: "Roboto",
                                                        color: Color(0xff1B1464),
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 2.0 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      // adding some properties
                                                      showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
                                                        // color is applied to main screen when modal bottom screen is displayed
                                                        // barrierColor: Colors.greenAccent,
                                                        //background color for modal bottom screen
                                                        //elevates modal bottom screen
                                                        elevation: 10,
                                                        // gives rounded corner to modal bottom screen
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        builder: (BuildContext
                                                            context) {
                                                          // UDE : SizedBox instead of Container for whitespaces
                                                          return SizedBox(
                                                            height: 90.0 *
                                                                SizeConfig
                                                                    .heightMultiplier!,
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height: 0.0 *
                                                                      SizeConfig
                                                                          .heightMultiplier!,
                                                                ),
                                                                SizedBox(
                                                                  height: 60.0 *
                                                                      SizeConfig
                                                                          .heightMultiplier!,
                                                                  child:
                                                                      StreamBuilder(
                                                                          stream: FirebaseFirestore
                                                                              .instance
                                                                              .collection('users')
                                                                              .doc(user!.uid)
                                                                              .collection("SelectedBloodTest")
                                                                              .snapshots(),
                                                                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                            return Column(
                                                                              children: [
                                                                                Expanded(
                                                                                    child: ListView.builder(
                                                                                        itemCount: snapshot.data?.docs.length,
                                                                                        itemBuilder: (listContext, index) {
                                                                                          btt = snapshot.data?.docs[index]['BloodTestType'];
                                                                                          price = snapshot.data?.docs[index]['TestPrice'];
                                                                                          var p1 = price;
                                                                                          p1 += price;
                                                                                          print(p1);
                                                                                          print("sasdada");
                                                                                          // print(t1);
                                                                                          // print(btt + " " + price);
                                                                                          // print(snapshot.data?.docs.length);
                                                                                          return Stack(
                                                                                            children: [
                                                                                              Container(
                                                                                                margin: EdgeInsets.only(left: 2.0 * SizeConfig.heightMultiplier!),
                                                                                                child: IconButton(
                                                                                                  iconSize: 50,
                                                                                                  icon: const Icon(
                                                                                                    Icons.add,
                                                                                                    color: Colors.black,
                                                                                                  ),
                                                                                                  onPressed: () {
                                                                                                    setState(
                                                                                                      () {
                                                                                                        count++;
                                                                                                      },
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                              ),
                                                                                              Container(
                                                                                                padding: EdgeInsets.only(left: 2.0 * SizeConfig.heightMultiplier!),
                                                                                                margin: EdgeInsets.all(2.0 * SizeConfig.heightMultiplier!),
                                                                                                height: 17.0 * SizeConfig.heightMultiplier!,
                                                                                                decoration: BoxDecoration(
                                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                                  color: const Color(0xfff0f0f0),
                                                                                                ),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        Row(
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(left: 0.0 * SizeConfig.heightMultiplier!, top: 3.0 * SizeConfig.heightMultiplier!),
                                                                                                              child: Text(
                                                                                                                "Lab:",
                                                                                                                style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.bold),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(left: 0.0 * SizeConfig.heightMultiplier!, top: 3.0 * SizeConfig.heightMultiplier!),
                                                                                                              child: Text(
                                                                                                                "Lab:",
                                                                                                                style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.w500),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Row(
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(left: 0.0 * SizeConfig.heightMultiplier!, top: 1.5 * SizeConfig.heightMultiplier!),
                                                                                                              child: Text(
                                                                                                                "Test:",
                                                                                                                style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.bold),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(left: 0.0 * SizeConfig.heightMultiplier!, top: 1.5 * SizeConfig.heightMultiplier!),
                                                                                                              child: Text(
                                                                                                                '$btt',
                                                                                                                style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.w500),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                        Row(
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(left: 0.0 * SizeConfig.heightMultiplier!, top: 1.5 * SizeConfig.heightMultiplier!),
                                                                                                              child: Text(
                                                                                                                "Price:",
                                                                                                                style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.bold),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(left: 0.0 * SizeConfig.heightMultiplier!, top: 1.5 * SizeConfig.heightMultiplier!),
                                                                                                              child: Text(
                                                                                                                '$price',
                                                                                                                style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.w500),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    Column(
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          margin: EdgeInsets.only(left: 6.0 * SizeConfig.heightMultiplier!),
                                                                                                          child: IconButton(
                                                                                                            onPressed: () {
                                                                                                              FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('SelectedBloodTest').doc(snapshot.data?.docs[index].id).delete();
                                                                                                            },
                                                                                                            icon: const Icon(Icons.cancel),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Row(
                                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(bottom: 2.0 * SizeConfig.heightMultiplier!),
                                                                                                              child: IconButton(
                                                                                                                onPressed: () {
                                                                                                                  _subCounter();
                                                                                                                },
                                                                                                                icon: const Icon(Icons.minimize),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(left: 0.0 * SizeConfig.heightMultiplier!),
                                                                                                              child: Text(
                                                                                                                "$quantity".replaceAll(".0", ""),
                                                                                                                style: TextStyle(color: const Color(0xff00ACB1), fontSize: 1.8 * SizeConfig.textMultiplier!, fontWeight: FontWeight.w400),
                                                                                                              ),
                                                                                                            ),
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.only(bottom: 0.0 * SizeConfig.heightMultiplier!),
                                                                                                              child: IconButton(
                                                                                                                onPressed: () {
                                                                                                                  _incrementCounter();
                                                                                                                },
                                                                                                                icon: const Icon(Icons.add),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ],
                                                                                                    )
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        })),
                                                                              ],
                                                                            );
                                                                          }),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                      left: 2.0 *
                                                                          SizeConfig
                                                                              .heightMultiplier!),
                                                                  margin: EdgeInsets
                                                                      .all(2.0 *
                                                                          SizeConfig
                                                                              .heightMultiplier!),
                                                                  height: 15.0 *
                                                                      SizeConfig
                                                                          .heightMultiplier!,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    color: const Color(
                                                                        0xfff0f0f0),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 1.0 *
                                                                            SizeConfig.heightMultiplier!,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 2.0 * SizeConfig.heightMultiplier!),
                                                                            child:
                                                                                Text(
                                                                              "SubTotal:",
                                                                              style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 2.0 * SizeConfig.heightMultiplier!),
                                                                            child:
                                                                                Text(
                                                                              "RS.'$price",
                                                                              style: TextStyle(color: const Color(0xff00ACB1), fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 1.0 * SizeConfig.heightMultiplier!, left: 2.0 * SizeConfig.heightMultiplier!),
                                                                            child:
                                                                                Text(
                                                                              "Discount:",
                                                                              style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 2.0 * SizeConfig.heightMultiplier!),
                                                                            child:
                                                                                Text(
                                                                              "RS.28.00",
                                                                              style: TextStyle(color: const Color(0xff00ACB1), fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      const Divider(),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 1.0 * SizeConfig.heightMultiplier!, left: 2.0 * SizeConfig.heightMultiplier!),
                                                                            child:
                                                                                Text(
                                                                              "Total :",
                                                                              style: TextStyle(color: Colors.black, fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(right: 2.0 * SizeConfig.heightMultiplier!),
                                                                            child:
                                                                                Text(
                                                                              "RS.$counter",
                                                                              style: TextStyle(color: const Color(0xff00ACB1), fontSize: 2 * SizeConfig.textMultiplier!, fontWeight: FontWeight.w400),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                    margin: EdgeInsets.only(
                                                                        left: 5.0 *
                                                                            SizeConfig
                                                                                .heightMultiplier!,
                                                                        right: 5.0 *
                                                                            SizeConfig
                                                                                .heightMultiplier!),
                                                                    decoration: const BoxDecoration(
                                                                        color: Colors
                                                                            .red,
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                20))),
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context).push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                const CheckOut()));
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Checkout",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 2 * SizeConfig.textMultiplier!,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                    )),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Image.asset(
                                                        'assets/cart.png'),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {},

                                                    icon: Image.asset(
                                                        'assets/belliconlatest.png'),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (_bool == true) {
                                                        _animationController
                                                            .forward();
                                                      } else {
                                                        _animationController
                                                            .reverse();
                                                      }
                                                      _bool = false;
                                                    },
                                                    child: CircleAvatar(
                                                      radius: 15,
                                                      // backgroundColor: Colors.amber,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[50],
                                                        radius: 50,
                                                        // child: Image.asset("assets/images/nophotoMale.png")
                                                        backgroundImage:
                                                            const AssetImage(
                                                                "assets/logo.png"),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  user != null
                                      ? Container(
                                          alignment: Alignment.center,
                                          height:
                                              17 * SizeConfig.heightMultiplier!,
                                          child: Card(
                                            margin: EdgeInsets.only(
                                                top: 7.0 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                                left: 3.0 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                                bottom: 1.0 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                                right: 3.0 *
                                                    SizeConfig
                                                        .heightMultiplier!),
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: 1 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 4.5 * SizeConfig.heightMultiplier!,top: 0.1 * SizeConfig.heightMultiplier!),
                                                        child: Text(
                                                          "1",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 1.8 *
                                                                  SizeConfig
                                                                      .textMultiplier!),
                                                        ),
                                                      ),
                                                    Column(
                                                      children: [
                                                        Image.asset(
                                                            'assets/heart.png',
                                                            height: 4 *
                                                                SizeConfig
                                                                    .heightMultiplier!,
                                                            fit: BoxFit.fill),
                                                        Text(
                                                          "Saved lives",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 1.4 *
                                                                  SizeConfig
                                                                      .textMultiplier!),
                                                        ),
                                                      ],
                                                    ),
                                                  ],),
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                          'assets/loca.png',
                                                          height: 4 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                          fit: BoxFit.fill),
                                                      Text(
                                                        "Track Order",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 1.4 *
                                                                SizeConfig
                                                                    .textMultiplier!),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                          'assets/question.png',
                                                          height: 4.0 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                          fit: BoxFit.fill),
                                                      Text(
                                                        "Question",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 1.4 *
                                                                SizeConfig
                                                                    .textMultiplier!),
                                                      ),
                                                    ],
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5 * SizeConfig.heightMultiplier!,top: 0.1 * SizeConfig.heightMultiplier!),
                                                        child: Text(
                                                          "1",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 1.8 *
                                                                  SizeConfig
                                                                      .textMultiplier!),
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Image.asset(
                                                              'assets/drop.png',
                                                              height: 4.0 *
                                                                  SizeConfig
                                                                      .heightMultiplier!,
                                                              fit: BoxFit.fill),
                                                          Text(
                                                            "Blood Requests",
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 1.4 *
                                                                    SizeConfig
                                                                        .textMultiplier!),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                    alignment: Alignment.center,
                                    height:
                                    14 * SizeConfig.heightMultiplier!,
                                    child: Card(
                                      margin: EdgeInsets.only(
                                          top: 7.0 *
                                              SizeConfig
                                                  .heightMultiplier!,
                                          left: 3.0 *
                                              SizeConfig
                                                  .heightMultiplier!,
                                          bottom: 1.0 *
                                              SizeConfig
                                                  .heightMultiplier!,
                                          right: 3.0 *
                                              SizeConfig
                                                  .heightMultiplier!),
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(14)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.0 * SizeConfig.heightMultiplier!,
                              ),
                              InkWell(
                                onTap: () {
                                  print(gender);
                                  if (user != null) {
                                    if (gender == "Gender.Female" ||
                                        gender == "Gender.Male" ||
                                        gender == "Gender.Others") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CurrentLocationMap()));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DoneeProfileCompleting()));
                                    }
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CurrentLocationMap()));
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 2.0 * SizeConfig.heightMultiplier!,
                                      right:
                                          2.0 * SizeConfig.heightMultiplier!),
                                  child: PhysicalModel(
                                    color: Colors.white,
                                    elevation: 8,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      margin: EdgeInsets.all(
                                          0 * SizeConfig.heightMultiplier!),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xffFFB6C1),
                                                Colors.white
                                              ])),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 5.0 *
                                                        SizeConfig
                                                            .heightMultiplier!,
                                                    left: 0.0 *
                                                        SizeConfig
                                                            .heightMultiplier!),
                                                child: Text(
                                                  "Blood",
                                                  style: TextStyle(
                                                      fontSize: 3 *
                                                          SizeConfig
                                                              .textMultiplier!,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 2.0 *
                                                        SizeConfig
                                                            .heightMultiplier!),
                                                child: TextButton(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0.5 *
                                                            SizeConfig
                                                                .heightMultiplier!,
                                                        right: 0.5 *
                                                            SizeConfig
                                                                .heightMultiplier!),
                                                    child: Text('Order Now',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 2 *
                                                                SizeConfig
                                                                    .textMultiplier!,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  style: TextButton.styleFrom(
                                                    primary: Colors.teal,
                                                    onSurface: Colors.yellow,
                                                    backgroundColor:
                                                        Colors.white,
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xff707070),
                                                        width: 1),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const DoneeProfileCompleting()));
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          Image.asset('assets/bloodb.png',
                                              width: 30.0 *
                                                  SizeConfig.widthMultiplier!,
                                              height: 18.0 *
                                                  SizeConfig.heightMultiplier!,
                                              fit: BoxFit.fill),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                    1.5 * SizeConfig.heightMultiplier!),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        PhysicalModel(
                                          color: Colors.white,
                                          elevation: 8,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Container(
                                              height: 18.0 *
                                                  SizeConfig.heightMultiplier!,
                                              width: 44 *
                                                  SizeConfig.widthMultiplier!,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: const LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color(0xff0BE9E9),
                                                      Colors.white
                                                    ]),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Image.asset(
                                                        'assets/dawai2.png'),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    margin: EdgeInsets.only(
                                                        bottom: 7.0 *
                                                            SizeConfig
                                                                .heightMultiplier!,
                                                        left: 2.5 *
                                                            SizeConfig
                                                                .heightMultiplier!),
                                                    child: Text(
                                                      "Dawai",
                                                      style: TextStyle(
                                                          fontFamily: "Roboto",
                                                          fontSize: 3 *
                                                              SizeConfig
                                                                  .textMultiplier!,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    // margin: EdgeInsets.only(right: 11.0 * SizeConfig.heightMultiplier!),
                                                    margin: EdgeInsets.only(
                                                        bottom: 1.0 *
                                                            SizeConfig
                                                                .heightMultiplier!,
                                                        left: 1.5 *
                                                            SizeConfig
                                                                .heightMultiplier!,
                                                        top: .5 *
                                                            SizeConfig
                                                                .heightMultiplier!),
                                                    child: TextButton(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            left: 0.0 *
                                                                SizeConfig
                                                                    .heightMultiplier!,
                                                            right: 0.0 *
                                                                SizeConfig
                                                                    .heightMultiplier!),
                                                        child: Text('Order Now',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 2 *
                                                                    SizeConfig
                                                                        .textMultiplier!,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                      ),
                                                      style:
                                                          TextButton.styleFrom(
                                                        primary: Colors.teal,
                                                        onSurface:
                                                            Colors.yellow,
                                                        backgroundColor:
                                                            Colors.white,
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xff707070),
                                                            width: 1),
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                        SizedBox(
                                          height: 1.0 *
                                              SizeConfig.heightMultiplier!,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const ShowLab()));
                                            },
                                            child: PhysicalModel(
                                              color: Colors.white,
                                              elevation: 8,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: Container(
                                                height: 18.0 *
                                                    SizeConfig
                                                        .heightMultiplier!,
                                                width: 44 *
                                                    SizeConfig.widthMultiplier!,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  gradient:
                                                      const LinearGradient(
                                                          begin: Alignment
                                                              .topCenter,
                                                          end: Alignment
                                                              .bottomCenter,
                                                          colors: [
                                                        Color(0xffAF517D),
                                                        Colors.white
                                                      ]),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 2.0 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                          top: 4.0 *
                                                              SizeConfig
                                                                  .heightMultiplier!),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "Lab Test",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 3 *
                                                                SizeConfig
                                                                    .textMultiplier!,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(
                                                              left: 2.0 *
                                                                  SizeConfig
                                                                      .heightMultiplier!,
                                                              top: .5 *
                                                                  SizeConfig
                                                                      .heightMultiplier!),
                                                          height: 4.5 *
                                                              SizeConfig
                                                                  .heightMultiplier!,
                                                          child: TextButton(
                                                            child: Text(
                                                                'Order Now',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize: 2 *
                                                                        SizeConfig
                                                                            .textMultiplier!,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                            style: TextButton
                                                                .styleFrom(
                                                              primary:
                                                                  Colors.teal,
                                                              onSurface:
                                                                  Colors.yellow,
                                                              backgroundColor:
                                                                  Colors.white,
                                                              side: const BorderSide(
                                                                  color: Color(
                                                                      0xff707070),
                                                                  width: 1),
                                                              shape: const RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              12))),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const ShowLab()));
                                                            },
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 10.8 *
                                                                SizeConfig
                                                                    .heightMultiplier!,
                                                          ),
                                                          child: Image.asset(
                                                              'assets/hand.png'),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                    PhysicalModel(
                                      color: Colors.white,
                                      elevation: 8,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height:
                                            37.0 * SizeConfig.heightMultiplier!,
                                        width: 42 * SizeConfig.widthMultiplier!,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xffACB1B5),
                                                Colors.white
                                              ]),
                                        ),
                                        child: Stack(
                                          children: [
                                            Container(
                                              alignment: Alignment.topCenter,
                                              margin: EdgeInsets.only(
                                                  top: 5.0 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                              child: Text(
                                                "Consultant",
                                                style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 3 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  top: 10.0 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                              height: 4.5 *
                                                  SizeConfig.heightMultiplier!,
                                              child: TextButton(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.0 *
                                                          SizeConfig
                                                              .heightMultiplier!,
                                                      right: 2.0 *
                                                          SizeConfig
                                                              .heightMultiplier!),
                                                  child: Text('Order Now',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 2 *
                                                              SizeConfig
                                                                  .textMultiplier!,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                                style: TextButton.styleFrom(
                                                  primary: Colors.teal,
                                                  onSurface: Colors.yellow,
                                                  backgroundColor: Colors.white,
                                                  side: const BorderSide(
                                                      color: Color(0xff707070),
                                                      width: 1),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 23.8 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                              alignment: Alignment.bottomCenter,
                                              child:
                                                  Image.asset('assets/doc.png'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Image.asset('assets/add.png'),
                            ],
                          ),
                        )),
                    CustomNavigationDrawer(),
                  ],
                )),
          ),
          CustomNavigationDrawer(),
        ],
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      counter *= 2;
      quantity += 1;
    });
  }

  void _subCounter() {
    setState(() {
      if (counter != 212) {
        counter /= 2;
        quantity -= 1;
      }
    });
  }

  Widget CustomNavigationDrawer() {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaY: _animation1.value, sigmaX: _animation1.value),
      child: Container(
        height: _bool ? 0 : _height,
        width: _bool ? 0 : _width,
        color: Colors.transparent,
        child: Center(
          child: Transform.scale(
            scale: _animation3.value,
            child: Container(
              width: _width * .9,
              height: _width * 1.3,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(_animation2.value),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  user != null
                      ? const CircleAvatar(
                          backgroundColor: Colors.black12,
                          radius: 35,
                          child: Icon(
                            Icons.person_outline_rounded,
                            size: 30,
                            color: Color(0xffFF193B),
                          ),
                        )
                      : Container(),
                  Column(
                    children: [
                      user != null
                          ? MyTile(Icons.account_circle_sharp, 'Edit Profile',
                              () {
                              HapticFeedback.lightImpact();
                              showAnimatedDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return ClassicGeneralDialogWidget(
                                    titleText: 'Title',
                                    contentText: 'content',
                                    onPositiveClick: () {
                                      Navigator.of(context).pop();
                                    },
                                    onNegativeClick: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                animationType: DialogTransitionType.size,
                                curve: Curves.fastOutSlowIn,
                                duration: const Duration(seconds: 1),
                              );
                            })
                          : Container(),
                      user != null
                          ? MyTile(Icons.tram_sharp, 'My Team', () {
                              HapticFeedback.lightImpact();
                              Fluttertoast.showToast(
                                msg: 'Button pressed',
                              );
                            })
                          : Container(),
                      MyTile(Icons.feedback_outlined, 'Feedback', () {
                        HapticFeedback.lightImpact();
                        Fluttertoast.showToast(
                          msg: 'Button pressed',
                        );
                      }),
                      MyTile(Icons.find_in_page_outlined, 'Privacy Policy', () {
                        HapticFeedback.lightImpact();
                        Fluttertoast.showToast(
                          msg: 'Button pressed',
                        );
                      }),
                      user != null
                          ? MyTile(Icons.find_in_page_outlined, 'Logout', () {
                              HapticFeedback.lightImpact();
                              FirebaseAuth.instance.signOut();
                            })
                          : Container(),
                    ],
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget MyTile(
    IconData icon,
    String title,
    VoidCallback voidCallback,
  ) {
    return Column(
      children: [
        ListTile(
          tileColor: Colors.black.withOpacity(.08),
          leading: CircleAvatar(
            backgroundColor: Colors.black12,
            child: Icon(
              icon,
              color: const Color(0xffFF193B),
            ),
          ),
          onTap: voidCallback,
          title: Text(
            title,
            style: const TextStyle(
                color: Color(0xffFF193B),
                fontWeight: FontWeight.w500,
                letterSpacing: 1),
          ),
          trailing: const Icon(
            Icons.arrow_right,
            color: Color(0xffFF193B),
          ),
        ),
        divider()
      ],
    );
  }

  Widget divider() {
    return SizedBox(
      height: 5,
      width: MediaQuery.of(context).size.width,
    );
  }
}
