


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:save_life_blood_doner/BloadModule/Home/Home.dart';
import 'package:save_life_blood_doner/BloadModule/Map/CurrentLocationMap.dart';
import 'package:save_life_blood_doner/plugins/size_config.dart';

class DoneeProfileCompleting extends StatefulWidget {
  const DoneeProfileCompleting({Key? key}) : super(key: key);

  @override
  _DoneeProfileCompletingState createState() => _DoneeProfileCompletingState();
}

class _DoneeProfileCompletingState extends State<DoneeProfileCompleting> {
  String dropdownvalue = 'Select Blood Group';
  final List<String> genderItems = [
    'less then 4 month',
    'less then 8 month',
    'less then 1 year',
    'never',
  ];
  // String selectedDate = "Select Date";
  final _auth = FirebaseAuth.instance;
  String? selectedValue;

  double lat = 0;
  double lng = 0;
  Gender? genders;
  DateTime? dates;
  DateTime? lastdonationdate;

  String Address = 'search';
  String bloodgroup = "";
  var dob = 'Date of birth';

  Gender ?gender;
  // List of items in our dropdown menu
  var items = [
    'Select Blood Group',
    'A+',
    'A-',
    'B-',
    'B+',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  final List<String> _listViewData = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
  ];

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
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
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Home()));
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
                              Container(
                                margin: EdgeInsets.only(left: 2.0 * SizeConfig
                                    .heightMultiplier!, top: 2.0 * SizeConfig
                                    .heightMultiplier!),
                                child: Text("Please Complete",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 3.0 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 2.0 * SizeConfig
                                    .heightMultiplier!, top: 0.0 * SizeConfig
                                    .heightMultiplier!),
                                child: Text("Your Profile!!",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 3.0 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 2.0 * SizeConfig
                                    .heightMultiplier!, top: 3.0 * SizeConfig
                                    .heightMultiplier!),
                                child: Text("Gender",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 2.0 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 2.0 * SizeConfig
                                    .heightMultiplier!, top: 1.0 * SizeConfig
                                    .heightMultiplier!),
                                child: GenderPickerWithImage(
                                  showOtherGender: true,
                                  verticalAlignedText: true,
                                  selectedGender: Gender.Others,
                                  selectedGenderTextStyle: const TextStyle(
                                      color: Color(0xFF8b32a8),
                                      fontWeight: FontWeight.bold),
                                  unSelectedGenderTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                  onChanged: (gender) {
                                    print(gender);
                                    genders = gender;
                                  },
                                  equallyAligned: true,
                                  animationDuration: const Duration(
                                      milliseconds: 300),
                                  isCircular: true,
                                  // default : true,
                                  opacityOfGradient: 0.3,
                                  padding: const EdgeInsets.all(3),
                                  size: 50, //default : 40
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 2.0 *
                                        SizeConfig.heightMultiplier!,
                                        top: 0.0 *
                                            SizeConfig.heightMultiplier!),
                                    child: Text("Blood Group",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 2.0 *
                                            SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 2.0 *
                                        SizeConfig.heightMultiplier!,
                                        top: 0.0 *
                                            SizeConfig.heightMultiplier!),

                                    child: DropdownButton(
                                      // Initial Value
                                      value: dropdownvalue,

                                      // Down Arrow Icon
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down),

                                      // Array list of items
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        );
                                      }).toList(),
                                      // After selecting the desired option,it will
                                      // change button value to selected value
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      },
                                      elevation: 0,

                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 2.0 *
                                        SizeConfig.heightMultiplier!),
                                    child: Text("Select Date Of Birth",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 2.0 *
                                            SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(right: 1.0 *
                                        SizeConfig.heightMultiplier!),
                                    child: TextButton(
                                      onPressed: () {
                                        DatePicker.showDatePicker(
                                          context,
                                            showTitleActions: true,
                                            minTime: DateTime(1947, 1, 1),
                                            maxTime: DateTime.now(),
                                            onConfirm: (date){
                                            var dobString=date.toString();
                                            dob=dobString.substring(0,dobString.indexOf(' '));
                                              print(date);
                                              setState((){
                                                dob=dob;
                                              });
                                            },
                                        );

                                      },
                                      child:Text(
                                        dob,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 1.5 *
                                                SizeConfig.textMultiplier!),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 2.0 *
                                        SizeConfig.heightMultiplier!),
                                    child: Text("Last Donation Date",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 2.0 *
                                            SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0 *SizeConfig.heightMultiplier!),
                                    width: 30 * SizeConfig.widthMultiplier!,
                                    // margin: EdgeInsets.only(left: 22.0 * SizeConfig.heightMultiplier!,right: 22.0 * SizeConfig.heightMultiplier!),
                                    child: DropdownButtonFormField2(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        //Add isDense true and zero Padding.
                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                        isDense: false,
                                        contentPadding: EdgeInsets.zero,
                                        //Add more decoration as you want here
                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                      ),
                                      isExpanded: true,
                                      hint: const Text(
                                        'Select Your Date',
                                        style: TextStyle(fontSize: 10.0 ),
                                      ),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black45,
                                      ),
                                      iconSize: 30,
                                      buttonHeight: 45,
                                      buttonPadding:
                                      const EdgeInsets.only(left: 20, right: 10),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      items: genderItems
                                          .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ))
                                          .toList(),

                                      onChanged: (value) {
                                        //Do something when changing the item if you want.
                                        selectedValue = value.toString();
                                      },
                                      onSaved: (value) {
                                        selectedValue = value.toString();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.0 * SizeConfig.heightMultiplier!,),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 4.0 * SizeConfig.heightMultiplier!,
                                      right: 4.0 * SizeConfig
                                          .heightMultiplier!),
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff00000),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      // Navigator.of(context).pushReplacement(
                                      //     MaterialPageRoute(builder: (context) => const CurrentLocationMap()));
                                      doneeProfile();
                                      // signIn(email.text, password.text);
                                    },
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 3 *
                                              SizeConfig.textMultiplier!),
                                    ),
                                  ))
                            ],
                          ),
                        )
                    ),
                  ],
                )
            )
        )
    );
  }

  void doneeProfile() {
    if (genders == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Select Gender"),
        backgroundColor: Colors.red,
      ));
    }
    else if (dropdownvalue == 'Select Blood Group') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Select Blood Group"),
        backgroundColor: Colors.red,
      ));
    }
    else if (dob == 'null') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Select Age"),
        backgroundColor: Colors.red,
      ));
    }
    else if (selectedValue == 'null') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please Select Last Donation Date"),
        backgroundColor: Colors.red,
      ));
    }

    else {
      print(genders);
      print(dropdownvalue);
      print(dob);
      print(selectedValue);

      User? user = _auth.currentUser;
      var uid = user?.uid;
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        "Gender": genders.toString(),
        "Blood Group": dropdownvalue.toString(),
        "Age": dob.toString(),
        "Last Donation Date": selectedValue.toString(),
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const CurrentLocationMap()));
    }
  }
}