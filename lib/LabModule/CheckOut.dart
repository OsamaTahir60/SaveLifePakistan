
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../plugins/size_config.dart';
import 'Cart.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  bool checkcross1 = false;
  bool checkcross2 = false;
  int value =0 ;
// Reference to the PlatformChannel
  // com.<YOUR_APPLICATION_NAME>/<YOUR_FUNCTION_NAME>
  static const platform = MethodChannel('com.payment_app/performPayment');
// Integrity Salt given by JazzCash
  // The salt is used in coordination with the hashing function
  static const integritySalt = 'b937vxsc1f';
  late String responseString;
  String hashingFunc(Map<String, String> data) {
    Map<String, String> temp = {};
    data.forEach((k, v) {
      if (v != "") v += "&";
      temp[k] = v;
    });

    var sortedKeys = temp.keys.toList(growable: false)
      ..sort((k1, k2) => k1.compareTo(k2));
    Map<String, String> sortedMap = { for (var k in sortedKeys) k : temp[k] as String} ;

    var values = sortedMap.values;
    String toBePrinted = values.reduce((str, ele) => str += ele);
    toBePrinted = toBePrinted.substring(0, toBePrinted.length - 1);
    toBePrinted = integritySalt + '&' + toBePrinted;
    var key = utf8.encode(integritySalt);
    var bytes = utf8.encode(toBePrinted);
    var hash2 = Hmac(sha256, key);
    var digest = hash2.convert(bytes);
    var hash = digest.toString();
    data["pp_SecureHash"] = hash;
    String returnString = "";
    data.forEach((k, v) {
      returnString += k + '=' + v + '&';
    });
    returnString = returnString.substring(0, returnString.length - 1);

    return returnString;
  }

  Future<void> pay() async {
    // Transaction Start Time
    final currentDate = DateFormat('yyyyMMddHHmmss').format(DateTime.now());

    // Transaction Expiry Time
    final expDate = DateFormat('yyyyMMddHHmmss')
        .format(DateTime.now().add(const Duration(minutes: 5)));
    final refNo = 'T' + currentDate.toString();

    // The json map that contains our key-value pairs
    var data = {
      "pp_Amount": "100",
      "pp_BillReference": "billRef",
      "pp_Description": "Description of transaction",
      "pp_Language": "EN",
      "pp_MerchantID": "MC46413",
      "pp_Password": "693uvx8vfw",
      "pp_ReturnURL": "http//localhost/case.php",
      "pp_TxnCurrency": "PKR",
      "pp_TxnDateTime": currentDate,
      "pp_TxnExpiryDateTime": expDate,
      "pp_TxnRefNo": refNo,
      "pp_TxnType": "",
      "pp_Version": "1.1",
      "pp_BankID": "TBANK",
      "pp_ProductID": "RETL",
      "ppmpf_1": "1",
      "ppmpf_2": "2",
      "ppmpf_3": "3",
      "ppmpf_4": "4",
      "ppmpf_5": "5",
    };
    // String postData = hashingFunc(data);

    try {
      // Trigger native code through channel method
      // The first arguemnt is the name of method that is invoked
      // The second argument is the data passed to the method as input
      final result = await platform.invokeMethod('performPayment', { "postData" : hashingFunc(data) }
      );

      // Await for response from above before moving on
      // The response contains the result of the transaction
      responseString = result.toString();
      print("responseString");
    } on PlatformException catch (e) {
      // On Channel Method Invocation Failure
      print("PLATFORM_EXCEPTION: ${e.message.toString()}");
    }

    // Parse the response now
    List<String> responseStringArray = responseString.split('&');
    Map<String, String> response = {};
    for (var e in responseStringArray) {
      if (e.isNotEmpty) {
        e.trim();
        final c = e.split('=');
        response[c[0]] = c[1];
      }
    }
// Use the transaction response as needed now
    print(response);
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
                  child: PageView(
                    controller: _controller,
                    children: [
                      Shipping(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2.0 * SizeConfig.heightMultiplier!),
                            alignment: Alignment.topLeft,
                            child: Text("Select Payment Method",
                              style: TextStyle(
                                  color:Colors.black,
                                  fontSize: 1.9 *SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                value = 1;

                                if(checkcross1 == false){
                                  checkcross1 = true;
                                }
                                else if(checkcross1 == true){
                                  checkcross1 = false;
                                }
                              });
                            },
                            child: Container(
                              width: 100.0 * SizeConfig.widthMultiplier!,
                              padding: EdgeInsets.only(
                                  left: 2.0 *
                                      SizeConfig
                                          .heightMultiplier!),
                              margin: EdgeInsets.all(2.0 *
                                  SizeConfig
                                      .heightMultiplier!),
                              height: 8.0 *
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 0 * SizeConfig.heightMultiplier!),
                                    child: Text("Cash on delivery",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 2.0 * SizeConfig.textMultiplier!,
                                      ),
                                    ),
                                  ),
                                  checkcross1 == true && value == 1 ? IconButton(
                                    onPressed: () {
                                      // FirebaseFirestore.instance
                                      //     .collection('users')
                                      //     .doc(user!.uid)
                                      //     .collection('SelectedBloodTest')
                                      //     .doc(snapshot.data?.docs[index].id)
                                      //     .delete();
                                    },
                                    icon: const Icon(
                                        Icons.task_alt_rounded),
                                  ): Container()
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                value = 2;
                                if(checkcross2 == false ){
                                  checkcross2= true;
                                }
                                else if(checkcross2 == true){
                                  checkcross2 = false;
                                }
                              });
                            },
                            child: Container(
                              width: 100.0 * SizeConfig.widthMultiplier!,
                              padding: EdgeInsets.only(
                                  left: 2.0 *
                                      SizeConfig
                                          .heightMultiplier!),
                              margin: EdgeInsets.all(2.0 *
                                  SizeConfig
                                      .heightMultiplier!),
                              height: 8.0 *
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 0 * SizeConfig.heightMultiplier!),
                                    child: Text("Pay with easypaisa",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 2.0 * SizeConfig.textMultiplier!,
                                      ),
                                    ),
                                  ),
                                  checkcross2 == true && value == 2? IconButton(
                                    onPressed: () {
                                      pay();
                                      print("s");
                                      // FirebaseFirestore.instance
                                      //     .collection('users')
                                      //     .doc(user!.uid)
                                      //     .collection('SelectedBloodTest')
                                      //     .doc(snapshot.data?.docs[index].id)
                                      //     .delete();
                                    },
                                    icon: const Icon(
                                        Icons.task_alt_rounded),
                                  ): Container()
                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                      Placed(),
                    ],
                  )),
            )));
  }
}

class Shipping extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Container(
        padding: EdgeInsets.all(2.0 * SizeConfig.heightMultiplier!),
        alignment: Alignment.topLeft,
        child: Text("Select Sample address",
        style: TextStyle(
            color:Colors.black,
            fontSize: 1.9 *SizeConfig.textMultiplier!,
            fontWeight: FontWeight.w400
        ),
          textAlign: TextAlign.start,
        ),
      ),
        Container(
          padding: EdgeInsets.all(
              2.0 *
                  SizeConfig
                      .heightMultiplier!),
          margin: EdgeInsets.all(2.0 *
              SizeConfig
                  .heightMultiplier!),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(
                15),
            color:
            const Color(0xfff0f0f0),
          ),
          height: 15.0 *
              SizeConfig
                  .heightMultiplier!,
          width: 43.0 *
            SizeConfig
                .heightMultiplier!,
          child: Text("location"),
        )
      ],
    );
  }
}
class Placed extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
