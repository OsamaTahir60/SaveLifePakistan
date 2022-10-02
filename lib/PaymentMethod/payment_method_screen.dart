

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:save_life_blood_doner/LabModule/Cart.dart';

import '../plugins/size_config.dart';

class PaymentMethodScreen extends StatelessWidget {
  final double value;
  const PaymentMethodScreen({Key? key, required this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    Map<String, dynamic>? paymentIntentData;
    calculateAmount(String amount) {
      final a = (int.parse(amount)) * 100 ;
      return a.toString();
    }
    displayPaymentSheet() async {

      try {
        await Stripe.instance.presentPaymentSheet(
            parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true,
            )).then((newValue){


          print('payment intent'+paymentIntentData!['id'].toString());
          print('payment intent'+paymentIntentData!['client_secret'].toString());
          print('payment intent'+paymentIntentData!['amount'].toString());
          print('payment intent'+paymentIntentData.toString());
          //orderPlaceApi(paymentIntentData!['id'].toString());
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

          paymentIntentData = null;

        }).onError((error, stackTrace){
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
        paymentIntentData = await createPaymentIntent('20', 'USD'); //json.decode(response.body);
        // print('Response body==>${response.body.toString()}');
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: paymentIntentData!['client_secret'],
                applePay: true,
                googlePay: true,
                testEnv: true,
                style: ThemeMode.dark,
                merchantCountryCode: 'US',
                merchantDisplayName: 'ANNIE')).then((value){
        });
        ///now finally display payment sheeet

        displayPaymentSheet();
      } catch (e, s) {
        print('exception:$e$s');
      }
    }

    //  Future<Map<String, dynamic>>


    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 7.0 * SizeConfig.heightMultiplier!,
          backgroundColor: const Color(0xffFF4A4F),
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Cart()));
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
                        height: 5.0 * SizeConfig.heightMultiplier!,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text('Payment Options',style: TextStyle(
                            color: Colors.black,
                            fontSize: 4.0 * SizeConfig.textMultiplier!),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 10.0 * SizeConfig.heightMultiplier!,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5.0 * SizeConfig.heightMultiplier!,right: 5.0 * SizeConfig.heightMultiplier!),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: TextButton(
                            onPressed: () async {
                              // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              //   content: Text("payment screen"),
                              // ));
                              await makePayment();
                            },
                            child: Text("Pay Rs.$value By Card",
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 2 *SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400
                              ),),
                          )
                      ),
                      SizedBox(
                        height: 10.0 * SizeConfig.heightMultiplier!,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 5.0 * SizeConfig.heightMultiplier!,right: 5.0 * SizeConfig.heightMultiplier!),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: TextButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("EasyPaisa"),
                              ));
                              // await makePayment();
                            },
                            child: Text("Pay Rs.$value By Easypaisa",
                              style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 2 *SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400
                              ),),
                          )
                      ),

                    ],
                  )),
            )));
  }
}

