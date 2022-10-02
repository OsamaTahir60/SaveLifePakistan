import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:save_life_blood_doner/LabModule/Cart.dart';
import 'package:save_life_blood_doner/LabModule/ShowLab.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../plugins/size_config.dart';

class BookingLab extends StatefulWidget {
  String value ='';
  BookingLab({Key? key, required this.value}) : super(key: key);

  @override
  _BookingLabState createState() => _BookingLabState();
}

class _BookingLabState extends State<BookingLab>
    with SingleTickerProviderStateMixin {
  String TapToExpandIt = 'Description';
  final _controllerpage=PageController();
  String? selectedValue;
  double counter=1;
  String Sentence =
      'Widgets that have global keys reparent their subtrees when';
  bool isExpanded2 = true;
  bool isExpanded3 = true;
  bool isExpanded4 = true;
  double itemcounter =0;
  User? user = FirebaseAuth.instance.currentUser;
  var length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 7.0 * SizeConfig.heightMultiplier!,
          backgroundColor: const Color(0xffFF4A4F),
          elevation: 0,
          actions: [
            user !=null? Row(
              children: [
                SizedBox(
                  height: 4 * SizeConfig.heightMultiplier!,
                  width: 3 * SizeConfig.widthMultiplier!,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
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
                                      print(snapshot.data?.docs.length);
                                      print("object");
                                      length = snapshot.data?.docs.length;
                                      if(snapshot.hasData){
                                        return Container(
                                          margin: EdgeInsets.only(top: 2.0 * SizeConfig.heightMultiplier!,left: 0.0 * SizeConfig.heightMultiplier!),
                                          child: Text('$length',style: TextStyle(
                                              fontSize: 2.0 * SizeConfig.textMultiplier!,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400
                                          ),),
                                        );
                                      }
                                      else{
                                        return CircularProgressIndicator();
                                      }

                                    })),
                          ],
                        );
                      }),
                ),

                Container(
                  width: 10.0 * SizeConfig.widthMultiplier!,
                  padding: EdgeInsets.only(top: 2.0 * SizeConfig.heightMultiplier!,left: 0.0 * SizeConfig.heightMultiplier!),
                  child: InkWell(
                    onTap:() {
                      if(length==0){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please Add item into Card"),
                          backgroundColor: Colors.red,
                        ));
                      }
                      else{
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>  const Cart()));
                      }

                    },
                    child: Image.asset(
                        'assets/shop.png'),
                  ),
                ),

              ],
            ) :Container(),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const ShowLab()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
            left: true,
            top: true,
            right: true,
            bottom: true,
            child: AnimatedContainer(
              curve: Curves.easeInOutCubicEmphasized,
              duration: const Duration(milliseconds: 2000),
              child: Container(
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
                          Container(
                            margin: EdgeInsets.all(
                                2.0 * SizeConfig.heightMultiplier!),
                            child: Text(
                                widget.value,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 2.0 * SizeConfig.heightMultiplier!),
                                child: Text(
                                  "RS.200(Onwards)",
                                  style: TextStyle(
                                      color: const Color(0xff00ACB1),
                                      fontSize:
                                      2 * SizeConfig.textMultiplier!,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right:
                                    2.0 * SizeConfig.heightMultiplier!),
                                child: Image.asset('assets/doctorcheck.png',
                                    height:
                                    10.0 * SizeConfig.heightMultiplier!,
                                    fit: BoxFit.fill),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.all(
                                2.0 * SizeConfig.heightMultiplier!),
                            child: Text(
                              "Requirements:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 2.0 * SizeConfig.heightMultiplier!),
                            child: Text(
                              "Blood",
                              style: TextStyle(
                                  color: const Color(0xff00ACB1),
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 2.0 * SizeConfig.heightMultiplier!),
                            child: Text(
                              "Same day",
                              style: TextStyle(
                                  color: const Color(0xff00ACB1),
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(
                                2.0 * SizeConfig.heightMultiplier!),
                            child: Text(
                              "Labs:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10.0 * SizeConfig.heightMultiplier!,
                            child: PageView(
                              controller: _controllerpage,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusDirectional.circular(15)),
                                      elevation:5.0,
                                      child: SizedBox(
                                        width:32.0 * SizeConfig.widthMultiplier!,
                                        height: 20.0 * SizeConfig.heightMultiplier!,
                                        child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                                SizedBox(height: 1.0 * SizeConfig.heightMultiplier!,),
                                                Text(
                                                  "Rs.400",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusDirectional.circular(15)),
                                      elevation:5.0,
                                      child: SizedBox(
                                        width:32.0 * SizeConfig.widthMultiplier!,
                                        height: 20.0 * SizeConfig.heightMultiplier!,
                                        child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                                SizedBox(height: 1.0 * SizeConfig.heightMultiplier!,),
                                                Text(
                                                  "Rs.400",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusDirectional.circular(15)),
                                      elevation:5.0,
                                      child: SizedBox(
                                        width:32.0 * SizeConfig.widthMultiplier!,
                                        height: 20.0 * SizeConfig.heightMultiplier!,
                                        child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                                SizedBox(height: 1.0 * SizeConfig.heightMultiplier!,),
                                                Text(
                                                  "Rs.400",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusDirectional.circular(15)),
                                      elevation:5.0,
                                      child: SizedBox(
                                        width:32.0 * SizeConfig.widthMultiplier!,
                                        height: 20.0 * SizeConfig.heightMultiplier!,
                                        child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  widget.value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                                SizedBox(height: 1.0 * SizeConfig.heightMultiplier!,),
                                                Text(
                                                  "Rs.400",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2.0 *SizeConfig.heightMultiplier!,),
                          Center(
                              child: SmoothPageIndicator(
                                controller: _controllerpage,
                                count:  2,
                                axisDirection: Axis.horizontal,
                                effect:  const SlideEffect(
                                    spacing:  5.0,
                                    radius:  4.0,
                                    dotHeight: 9.0,
                                    dotWidth: 9.0,
                                    paintStyle:  PaintingStyle.stroke,
                                    strokeWidth:  1.5,
                                    dotColor:  Colors.grey,
                                    activeDotColor:  Colors.indigo
                                ),
                              )
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                isExpanded2 = !isExpanded2;
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.symmetric(
                                horizontal: isExpanded2 ? 75 : 75,
                                vertical: 10,
                              ),
                              padding: const EdgeInsets.all(15),
                              height: isExpanded2 ? 60 : 150,
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(milliseconds: 1200),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xffB8E2E3)
                                        .withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(5, 10),
                                  ),
                                ],
                                color: const Color(0xffB8E2E3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(isExpanded2 ? 20 : 20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        TapToExpandIt,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 2.0 *
                                              SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        isExpanded2
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        color: Colors.red,
                                        size:
                                        2.0 * SizeConfig.textMultiplier!,
                                      ),
                                    ],
                                  ),
                                  isExpanded2
                                      ? const SizedBox()
                                      : const SizedBox(height: 10),
                                  AnimatedCrossFade(
                                    firstChild: const Text(
                                      '',
                                      style: TextStyle(
                                        fontSize: 0,
                                      ),
                                    ),
                                    secondChild: Text(
                                      Sentence,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 2.0 *
                                              SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    crossFadeState: isExpanded2
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    duration:
                                    const Duration(milliseconds: 1200),
                                    reverseDuration: Duration.zero,
                                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                isExpanded3 = !isExpanded3;
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.symmetric(
                                horizontal: isExpanded3 ? 75 : 75,
                                vertical: 10,
                              ),
                              padding: const EdgeInsets.all(15),
                              height: isExpanded3 ? 60 : 150,
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(milliseconds: 1200),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xffB8E2E3)
                                        .withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(5, 10),
                                  ),
                                ],
                                color: const Color(0xffB8E2E3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(isExpanded3 ? 20 : 20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "How it Works",
                                        style: TextStyle(
                                          color: const Color(0xffFF193B),
                                          fontSize: 2.0 *
                                              SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        isExpanded3
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        color: const Color(0xffFF193B),
                                        size:
                                        2.0 * SizeConfig.textMultiplier!,
                                      ),
                                    ],
                                  ),
                                  isExpanded3
                                      ? const SizedBox()
                                      : const SizedBox(height: 10),
                                  AnimatedCrossFade(
                                    firstChild: const Text(
                                      '',
                                      style: TextStyle(
                                        fontSize: 0,
                                      ),
                                    ),
                                    secondChild: Text(
                                      Sentence,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 2.0 *
                                              SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    crossFadeState: isExpanded3
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    duration:
                                    const Duration(milliseconds: 1200),
                                    reverseDuration: Duration.zero,
                                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                isExpanded4 = !isExpanded4;
                              });
                            },
                            child: AnimatedContainer(
                              margin: EdgeInsets.symmetric(
                                horizontal: isExpanded4 ? 75 : 75,
                                vertical: 10,
                              ),
                              padding: const EdgeInsets.all(15),
                              height: isExpanded4 ? 60 : 150,
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(milliseconds: 1200),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xffB8E2E3)
                                        .withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(5, 10),
                                  ),
                                ],
                                color: const Color(0xffB8E2E3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(isExpanded4 ? 20 : 20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        'Why Get Tested',
                                        style: TextStyle(
                                          color: const Color(0xffFF193B),
                                          fontSize: 2.0 *
                                              SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Icon(
                                        isExpanded4
                                            ? Icons.keyboard_arrow_down
                                            : Icons.keyboard_arrow_up,
                                        color: const Color(0xffFF193B),
                                        size:
                                        2.0 * SizeConfig.textMultiplier!,
                                      ),
                                    ],
                                  ),
                                  isExpanded4
                                      ? const SizedBox()
                                      : const SizedBox(height: 10),
                                  AnimatedCrossFade(
                                    firstChild: const Text(
                                      '',
                                      style: TextStyle(
                                        fontSize: 0,
                                      ),
                                    ),
                                    secondChild: Text(
                                      Sentence,
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 2.0 *
                                              SizeConfig.textMultiplier!,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    crossFadeState: isExpanded4
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    duration:
                                    const Duration(milliseconds: 1200),
                                    reverseDuration: Duration.zero,
                                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  left: 19.0 * SizeConfig.heightMultiplier!,
                                  right: 19.0 * SizeConfig.heightMultiplier!
                              ),
                              width: 90 * SizeConfig.widthMultiplier!,
                              decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if(user == null){
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                      content: Text("SIGN-IN FIRST"),
                                      backgroundColor: Colors.red,
                                    ));
                                  }
                                  else{
                                    var bloodtype='${widget.value}';
                                    var price='200';
                                    var uid = user?.uid;
                                    var not = FirebaseFirestore.instance.collection("users").doc(uid).collection("SelectedBloodTest").doc(DateTime.now().microsecondsSinceEpoch.toString());
                                    FirebaseFirestore.instance.runTransaction((transaction) async{
                                      transaction.set(not,{
                                        "BloodTestType": bloodtype.toString(),
                                        "TestPrice": price.toString(),
                                      });
                                    });
                                    Fluttertoast.showToast(
                                        msg: "Item Added To Card",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.TOP,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: const Color(0xff4cbb17),
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    if(itemcounter <=9){
                                      setState(() {
                                        itemcounter++;
                                      });
                                      print(itemcounter);
                                    }
                                  }
                                },
                                child: Text("BOOK",
                                  style: TextStyle(
                                      color:Colors.white,
                                      fontSize: 1.9 *SizeConfig.textMultiplier!,
                                      fontWeight: FontWeight.w400
                                  ),),
                              )
                          ),
                        ],
                      ))),
            )));
  }
  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext _) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 5.0 * SizeConfig.heightMultiplier!,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color(0xffCAA3A3), // Set border color
                          width: 1.0),
                    ),
                    height: 13.0  * SizeConfig.heightMultiplier!,
                    width: 40.0 * SizeConfig.widthMultiplier!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 1.0 * SizeConfig.heightMultiplier!,
                              left: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "Lab:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "Save Life Pakistan",
                            style: TextStyle(
                                color: const Color(0xff00ACB1),
                                fontSize:
                                2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color(0xffCAA3A3), // Set border color
                          width: 1.0),
                    ),
                    height: 13.0  * SizeConfig.heightMultiplier!,
                    width: 40.0 * SizeConfig.widthMultiplier!,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 1.0 * SizeConfig.heightMultiplier!,
                              left: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "Indirect Bilirobin:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 2.0 * SizeConfig.heightMultiplier!),
                              child: IconButton(
                                onPressed: (){
                                  setState(() {
                                    if(counter!=212){
                                      counter/=2;
                                    }
                                  });
                                },
                                icon:const Icon(Icons.minimize),  ),
                            ),
                            Container(
                              child: Text(
                                "RS.$counter",
                                style: TextStyle(
                                    color: const Color(0xff00ACB1),
                                    fontSize:
                                    1.8 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                setState(() {
                                  counter*=2;
                                });
                              },
                              icon:const Icon(Icons.add),  ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(23.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: const Color(0xffCAA3A3), // Set border color
                      width: 1.0),
                ),
                height: 13.0  * SizeConfig.heightMultiplier!,
                width: 40.0 * SizeConfig.widthMultiplier!,
                child: Column(
                  children: [
                    SizedBox(height: 1.0  * SizeConfig.heightMultiplier!,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "SubTotal:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "RS.$counter",

                            style: TextStyle(
                                color: const Color(0xff00ACB1),
                                fontSize:
                                2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 1.0 * SizeConfig.heightMultiplier!,
                              left: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "Discount:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "RS.28.00",
                            style: TextStyle(
                                color: const Color(0xff00ACB1),
                                fontSize:
                                2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 1.0 * SizeConfig.heightMultiplier!,
                              left: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "Total :",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            "RS.$counter",
                            style: TextStyle(
                                color: const Color(0xff00ACB1),
                                fontSize:
                                2 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5.0 * SizeConfig.heightMultiplier!,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 40 * SizeConfig.widthMultiplier!,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("payment screen"),
                          ));
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(builder: (context) =>  const PaymentMethod()));// signIn(email.text, password.text);
                        },
                        child: Text("Confirm Order",
                          style: TextStyle(
                              color:Colors.white,
                              fontSize: 1.9 *SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w400
                          ),),
                      )
                  ),
                  Container(
                      width: 40 * SizeConfig.widthMultiplier!,
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: TextButton(
                        onPressed: () {
                          User? user = FirebaseAuth.instance.currentUser;
                          user!=null?
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Please Sign-in First"),
                          )) :
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Please Sign-in First"),
                          ));
                          // signIn(email.text, password.text);
                        },
                        child: Text("Add to Cart",
                          style: TextStyle(
                              color:Colors.white,
                              fontSize: 1.9 *SizeConfig.textMultiplier!,
                              fontWeight: FontWeight.w400
                          ),),
                      )
                  ),
                ],
              )
            ],
          )
        );
      },
    );
  }
}

