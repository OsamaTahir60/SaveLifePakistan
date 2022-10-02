import 'package:animated_type_ahead_searchbar/animated_type_ahead_searchbar.dart';
import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:save_life_blood_doner/LabModule/booking_lab.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../BloadModule/Home/Home.dart';
import '../plugins/size_config.dart';

class ShowLab extends StatefulWidget {
  const ShowLab({Key? key}) : super(key: key);

  @override
  _ShowLabState createState() => _ShowLabState();
}

class _ShowLabState extends State<ShowLab> {
  List dropdownItemList = [];

  final _controller = PageController();

  final List<String> genderItems = [
    'Blood Sugar Random',
    'Blood Sugar Faster',
    'HBAIC',
    'OGTT',
    'Capillary blood Glucose',
    'Urine Test for Blood Sugar ',
  ];

  String? selectedValue;
  bool _isBackPressedOrTouchedOutSide1 = false,
      _isDropDownOpened1 = false,
      _isPanDown1 = false;

  bool _isBackPressedOrTouchedOutSide2 = false,
      _isDropDownOpened2 = false,
      _isPanDown2 = false;

  bool _isBackPressedOrTouchedOutSide3 = false,
      _isDropDownOpened3 = false,
      _isPanDown3 = false;

  bool _isBackPressedOrTouchedOutSide4 = false,
      _isDropDownOpened4 = false,
      _isPanDown4 = false;

  late List<String> _list;
  late List<String> _list2;
  late List<String> _list3;
  late List<String> _list1;

  String _selectedItem = '';
  String _selectedItem1 = '';

  String _selectedItem2 = '';
  String _selectedItem3 = '';
  final List searchData = const [
    'Blood',
    'Lab Test',
    'Cake',
    'Maracas',
    'Clarinet',
    'Odyssey',
    'Slide Whistle',
    'Piano',
  ];

  @override
  void initState() {
    _list1 = [
      "Blood Sugar Random",
      "Blood Sugar Faster",
      "OGTT",
      "Capillary blood Glucose",
      "Urine Test for Blood Sugar",
      "Trop T",
      "Trop I",
      "CKMB",
      "CPK",
      "LDH",
      "AST",
      "Lipid Profile",
      "Total Bilirobin",
      "Direct Bilirobin",
      "Indirect Bilirobin",
      "ALT",
      "AST",
      " ALP",
      'Gamma GT',
      "Total Protein",
      "Albumin"
    ];
    _selectedItem1 = 'Blood Test';

    _list = [
      "Blood Sugar Random",
      "Blood Sugar Faster",
      "OGTT",
      "Capillary blood Glucose",
      "Urine Test for Blood Sugar "
    ];
    _selectedItem = '(Diabetes)TEST';

    _list2 = ["Trop T", "Trop I", "CKMB", "CPK", "LDH", "AST", "Lipid Profile"];
    _selectedItem2 = '(Cardioc profile)TEST';

    _list3 = [
      "Total Bilirobin",
      "Direct Bilirobin",
      "Indirect Bilirobin",
      "ALT",
      "AST",
      " ALP",
      'Gamma GT',
      "Total Protein",
      "Albumin"
    ];

    _selectedItem3 = '(Liver Function)profile';
    super.initState();
  }
  var selec='';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _removeFocus,
      onPanDown: (focus){
        _isPanDown1 = true;
        _isPanDown2 = true;
        _isPanDown3 = true;
        _isPanDown4 = true;
        _removeFocus();
      },
      child: Scaffold(
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
                                  margin:EdgeInsets.only(left: 2.0 * SizeConfig.heightMultiplier!),
                                  child: AnimatedTypeAheadSearchBar(
                                    width: MediaQuery.of(context).size.width * 0.88,
                                    onSuffixTap: null,
                                    itemBuilder: (String suggestion) {
                                      return Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        borderOnForeground: false,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  suggestion,
                                                  overflow: TextOverflow.visible,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    onSuggestionSelected: (suggestion) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const Home()));
                                      FocusScope.of(context).unfocus();
                                    },
                                    suggestionCallback: (String pattern) {
                                      List<String> suggestions = [];
                                      if (pattern.length < 2) return suggestions;
                                      for (var i = 0; i < searchData.length; i++) {
                                        if (searchData[i]
                                            .toLowerCase()
                                            .contains(pattern.toLowerCase())) {
                                          suggestions.add(searchData[i]);
                                        }
                                      }
                                      return suggestions;
                                    },
                                  ),
                                ),
                                Container(
                                    height: 25.0 * SizeConfig.heightMultiplier!,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          stops: [
                                            0.5,
                                            0.9
                                          ],
                                          colors: [
                                            Colors.white,
                                            Color(0xffFF6666)
                                          ]),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              height: 23.0 *
                                                  SizeConfig.heightMultiplier!,
                                              width: 45.0 *
                                                  SizeConfig.widthMultiplier!,
                                              margin: EdgeInsets.all(1.0 *
                                                  SizeConfig.heightMultiplier!),
                                              child: ListView(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.all(1.0 *
                                                        SizeConfig
                                                            .heightMultiplier!),
                                                    child: Text(
                                                      "LAB Test At Your Home",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 1.8 *
                                                              SizeConfig
                                                                  .textMultiplier!,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        child: Image.asset(
                                                            'assets/true.png'),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.all(1.0 *
                                                            SizeConfig
                                                                .heightMultiplier!),
                                                        child: Text(
                                                          "Get Delivered at Home",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 1.3 *
                                                                  SizeConfig
                                                                      .textMultiplier!,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        child: Image.asset(
                                                            'assets/true.png'),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.all(1.0 *
                                                            SizeConfig
                                                                .heightMultiplier!),
                                                        child: Text(
                                                          "Convenient home Sampling",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 1.3 *
                                                                  SizeConfig
                                                                      .textMultiplier!,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 30,
                                                        child: Image.asset(
                                                            'assets/true.png'),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.all(1.0 *
                                                            SizeConfig
                                                                .heightMultiplier!),
                                                        child: Text(
                                                          "Exclusive Discount",
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 1.3 *
                                                                  SizeConfig
                                                                      .textMultiplier!,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              height: 10.0 *
                                                  SizeConfig.heightMultiplier!,
                                              margin: EdgeInsets.all(2.0 *
                                                  SizeConfig.heightMultiplier!),
                                              child: Image.asset(
                                                'assets/doctorcheck.png',
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 2.0 * SizeConfig.heightMultiplier!,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [
                                              0.5,
                                              0.9
                                            ],
                                            colors: [
                                              Colors.white,
                                              Color(0xffFF6666)
                                            ]),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                              height: 30,
                                              child: Icon(Icons.info_outlined)),
                                          Container(
                                            margin: EdgeInsets.all(1.0 *
                                                SizeConfig.heightMultiplier!),
                                            child: Text(
                                              "Need Help for Booking",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 1.5 *
                                                      SizeConfig.textMultiplier!,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [
                                              0.5,
                                              0.9
                                            ],
                                            colors: [
                                              Colors.white,
                                              Color(0xffFF6666)
                                            ]),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                              height: 30,
                                              child: Icon(Icons.info_outlined)),
                                          Container(
                                            margin: EdgeInsets.all(1.0 *
                                                SizeConfig.heightMultiplier!),
                                            child: Text(
                                              "Booking Procedure",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 1.5 *
                                                      SizeConfig.textMultiplier!,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // CoolDropdown(
                                //   dropdownList: dropdownItemList,
                                //   onChange: (selectedItem) {
                                //     print(selectedItem);
                                //   },
                                //   onOpen: (isOpen) {
                                //     print('$isOpen');
                                //   },
                                //   dropdownBD: BoxDecoration(
                                //       color: Colors.white, border: Border.all(width: 2)),
                                // ),
                                Container(
                                  margin: EdgeInsets.all(
                                      2.0 * SizeConfig.heightMultiplier!),
                                  child: Text(
                                    "Top Booked Lab Tests",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 2 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),

                                SizedBox(
                                  height: 10.0 * SizeConfig.heightMultiplier!,
                                  child: PageView(
                                    controller: _controller,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadiusDirectional.circular(15)),
                                            elevation: 5.0,
                                            child: SizedBox(
                                              width: 37.0 *
                                                  SizeConfig.widthMultiplier!,
                                              height: 7.5 *
                                                  SizeConfig.heightMultiplier!,
                                              child: Center(
                                                child: AwesomeDropDown(
                                                  isPanDown: _isPanDown1,
                                                  isBackPressedOrTouchedOutSide:
                                                  _isBackPressedOrTouchedOutSide1,
                                                  dropDownBGColor: Colors.white,
                                                  dropDownOverlayBGColor:
                                                  Colors.transparent,
                                                  padding: 0,
                                                  dropDownIcon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Colors.transparent,
                                                    size: 23,
                                                  ),
                                                  elevation: 0,
                                                  dropDownBorderRadius: 10,
                                                  dropDownTopBorderRadius: 50,
                                                  dropDownBottomBorderRadius: 50,
                                                  dropDownIconBGColor:
                                                  Colors.transparent,
                                                  dropDownList: _list1,
                                                  selectedItem: _selectedItem1,
                                                  numOfListItemToShow: 6,
                                                  selectedItemTextStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 1.7 *
                                                          SizeConfig
                                                              .textMultiplier!,
                                                      fontWeight: FontWeight.bold),
                                                  dropDownListTextStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 2.0 *
                                                          SizeConfig
                                                              .textMultiplier!,
                                                      backgroundColor:
                                                      Colors.transparent),
                                                  onDropDownItemClick:
                                                      (selectedItem) {
                                                    _selectedItem = selectedItem;
                                                    print(selectedItem);
                                                    _selectedItem !=
                                                        "(Diabetes)TEST"
                                                        ? Navigator.of(context).push(
                                                        MaterialPageRoute(builder: (context) =>
                                                        BookingLab(value: _selectedItem)
                                                        )
                                                    )
                                                        : Container();
                                                  },
                                                  dropStateChanged: (isOpened) {
                                                    _isDropDownOpened1 = isOpened;
                                                    if (!isOpened) {
                                                      _isBackPressedOrTouchedOutSide1 =
                                                      false;
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(15)),
                                            elevation: 5.0,
                                            child: SizedBox(
                                              height: 7.5 *
                                                  SizeConfig.heightMultiplier!,
                                              width: 37.0 *
                                                  SizeConfig.widthMultiplier!,
                                              child: AwesomeDropDown(
                                                isPanDown: _isPanDown2,
                                                isBackPressedOrTouchedOutSide:
                                                _isBackPressedOrTouchedOutSide2,
                                                dropDownBGColor: Colors.white,
                                                dropDownOverlayBGColor:
                                                Colors.transparent,
                                                padding: 0,
                                                dropDownIcon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.transparent,
                                                  size: 23,
                                                ),
                                                elevation: 0,
                                                dropDownBorderRadius: 10,
                                                dropDownTopBorderRadius: 50,
                                                dropDownBottomBorderRadius: 50,
                                                dropDownIconBGColor:
                                                Colors.transparent,
                                                dropDownList: _list,
                                                selectedItem: _selectedItem,
                                                numOfListItemToShow: 4,
                                                selectedItemTextStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 1.7 *
                                                      SizeConfig.textMultiplier!,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                dropDownListTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 2.0 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    backgroundColor:
                                                    Colors.transparent),
                                                onDropDownItemClick:
                                                    (selectedItem) {
                                                  _selectedItem = selectedItem;
                                                  _selectedItem !=
                                                      "(Diabetes)TEST"
                                                      ? Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                       BookingLab(value: _selectedItem)))
                                                      : Container();
                                                },
                                                dropStateChanged: (isOpened) {
                                                  _isDropDownOpened2 = isOpened;
                                                  if (!isOpened) {
                                                    _isBackPressedOrTouchedOutSide2 =
                                                    false;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(15)),
                                            elevation: 5.0,
                                            child: SizedBox(
                                              height: 7.5 *
                                                  SizeConfig.heightMultiplier!,
                                              width: 32.0 *
                                                  SizeConfig.widthMultiplier!,
                                              child: AwesomeDropDown(
                                                isPanDown: _isPanDown3,
                                                isBackPressedOrTouchedOutSide:
                                                _isBackPressedOrTouchedOutSide3,
                                                dropDownBGColor: Colors.white,
                                                dropDownOverlayBGColor:
                                                Colors.transparent,
                                                padding: 0,
                                                dropDownIcon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.transparent,
                                                  size: 23,
                                                ),
                                                elevation: 0,
                                                dropDownBorderRadius: 10,
                                                dropDownTopBorderRadius: 50,
                                                dropDownBottomBorderRadius: 50,
                                                dropDownIconBGColor:
                                                Colors.transparent,
                                                dropDownList: _list2,
                                                selectedItem: _selectedItem2,
                                                numOfListItemToShow: 4,
                                                selectedItemTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 2.0 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    fontWeight: FontWeight.bold),
                                                dropDownListTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 1.7 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    backgroundColor:
                                                    Colors.transparent),
                                                onDropDownItemClick:
                                                    (selectedItem) {
                                                  _selectedItem = selectedItem;
                                                  _selectedItem !=
                                                      "(Diabetes)TEST"
                                                      ? Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                       BookingLab(value: _selectedItem)))
                                                      : Container();
                                                },
                                                dropStateChanged: (isOpened) {
                                                  _isDropDownOpened3 = isOpened;
                                                  if (!isOpened) {
                                                    _isBackPressedOrTouchedOutSide3 =
                                                    false;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(15)),
                                            elevation: 5.0,
                                            child: SizedBox(
                                              height: 7.5 *
                                                  SizeConfig.heightMultiplier!,
                                              width: 32.0 *
                                                  SizeConfig.widthMultiplier!,
                                              child: AwesomeDropDown(
                                                isPanDown: _isPanDown4,
                                                isBackPressedOrTouchedOutSide:
                                                _isBackPressedOrTouchedOutSide4,
                                                dropDownBGColor: Colors.white,
                                                dropDownOverlayBGColor:
                                                Colors.transparent,
                                                dropDownIcon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Colors.transparent,
                                                  size: 23,
                                                ),
                                                elevation: 0,
                                                dropDownBorderRadius: 10,
                                                dropDownTopBorderRadius: 50,
                                                dropDownBottomBorderRadius: 50,
                                                dropDownIconBGColor:
                                                Colors.transparent,
                                                dropDownList: _list3,
                                                selectedItem: _selectedItem3,
                                                numOfListItemToShow: 4,
                                                selectedItemTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 1.7 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    fontWeight: FontWeight.bold),
                                                dropDownListTextStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 2.0 *
                                                        SizeConfig
                                                            .textMultiplier!,
                                                    backgroundColor:
                                                    Colors.transparent),
                                                onDropDownItemClick:
                                                    (selectedItem) {
                                                  _selectedItem = selectedItem;
                                                  _selectedItem !=
                                                      "(Diabetes)TEST"
                                                      ? Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                       BookingLab(value: _selectedItem)))
                                                      : Container();
                                                },
                                                dropStateChanged: (isOpened) {
                                                  _isDropDownOpened4 = isOpened;
                                                  if (!isOpened) {
                                                    _isBackPressedOrTouchedOutSide4 =
                                                    false;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0 * SizeConfig.heightMultiplier!,
                                ),
                                Center(
                                    child: SmoothPageIndicator(
                                      controller: _controller,
                                      count: 2,
                                      axisDirection: Axis.horizontal,
                                      effect: const SlideEffect(
                                          spacing: 5.0,
                                          radius: 4.0,
                                          dotHeight: 9.0,
                                          dotWidth: 9.0,
                                          paintStyle: PaintingStyle.stroke,
                                          strokeWidth: 0.5,
                                          dotColor: Colors.grey,
                                          activeDotColor: Colors.indigo),
                                    )),

                                Container(
                                  margin: EdgeInsets.all(
                                      2.0 * SizeConfig.heightMultiplier!),
                                  child: Text(
                                    "Accredited Labs",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 2 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.0 * SizeConfig.heightMultiplier!,
                                      width: 35.0 * SizeConfig.widthMultiplier!,
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadiusDirectional.circular(
                                                15)),
                                        child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                  child:
                                                  Image.asset('assets/true.png'),
                                                ),
                                                SizedBox(
                                                  height: 1.0 *
                                                      SizeConfig.heightMultiplier!,
                                                ),
                                                Text(
                                                  "Save Life Pakistan ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 2 *
                                                          SizeConfig.textMultiplier!,
                                                      fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0 * SizeConfig.heightMultiplier!,
                                      width: 35.0 * SizeConfig.widthMultiplier!,
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadiusDirectional.circular(
                                                15)),
                                        child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 30,
                                                  child:
                                                  Image.asset('assets/true.png'),
                                                ),
                                                SizedBox(
                                                  height: 1.0 *
                                                      SizeConfig.heightMultiplier!,
                                                ),
                                                Text(
                                                  "Save Life Pakistan ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 2 *
                                                          SizeConfig.textMultiplier!,
                                                      fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.0 * SizeConfig.heightMultiplier!,
                                ),
                              ],
                            ),
                          )),
                    ],
                  )))),
    );
  }

  void _removeFocus(){
    if(_isDropDownOpened1){
      setState(() {
        _isBackPressedOrTouchedOutSide1 = true;
      });
    }
    if(_isDropDownOpened2){
      setState(() {
        _isBackPressedOrTouchedOutSide2 = true;
      });
    }
    if(_isDropDownOpened3){
      setState(() {
        _isBackPressedOrTouchedOutSide3 = true;
      });
    }
    if(_isDropDownOpened4){
      setState(() {
        _isBackPressedOrTouchedOutSide4 = true;
      });
    }
  }
}
