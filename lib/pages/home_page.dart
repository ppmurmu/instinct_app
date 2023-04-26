import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instinct_app/models/ccms_model.dart';
import 'package:instinct_app/pages/vendor1_page.dart';
import 'package:instinct_app/widgets/ccmsListCheckCard.dart';
import 'package:instinct_app/widgets/data_card.dart';
import 'package:instinct_app/widgets/square_card.dart';
import '../globals.dart';
import '../models/vendor1.dart';
import '../models/vendor2.dart';
import '../models/vendor3.dart';
import '../models/vendor4.dart';
import '../models/vendor5.dart';
import '../models/vendor_list.dart';
import 'bar_graph.dart';
import 'chart1.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;

  int fault_bulb = 0;
  int power_consumed = 0;
  int total_bulb = 0;

  List<VendorList> vendorList = [];
  late Vendor1 vendor1List;
  late Vendor2 vendor2List;
  late Vendor3 vendor3List;
  late Vendor4 vendor4List;
  late Vendor5 vendor5List;

  double v1_a1 = 0;
  double v1_kva1 = 0;
  double v1_kvah = 0;
  double v1_kw1 = 0;
  double v1_kwh = 0;
  double v1_v1 = 0;

  void getUserNotes() async {
    setState(() {
      loading = true;
    });
    final response = http.Response(
        json.encode([
          {
            "name": "vendor1",
            "image":
                "https://logos-world.net/wp-content/uploads/2021/03/Duke-Energy-Logo-700x394.png"
          },
          {
            "name": "vendor2",
            "image":
                "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/LOGO_ENGIE.jpg/640px-LOGO_ENGIE.jpg"
          },
          {
            "name": "vendor3",
            "image":
                "https://logowik.com/content/uploads/images/enel-energy3721.jpg"
          },
          {"name": "vendor4", "image": "https://logodix.com/logo/84959.jpg"},
          {
            "name": "vendor5",
            "image":
                "https://www.logolynx.com/images/logolynx/d4/d48f37e2e8ebc8a25047b2c74c8f1a35.jpeg"
          }
        ]),
        200);

    if (response.statusCode == 200) {
      setState(() {
        vendorList = vendorListFromJson(response.body);
        switches = List<bool>.filled(vendorList.length, false, growable: true);
      });
      await getVendor1();
      await getVendor2();
      await getVendor3();
      await getVendor4();
      await getVendor5();

     // await getVendorCcmsData();
    } else {
      print('Error in API Calling');
    }
    setState(() {
      loading = false;
    });
  }

  List<String> faulty = [];
  int working = 0;

  Future<void> getVendorCcmsData() async {
    List<double> t = [];
    double t_a1 = 0;
    double t_kva1 = 0;
    double t_kw1 = 0;
    double t_v1 = 0;

    int c = 0;
    for (int i = 0; i < ccmsListCheck.length; i++) {
      t = await getCCMSData(
          ccmsListCheck[i].ccmsName, ccmsListCheck[i].isVisible);
      if (t.length != 0) {
        v1_kvah = v1_kvah + t[2];
        v1_kwh = v1_kwh + t[4];
        t_a1 = t_a1 + t[0];
        t_kva1 = t_kva1 + t[1];
        t_kw1 = t_kw1 + t[3];
        t_v1 = t_v1 + t[5];
        c++;
      } else {
        faulty.add(ccmsListCheck[i].ccmsName);
      }
    }
    setState(() {
      v1_kvah = v1_kvah;
      v1_kwh = v1_kwh;

      v1_a1 = t_a1 / c;
      v1_kva1 = t_kva1 / c;
      v1_kw1 = t_kw1 / c;
      v1_v1 = t_v1 / c;

      working = c;
    });

    print("$t sfeo");
  }

  Future<List<double>> getCCMSData(String url, bool check) async {
    List<double> ccmsData = [];
    double a1 = 0;
    double kva1 = 0;
    double kvah = 0;
    double kw1 = 0;
    double kwh = 0;
    double v1 = 0;

    if (check) {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "content-type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      if (response.statusCode == 200) {
        List<CcmsModel> v1_ccms = ccmsModelFromJson(response.body);
        for (var item in v1_ccms) {
          a1 = a1 + item.a1;
          kva1 = kva1 + item.kva1;
          kvah = kvah + item.kvah;
          kw1 = kw1 + item.kw1;
          kwh = kwh + item.kwh;
          v1 = v1 + item.v1;
        }
        ccmsData.add(a1);
        ccmsData.add(kva1);
        ccmsData.add(kvah);
        ccmsData.add(kw1);
        ccmsData.add(kwh);
        ccmsData.add(v1);
        return ccmsData;
      } else {
        print('Error in API Calling');
      }
    }

    return ccmsData;
  }

  Future<void> getVendor1() async {
    final response = http.Response(
        json.encode({
          "vendor": "vendor1",
          "vendor_logo":
              "https://logos-world.net/wp-content/uploads/2021/03/Duke-Energy-Logo-700x394.png",
          "total_street_lights": 258,
          "grid_location": "sector 23",
          "working_units": 243,
          "fault_units": 15,
          "period": "05/2022",
          "power_consumed": "10452",
          "frequency": 50,
          "ccms_list": [
            "https://mock-api-repo.netlify.app/api/v1_ccms/v1_ccms1.json",
            "https://mock-api-repo.netlify.app/api/v1_ccms/v1_ccms2.json",
            "https://mock-api-repo.netlify.app/api/v1_ccms/v1_ccms3.json",
            "https://mock-api-repo.netlify.app/api/v1_ccms/v1_ccms4.json",
            "https://mock-api-repo.netlify.app/api/v1_ccms/v1_ccms5.json",
            "https://mock-api-repo.netlify.app/api/v1_ccms/v1_ccms6.json",
            "https://mock-api-repo.netlify.app/api/v1_ccms/v1_ccms7.json"
          ]
        }),
        200);

    if (response.statusCode == 200) {
      setState(() {
        vendor1List = vendor1FromJson(response.body);
        for (var item in vendor1List.ccmsList) {
          ccmsListCheck.add(CCMSCheck(ccmsName: item, isVisible: true));
        }
      });
    } else {
      print('Error in API Calling');
    }
    print(vendor1List.ccmsList);
  }

  Future<void> getVendor2() async {
    final response = http.Response(
        json.encode({
          "name": "vendor2",
          "logo":
              "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/LOGO_ENGIE.jpg/640px-LOGO_ENGIE.jpg",
          "total": 150,
          "coordinate": "sector 68",
          "ok": 145,
          "not_ok": 5,
          "time_span": "05/2022",
          "power_consumed": "5285",
          "sys_id": 73249929,
          "auto_generated": true,
          "frequency": 50,
          "ccms_list": [
            "https://mock-api-repo.netlify.app/api/v2_ccms/v2_ccms1.json",
            "https://mock-api-repo.netlify.app/api/v2_ccms/v2_ccms2.json",
            "https://mock-api-repo.netlify.app/api/v2_ccms/v2_ccms3.json",
            "https://mock-api-repo.netlify.app/api/v2_ccms/v2_ccms4.json",
            "https://mock-api-repo.netlify.app/api/v2_ccms/v2_ccms5.json"
          ]
        }),
        200);

    if (response.statusCode == 200) {
      setState(() {
        vendor2List = vendor2FromJson(response.body);
        for (var item in vendor2List.ccmsList) {
          ccmsListCheck.add(CCMSCheck(ccmsName: item, isVisible: true));
        }
      });
    } else {
      print('Error in API Calling');
    }
  }

  Future<void> getVendor3() async {
    final response = http.Response(
        json.encode({
          "title": "vendor3",
          "logo":
              "https://logowik.com/content/uploads/images/enel-energy3721.jpg",
          "total": 214,
          "coordinate": "sector 54",
          "ok": 197,
          "not_ok": 17,
          "time_span": "05/2022",
          "power_consumed": "10200",
          "frequency": 50,
          "ccms_list": [
            "https://mock-api-repo.netlify.app/api/v3_ccms/v3_ccms1.json",
            "https://mock-api-repo.netlify.app/api/v3_ccms/v3_ccms2.json",
            "https://mock-api-repo.netlify.app/api/v3_ccms/v3_ccms3.json"
          ]
        }),
        200);

    if (response.statusCode == 200) {
      setState(() {
        vendor3List = vendor3FromJson(response.body);
        for (var item in vendor3List.ccmsList) {
          ccmsListCheck.add(CCMSCheck(ccmsName: item, isVisible: true));
        }
      });
    } else {
      print('Error in API Calling');
    }
  }

  Future<void> getVendor4() async {
    final response = http.Response(
        json.encode({
          "supplier": "vendor4",
          "image": "https://logodix.com/logo/84959.jpg",
          "lamps": 302,
          "area": "sector 74",
          "ok": 243,
          "not_ok": 59,
          "time_span": "05/2022",
          "power_consumed": "14823",
          "frequency": 50,
          "ccms_list": [
            "https://mock-api-repo.netlify.app/api/v4_ccms/v4_ccms1.json",
            "https://mock-api-repo.netlify.app/api/v4_ccms/v4_ccms2.json"
          ]
        }),
        200);

    if (response.statusCode == 200) {
      setState(() {
        vendor4List = vendor4FromJson(response.body);
        for (var item in vendor4List.ccmsList) {
          ccmsListCheck.add(CCMSCheck(ccmsName: item, isVisible: true));
        }
      });
    } else {
      print('Error in API Calling');
    }
  }

  Future<void> getVendor5() async {
    final response = http.Response(
        json.encode({
          "title": "vendor5",
          "logo":
              "https://www.logolynx.com/images/logolynx/d4/d48f37e2e8ebc8a25047b2c74c8f1a35.jpeg",
          "total": 164,
          "coordinate": "sector 94",
          "ok": 155,
          "not_ok": 9,
          "time_span": "05/2022",
          "power_consumed": "8133",
          "frequency": 50,
          "ccms_list": [
            "https://mock-api-repo.netlify.app/api/v5_ccms/v5_ccms1.json",
            "https://mock-api-repo.netlify.app/api/v5_ccms/v5_ccms2.json"
          ]
        }),
        200);

    if (response.statusCode == 200) {
      setState(() {
        vendor5List = vendor5FromJson(response.body);
        for (var item in vendor5List.ccmsList) {
          ccmsListCheck.add(CCMSCheck(ccmsName: item, isVisible: true));
        }
      });
    } else {
      print('Error in API Calling');
    }
  }

  List<CCMSCheck> ccmsListCheck = [];

  Widget listAllCCMS() {
    return Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.4,
      //width: MediaQuery.of(context).size.width * 0.4,
      child: SingleChildScrollView(
        child: Scrollbar(
          child: Column(
            children: [
              for (int i = ccmsListCheck.length - 1; i > 0; i--)
                CCMSListCheckCard(
                  api: ccmsListCheck[i].ccmsName,
                  value: (s) {
                    setState(() {
                      print(s);
                      ccmsListCheck[i].isVisible = s;
                      print(ccmsListCheck[i].isVisible);
                    });
                    getVendorCcmsData();
                  },
                  isVisible: ccmsListCheck[i].isVisible,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void initState() {
    getUserNotes();
  }

  List<bool> switches = [];
  double t = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          elevation: 0,
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(

                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [Color(0xFF0066C2), Color(0xFF8FC1FB)])
                      //color: colorMap[widget.name],
                      ),
                  child: Container(),
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(text: "Admin"),
                        ),
                      ]),
                  onTap: () {
                    //Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(text: "Log Out"),
                        ),
                      ]),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', ModalRoute.withName('/'));
                  },
                ),
                Spacer(),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          "Support",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )),
             const   Padding(
                    padding:
                         EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      "App version 1.0",
                    )),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Central CMS"),
        ),
        body: (loading == false)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SquareCard(
                                  name: vendorList[0].name,
                                  image: vendorList[0].image,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Vendor1Page(
                                                  instance: vendor1List,
                                                )));
                                  },
                                  value: (s) {
                                    setState(() {
                                      switches[0] = s;
                                    });
                                  },
                                ),
                                SquareCard(
                                  name: vendorList[1].name,
                                  image: vendorList[1].image,
                                  onPressed: () {},
                                  value: (s) {
                                    setState(() {
                                      switches[1] = s;
                                    });
                                  },
                                ),
                                SquareCard(
                                  name: vendorList[2].name,
                                  image: vendorList[2].image,
                                  onPressed: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => VendorPage(
                                    //
                                    //         )
                                    //     ));
                                  },
                                  value: (s) {
                                    setState(() {
                                      switches[2] = s;
                                    });
                                  },
                                ),
                                SquareCard(
                                  name: vendorList[3].name,
                                  image: vendorList[3].image,
                                  onPressed: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => VendorPage(
                                    //
                                    //         )
                                    //     ));
                                  },
                                  value: (s) {
                                    setState(() {
                                      switches[3] = s;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 5,
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: TextField(
                                                    focusNode: _focusNode,
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      labelStyle: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      labelText: 'Plug CCMS',
                                                    ),
                                                    controller: _controller,
                                                    onChanged: (text) {},
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      shape: MaterialStateProperty.all<
                                                              RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              side: BorderSide(
                                                                  color: Colors
                                                                      .purple)))),
                                                  onPressed: () {
                                                    setState(() {
                                                      ccmsListCheck.add(
                                                          CCMSCheck(
                                                              ccmsName:
                                                                  _controller
                                                                      .text,
                                                              isVisible: true));
                                                    });
                                                    getVendorCcmsData();

                                                    _controller.clear();
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text("Submit"),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        listAllCCMS()
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 5,
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            ),
                                          ],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: BarChartSample1(
                                          kvah: v1_kvah,
                                          kwh: v1_kwh,
                                        )),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 1),
                                            blurRadius: 5,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                        ],
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: LineChartSample2(
                                        a1: v1_a1,
                                        kva1: v1_kva1,
                                        kw1: v1_kw1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ResourceTile(
                                  name: "Connected",
                                  data: working.toString(),
                                ),
                                ResourceTile(
                                    name: "Total lamps",
                                    data: (vendor1List.totalStreetLights +
                                            vendor5List.total +
                                            vendor2List.total +
                                            vendor3List.total +
                                            vendor4List.lamps)
                                        .toString()),
                              ],
                            ),
                            Row(
                              children: [
                                ResourceTile(
                                    name: "Fault lamps",
                                    data: (vendor1List.faultUnits +
                                            vendor5List.notOk +
                                            vendor2List.notOk +
                                            vendor3List.notOk +
                                            vendor4List.notOk)
                                        .toString()),
                                ResourceTile(
                                    name: "Power consumed",
                                    data: (vendor1List.powerConsumed +
                                            vendor5List.powerConsumed +
                                            vendor2List.powerConsumed +
                                            vendor3List.powerConsumed +
                                            vendor4List.powerConsumed)
                                        .toString())
                              ],
                            ),
                            Row(
                              children: [
                                ResourceTile(
                                  name: "a1",
                                  data: v1_a1.toString(),
                                ),
                                ResourceTile(
                                  name: "kva1",
                                  data: v1_kva1.toString(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                ResourceTile(
                                    name: "kwh", data: v1_kwh.toString()),
                                ResourceTile(
                                    name: "kvah", data: v1_kvah.toString())
                              ],
                            ),
                            Row(
                              children: [
                                ResourceTile(
                                    name: "kw1", data: v1_kw1.toString()),
                                ResourceTile(
                                    name: "v1", data: v1_v1.toString()),
                              ],
                            )
                          ],
                        ))
                  ],
                )),
              ));
  }

  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();

  FocusNode _focusNode = FocusNode();
}
