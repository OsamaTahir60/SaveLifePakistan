import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:save_life_blood_doner/LabModule/CheckOut.dart';
import 'package:save_life_blood_doner/LabModule/ShowLab.dart';

import '../plugins/size_config.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;
  int count = 212;
  double counter = 212;
  double quantity = 1;
  bool isActive = false;
  User? user = FirebaseAuth.instance.currentUser;
  String price = "";
  String btt = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 7.0 * SizeConfig.heightMultiplier!,
          backgroundColor: const Color(0xffFF4A4F),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
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
                  color: Colors.white,
                  height: 150.0 * SizeConfig.heightMultiplier!,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 0.0 * SizeConfig.heightMultiplier!,
                      ),
                      SizedBox(
                        height: 60.0 * SizeConfig.heightMultiplier!,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .doc(user!.uid)
                                .collection("SelectedBloodTest")
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              return Column(
                                children: [
                                  Expanded(
                                      child: ListView.builder(
                                          itemCount: snapshot.data?.docs.length,
                                          itemBuilder: (listContext, index) {
                                            btt = snapshot.data?.docs[index]
                                                ['BloodTestType'];
                                            price = snapshot.data?.docs[index]
                                                ['TestPrice'];
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
                                                  margin: EdgeInsets.only(left: 2.0 *
                                                      SizeConfig
                                                          .heightMultiplier!),
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
                                                  padding: EdgeInsets.only(
                                                      left: 2.0 *
                                                          SizeConfig
                                                              .heightMultiplier!),
                                                  margin: EdgeInsets.all(2.0 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                                  height: 17.0 *
                                                      SizeConfig
                                                          .heightMultiplier!,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color:
                                                        const Color(0xfff0f0f0),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 0.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                    top: 3.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: Text(
                                                                  "Lab:",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 2 *
                                                                          SizeConfig
                                                                              .textMultiplier!,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 0.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                    top: 3.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: Text(
                                                                  "Lab:",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 2 *
                                                                          SizeConfig
                                                                              .textMultiplier!,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 0.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                    top: 1.5 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: Text(
                                                                  "Test:",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 2 *
                                                                          SizeConfig
                                                                              .textMultiplier!,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 0.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                    top: 1.5 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: Text(
                                                                  '$btt',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 2 *
                                                                          SizeConfig
                                                                              .textMultiplier!,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 0.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                    top: 1.5 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: Text(
                                                                  "Price:",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 2 *
                                                                          SizeConfig
                                                                              .textMultiplier!,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 0.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!,
                                                                    top: 1.5 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: Text(
                                                                  '$price',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 2 *
                                                                          SizeConfig
                                                                              .textMultiplier!,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets.only(left: 6.0 *
                                                                SizeConfig
                                                                    .heightMultiplier!),
                                                            child: IconButton(
                                                              onPressed: () {
                                                                FirebaseFirestore.instance
                                                                    .collection('users')
                                                                    .doc(user!.uid)
                                                                    .collection('SelectedBloodTest')
                                                                    .doc(snapshot.data?.docs[index].id)
                                                                .delete();
                                                              },
                                                              icon: const Icon(
                                                                  Icons.cancel),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    bottom: 2.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: IconButton(
                                                                  onPressed: () {
                                                                    _subCounter();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .minimize),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: 0.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: Text(
                                                                  "$quantity"
                                                                      .replaceAll(
                                                                          ".0", ""),
                                                                  style: TextStyle(
                                                                      color: const Color(
                                                                          0xff00ACB1),
                                                                      fontSize: 1.8 *
                                                                          SizeConfig
                                                                              .textMultiplier!,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    bottom: 0.0 *
                                                                        SizeConfig
                                                                            .heightMultiplier!),
                                                                child: IconButton(
                                                                  onPressed: () {
                                                                    _incrementCounter();
                                                                  },
                                                                  icon: const Icon(
                                                                      Icons.add),
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
                            left: 2.0 * SizeConfig.heightMultiplier!),
                        margin:
                            EdgeInsets.all(2.0 * SizeConfig.heightMultiplier!),
                        height: 15.0 * SizeConfig.heightMultiplier!,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xfff0f0f0),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 1.0 * SizeConfig.heightMultiplier!,
                            ),
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
                                        fontSize:
                                            2 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right:
                                          2.0 * SizeConfig.heightMultiplier!),
                                  child: Text(
                                    "RS.'$price",
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
                                        fontSize:
                                            2 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right:
                                          2.0 * SizeConfig.heightMultiplier!),
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
                                        fontSize:
                                            2 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right:
                                          2.0 * SizeConfig.heightMultiplier!),
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
                      Container(
                          margin: EdgeInsets.only(
                              left: 5.0 * SizeConfig.heightMultiplier!,
                              right: 5.0 * SizeConfig.heightMultiplier!),
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const CheckOut()));
                            },
                            child: Text(
                              "Checkout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    ],
                  )),
            )));
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

  Map<String, dynamic>? paymentIntentData;

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount("20"),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LA7pHKWzDHFbbPHWtKj6uLFk9yRePU0wCJk21BnEfeg3pRC8dtyxhirYNSeMZpIguboCLg5141tRDdKHTq7ArvT004xlHjCDh',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }
}
