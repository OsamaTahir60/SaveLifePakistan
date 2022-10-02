

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:save_life_blood_doner/BloadModule/Home/Home.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../plugins/size_config.dart';

class CurrentLocationMap extends StatefulWidget {
  const CurrentLocationMap({Key? key}) : super(key: key);

  @override
  _CurrentLocationMapState createState() => _CurrentLocationMapState();
}


class _CurrentLocationMapState extends State<CurrentLocationMap> {
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GeoPoint? latlng;
  String Bloodtype = "";
  String? lat;
  String? lng;
   int selectedIndex =0;
  Color firstColor = Colors.white;
  bool isActive = false;
  List<String> group = ['A+', 'A-','B+','B-','O+','O-','AB+','AB-'];

  Marker myMarker = Marker(
    markerId: const MarkerId('myMarker'),
    position: const LatLng(
      37.419857,
      -122.078827,
    ),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    infoWindow: const InfoWindow(title: 'Your Location'),
    onTap: () {
      print('Your Location');
    },
  );

  void getLocation() async {
    const myMarkerId = MarkerId('myMarker');

    var location = await currentLocation.getLocation();

    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0),
      zoom: 15.0,
    )));

    currentLocation.onLocationChanged.listen((LocationData loc) {
      myMarker = myMarker!
          .copyWith(positionParam: LatLng(loc.latitude!, loc.longitude!));

      print(loc.latitude);
      print(loc.longitude);

      Marker myMarkerNow = Marker(
        markerId: const MarkerId('myMarker'),
        position: LatLng(
          loc.latitude!,
          loc.longitude!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        infoWindow: const InfoWindow(title: 'Your Location'),
        onTap: () {
          print('Your Location');
        },
      );

      setState(() {
        markers[myMarkerId] = myMarkerNow;
        //markers[myMarkerId] = markers[myMarkerId]!.copyWith(positionParam: LatLng(loc.latitude!, loc.longitude!));
      });

      StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('location')
            // .where('uid', isEqualTo: user?.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (listContext, index) {
                latlng = snapshot.data?.docs[index]['latlng'];
                lat = latlng?.latitude.toString();
                lng = latlng?.longitude.toString();

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return GetLatLng();
                } else {
                  return Text(
                    'State: ${snapshot.connectionState}',
                    style: const TextStyle(color: Colors.black, fontSize: 50.0),
                  );
                }
              });
        },
      );
    });
  }

  int val = 20;
  int _value = 0;
  late bool select;
  @override
  void initState() {
    super.initState();
    setState(() {
      getLocation();
    });
  }
  bool selectvalue1 = false ;
  bool selectvalue2= false ;
  bool selectvalue3 = false ;
  bool selectvalue4 = false ;
  bool selectvalue5 = false ;
  bool selectvalue6 = false ;
  bool selectvalue7 = false ;
  bool selectvalue8 = false ;
  bool selectvaluehopital = false ;
  bool selectvaluebloodbank = false ;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<Users> selectedUserList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
            backgroundColor: const Color(0xffFF193B),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            width: double.maxFinite,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                      child: ListView(
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Wrap(
                                              spacing: 3.0,
                                              children: [
                                                FilterChip(
                                                  label: Text("A+"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvalue1,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvalue1= true;
                                                      }
                                                      else{
                                                        selectvalue1= false;
                                                      }
                                                    });
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text("A-"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvalue2,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvalue2= true;
                                                      }
                                                      else{
                                                        selectvalue2= false;
                                                      }
                                                    });
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text("B+"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvalue3,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvalue3= true;
                                                      }
                                                      else{
                                                        selectvalue3= false;
                                                      }
                                                    });
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text("B-"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvalue4,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvalue4= true;
                                                      }
                                                      else{
                                                        selectvalue4= false;
                                                      }
                                                    });
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text("AB+"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvalue5,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvalue5= true;
                                                      }
                                                      else{
                                                        selectvalue5= false;
                                                      }
                                                    });
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text("AB-"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvalue6,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvalue6= true;
                                                      }
                                                      else{
                                                        selectvalue6= false;
                                                      }
                                                    });
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text("O+"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvalue7,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvalue7= true;
                                                      }
                                                      else{
                                                        selectvalue7= false;
                                                      }
                                                    });
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text("O-"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvalue8,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvalue8= true;
                                                      }
                                                      else{
                                                        selectvalue8= false;
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Wrap(
                                              spacing: 3.0,
                                              children: [
                                                FilterChip(
                                                  label: Text("Hospital"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvaluehopital,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(selectvalue1 && selectvalue2 && selectvalue3 && selectvalue4 && selectvalue5 && selectvalue6 && selectvalue7 && selectvalue8 == false){
                                                        if(value){
                                                          selectvaluehopital= true;
                                                        }
                                                        else{
                                                          selectvaluehopital= false;
                                                        }
                                                      }
                                                      else{

                                                      }
                                                    });
                                                  },
                                                ),
                                                FilterChip(
                                                  label: Text("Blood Bank"),
                                                  backgroundColor: Colors.transparent,
                                                  shape: StadiumBorder(side: BorderSide()),
                                                  selectedColor: Colors.green,
                                                  selected: selectvaluebloodbank,
                                                  onSelected: (bool value) {
                                                    print(value);
                                                    setState(() {
                                                      if(value){
                                                        selectvaluebloodbank= true;
                                                      }
                                                      else{
                                                        selectvaluebloodbank= false;
                                                      }
                                                    });
                                                  },
                                                ),

                                              ],
                                            ),
                                          ]
                                      ),
                                  )
                                ]
                            ),
                          ),
                        );
                      }
                  );
                },
                icon: const Icon(
                  Icons.filter_alt_rounded,
                ),
              ),
            ],
            leading: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              },
              child: Icon(Icons.arrow_back,
                  size: 8.0 * SizeConfig.imageSizeMultiplier!,
                  color: Colors.white),
            )),
        body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              compassEnabled: true,
              buildingsEnabled: true,
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.419857, -122.078827),
                zoom: 12.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              // markers: _markers,
              markers: Set<Marker>.of(markers.values),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffFF193B),
          child: const Icon(Icons.location_searching, color: Colors.white),
          onPressed: () {
            getLocation();
          },
        ),
        bottomNavigationBar: Container(
          height: 7.0 * SizeConfig.heightMultiplier!,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 5.0 * SizeConfig.heightMultiplier!,
                width: 10.0 * SizeConfig.widthMultiplier!,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Bloodtype = "A+";
                    });
                    getBloodGroup(Bloodtype);
                  },
                  child: Text(
                    "A+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0 * SizeConfig.heightMultiplier!,
                width: 10.0 * SizeConfig.widthMultiplier!,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Bloodtype = "A-";
                    });
                    getBloodGroup(Bloodtype);
                  },
                  child: Text(
                    "A-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0 * SizeConfig.heightMultiplier!,
                width: 10.0 * SizeConfig.widthMultiplier!,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Bloodtype = "B+";
                    });
                    getBloodGroup(Bloodtype);
                  },
                  child: Text(
                    "B+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0 * SizeConfig.heightMultiplier!,
                width: 10.0 * SizeConfig.widthMultiplier!,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Bloodtype = "B-";
                    });
                    getBloodGroup(Bloodtype);
                  },
                  child: Text(
                    "B-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0 * SizeConfig.heightMultiplier!,
                width: 10.0 * SizeConfig.widthMultiplier!,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Bloodtype = "O+";
                    });
                    getBloodGroup(Bloodtype);
                  },
                  child: Text(
                    "O+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0 * SizeConfig.heightMultiplier!,
                width: 10.0 * SizeConfig.widthMultiplier!,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Bloodtype = "O-";
                    });
                    getBloodGroup(Bloodtype);
                  },
                  child: Text(
                    "O-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0 * SizeConfig.heightMultiplier!,
                width: 10.0 * SizeConfig.widthMultiplier!,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Bloodtype = "AB+";
                    });
                    getBloodGroup(Bloodtype);
                  },
                  child: Text(
                    "AB+",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.0 * SizeConfig.heightMultiplier!,
                width: 10.0 * SizeConfig.widthMultiplier!,
                decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      Bloodtype = "AB-";
                    });
                    getBloodGroup(Bloodtype);
                  },
                  child: Text(
                    "AB-",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.5 * SizeConfig.textMultiplier!,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  GetLatLng() {
    return Text("lat " + lat! + "lng " + lng!);
  }

  getBloodGroup(String bg) async {
    var first = 0;
    markers.clear();
    FirebaseFirestore.instance
        .collection('users')
        .where('Blood Group', isEqualTo: bg)
        .get()
        .then((snapshot) {
      if (snapshot.size == 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("No Blood Found"), backgroundColor: Colors.red));
      }

      for (DocumentSnapshot doc in snapshot.docs) {
        final Object? result = doc.data();
        var markerIdVal = doc.id;
        final MarkerId markerId = MarkerId(markerIdVal);
        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Blood Found"),
            backgroundColor: Colors.red,
          ));
        }
        double lat = doc['latitude'];
        double lng = doc['longitude'];
        String name = doc['name'];
        String phone = doc['phone'];

        final Marker marker = Marker(
          markerId: markerId,
          position: LatLng(
            doc['latitude'],
            doc['longitude'],
          ),
          onTap: () {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 2.0 * SizeConfig.heightMultiplier!),
                          child: Text(
                            name,
                            style: const TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 2.0 * SizeConfig.heightMultiplier!,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox.fromSize(
                              child: ClipOval(
                                child: Material(
                                  child: InkWell(
                                    splashColor: Colors.green, // splash color
                                    onTap: () async {
                                      setState(() async {
                                        String phoneno = phone;
                                        await launch(
                                            'https://wa.me/$phoneno?text=Need Blood');
                                        // _makePhoneCall('tel:0597924917');
                                      });
                                    }, // button pressed
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.whatsapp_outlined,
                                          color: Colors.green,
                                          size: 50.0,
                                        ),
                                        // icon,
                                        // text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox.fromSize(
                              child: ClipOval(
                                child: Material(
                                  child: InkWell(
                                    splashColor: Colors.green, // splash color
                                    onTap: () {
                                      launch("tel://$phone");
                                    }, // button pressed
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.phone_outlined,
                                          color: Colors.black,
                                          size: 50.0,
                                        ),
                                        // icon,
                                        // text
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("SIGN-IN FIRST"),
                backgroundColor: Colors.red,
              ));
            }
          },
        );
        GoogleMapController? mapController;
        var newPosition = CameraPosition(target: LatLng(lat, lng), zoom: 16);
        CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);
        mapController?.moveCamera(update);

        if (first == 0) {
          first = 1;
          _controller
              ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(doc['latitude'] ?? 0.0, doc['longitude'] ?? 0.0),
            zoom: 15.0,
          )));
        }

        setState(() {
          markers[markerId] = marker;
        });
      }
    });
  }
}

class Users {
  final String? name;
  final String? avatar;
  Users({this.name, this.avatar});
}

List<Users> userList = [
  Users(name: "Jon", avatar: ""),
  Users(name: "Lindsey ", avatar: ""),
  Users(name: "Valarie ", avatar: ""),
  Users(name: "Elyse ", avatar: ""),
  Users(name: "Ethel ", avatar: ""),
  Users(name: "Emelyan ", avatar: ""),
  Users(name: "Catherine ", avatar: ""),
  Users(name: "Stepanida  ", avatar: ""),
  Users(name: "Carolina ", avatar: ""),
  Users(name: "Nail  ", avatar: ""),
  Users(name: "Kamil ", avatar: ""),
  Users(name: "Mariana ", avatar: ""),
  Users(name: "Katerina ", avatar: ""),
];