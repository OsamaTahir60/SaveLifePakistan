

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:save_life_blood_doner/Login/login.dart';
import 'package:save_life_blood_doner/SwipeUp.dart';
import 'package:save_life_blood_doner/model/user_model.dart';
import 'package:save_life_blood_doner/plugins/size_config.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController savelifeid = TextEditingController();
  TextEditingController address = TextEditingController();

  double lat = 0;
  double lng = 0;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey _scaffold = GlobalKey();
  bool _isHidden = true;
  String? errorMessage;
  // String location2 = 'Null, Press Button';
  String Address = 'search';
  final _auth = FirebaseAuth.instance;
  String location ='Null, Press Button';

  // Future<Position> _getGeoLocationPosition() async {
  //   bool serviceEnabled;
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   var status = await Permission.location.status;
  //   if(await Permission.location.serviceStatus.isEnabled){
  //     if(status.isGranted){
  //       Map<Permission, PermissionStatus> status =await[Permission.location].request();
  //       getaddress();
  //     }
  //     else if(status.isDenied){
  //       if(await Permission.location.isPermanentlyDenied) {
  //         const LocationSettings();
  //       }
  //     }
  //   }
  //   else{
  //
  //   }
  //   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }

  //
  // getaddress() async {
  //   Position position = await _getGeoLocationPosition();
  //   location ='Lat: ${position.latitude} , Long: ${position.longitude}';
  //   GetAddressFromLatLong(position);
  // }


  late AnimationController _controller;
   Animation<double> ?_animation;

   getloc() async {
     // Location location = Location();

     bool _serviceEnabled = await Geolocator.isLocationServiceEnabled();
     LocationPermission permission;

     if (!_serviceEnabled) {
       _serviceEnabled = await Geolocator.isLocationServiceEnabled();
     }

     permission  = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       getloc();
       if (permission == LocationPermission.denied) {
         return;
       }
     }
      await Geolocator.getCurrentPosition();
     Position? position = await Geolocator.getCurrentPosition();
     lat = position.latitude;
     lng = position.longitude;
     GetAddressFromLatLong(position);
   }
  Future GetAddressFromLatLong(Position position)async {
    List placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.street}, ${place.administrativeArea}, ${place.locality}, ${place
        .postalCode}, ${place.country}';
    setState(() {});
  }

    @override
  void initState() {
    super.initState();
    getloc();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(
          () {
        setState(() {});
      },
    )..addStatusListener(
          (status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      },
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.red,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.4,
                  0.8
                ],
                colors: [
                  Colors.white,
                  Color(0xffFF6666),
                ]),
          ),
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: ListView(
              children: [
                SizedBox(
                  height: 1.0 * SizeConfig.heightMultiplier!,
                ),
                SlideFadeTransition(
                  curve: Curves.elasticOut,
                  delayStart: const Duration(milliseconds: 500),
                  animationDuration: const Duration(milliseconds: 1200),
                  offset: 0.2,
                  direction: Direction.horizontal,
                  child: Container(
                      height: 15.0 * SizeConfig.heightMultiplier!,
                      margin:
                      EdgeInsets.only(left: 2.0 * SizeConfig.heightMultiplier!),
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(3.0 * SizeConfig.heightMultiplier!),
                        child: const Image(
                            image: AssetImage(
                              'assets/save life logo icon.png',
                            )),
                      )),
                ),
                SizedBox(
                  height: 0.5 * SizeConfig.heightMultiplier!,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 8.0 * SizeConfig.heightMultiplier!,
                          margin: EdgeInsets.only(
                              left: 4 * SizeConfig.heightMultiplier!,
                              right: 4 * SizeConfig.heightMultiplier!),
                          decoration: BoxDecoration(
                            color: const Color(0xffEFEFEF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            autofillHints: const [AutofillHints.name],
                            controller: name,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{3,}$');
                              if (value!.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Name cannot be Empty"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              if (!regex.hasMatch(value)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text("Enter Valid name(Min. 3 Character)"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              return null;
                            },
                            onSaved: (value) {
                              name.text = value!;
                            },
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 2.0  * SizeConfig.textMultiplier!,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 2 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400),
                              filled: true,
                              fillColor: const Color(0xffEFEFEF),
                              contentPadding: EdgeInsets.all(
                                  2.5 * SizeConfig.heightMultiplier!),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.0 * SizeConfig.heightMultiplier!,
                        ),
                        Container(
                          height: 8.0 * SizeConfig.heightMultiplier!,
                          margin: EdgeInsets.only(
                              left: 4 * SizeConfig.heightMultiplier!,
                              right: 4 * SizeConfig.heightMultiplier!),
                          decoration: BoxDecoration(
                            color: const Color(0xffEFEFEF),
                            borderRadius: BorderRadius.circular(30),
                          ),

                          child: TextFormField(
                            autofillHints: const [AutofillHints.email],
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 2.0  * SizeConfig.textMultiplier!,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Please Enter Your Email"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              // reg expression for email validation
                              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Please Enter a valid email"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              return null;
                            },
                            onSaved: (value) {
                              email.text = value!;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 2.0 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400),
                              filled: true,
                              fillColor: const Color(0xffEFEFEF),
                              contentPadding: EdgeInsets.all(
                                  2.5 * SizeConfig.heightMultiplier!),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.0 * SizeConfig.heightMultiplier!,
                        ),
                        Container(
                          height: 8.0 * SizeConfig.heightMultiplier!,
                          margin: EdgeInsets.only(
                              left: 4 * SizeConfig.heightMultiplier!,
                              right: 4 * SizeConfig.heightMultiplier!),
                          decoration: BoxDecoration(
                            color: const Color(0xffEFEFEF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.telephoneNumber],
                            keyboardType: TextInputType.phone,
                            controller: phone,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 2.0  * SizeConfig.textMultiplier!,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Phone Cannot Empty"),
                                  backgroundColor: Colors.red,
                                ));
                              } else {
                                return null;
                              }
                              return null;
                            },
                            onSaved: (value) {
                              phone.text = value!;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Phone',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 2.0 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400),
                              filled: true,
                              fillColor: const Color(0xffEFEFEF),
                              contentPadding: EdgeInsets.all(
                                  2.5 * SizeConfig.heightMultiplier!),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.0 * SizeConfig.heightMultiplier!,
                        ),
                        Container(
                          height: 8.0 * SizeConfig.heightMultiplier!,
                          margin: EdgeInsets.only(
                              left: 4 * SizeConfig.heightMultiplier!,
                              right: 4 * SizeConfig.heightMultiplier!),
                          decoration: BoxDecoration(
                            color: const Color(0xffEFEFEF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isHidden,
                            controller: password,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 2.0  * SizeConfig.textMultiplier!,
                            ),
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Password is required"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              if (!regex.hasMatch(value)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "Enter Valid Password(Min. 6 Character)"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password.text = value!;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 2.0 * SizeConfig.textMultiplier!,),
                              suffixIcon: InkWell(
                                onTap: _togglePasswordView,
                                child: Icon(
                                  _isHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              filled: true,
                              fillColor: const Color(0xffEFEFEF),
                              contentPadding: EdgeInsets.all(
                                  2.5 * SizeConfig.heightMultiplier!),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.0 * SizeConfig.heightMultiplier!,
                        ),
                        Container(
                          height: 8.0 * SizeConfig.heightMultiplier!,
                          margin: EdgeInsets.only(
                              left: 4 * SizeConfig.heightMultiplier!,
                              right: 4 * SizeConfig.heightMultiplier!),
                          decoration: BoxDecoration(
                            color: const Color(0xffEFEFEF),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            controller: savelifeid,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 2.0  * SizeConfig.textMultiplier!,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Save-Life id Cannot Empty"),
                                  backgroundColor: Colors.red,
                                ));
                              }
                              return null;
                            },
                            onSaved: (value) {
                              savelifeid.text = value!;
                            },

                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Choose Save life ID',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 2.0 * SizeConfig.textMultiplier!,
                                  fontWeight: FontWeight.w400),
                              filled: true,
                              fillColor: const Color(0xffEFEFEF),
                              contentPadding: EdgeInsets.all(
                                  2.5 * SizeConfig.heightMultiplier!),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xffEFEFEF)),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.0 * SizeConfig.heightMultiplier!,
                        ),
                        Container(
                          height: 8.0 * SizeConfig.heightMultiplier!,
                          width: 100.0 * SizeConfig.widthMultiplier!,
                          margin: EdgeInsets.only(
                              left: 4 * SizeConfig.heightMultiplier!,
                              right: 4 * SizeConfig.heightMultiplier!),
                          decoration: BoxDecoration(
                            color: const Color(0xffEFEFEF),
                            borderRadius: BorderRadius.circular(30),
                          ),

                          padding: EdgeInsets.only(
                              left: 2.7 * SizeConfig.heightMultiplier!,
                              top: 2.5 * SizeConfig.heightMultiplier!),
                          child: Address != "search"
                              ? Text(
                                  Address,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 2.0 * SizeConfig.textMultiplier!,
                                      fontWeight: FontWeight.w400),
                                )
                              : Text(
                                  "No Address Found",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 2.0 * SizeConfig.textMultiplier!,
                                      fontWeight: FontWeight.w400),
                                ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 2.0 * SizeConfig.heightMultiplier!,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0 * SizeConfig.heightMultiplier!,right: 5.0 * SizeConfig.heightMultiplier!),
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: TextButton(
                      onPressed: () {
                        signUp(email.text, password.text);
                      },
                      child: Text("SIGN-UP",
                        style: TextStyle(
                            color:Colors.white,
                            fontSize: 1.9 *SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w400
                        ),),
                    )
                ),
              ],
            ),
          ),
        )
    );
  }


  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()});
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "Please Check Credentials.";
        }
         Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = email.text;
    userModel.name = name.text;
    userModel.phone = phone.text;
    userModel.savelifeid = savelifeid.text;
    userModel.longitude = lat;
    userModel.latitude = lng;

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .set(userModel.toMap());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Account created successfully :) "),
      backgroundColor: Colors.red,
    ));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }
}
