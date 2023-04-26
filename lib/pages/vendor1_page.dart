import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:instinct_app/globals.dart';
import 'package:instinct_app/pages/maps.dart';
import 'package:instinct_app/widgets/multi_line_chart.dart';
import 'package:http/http.dart' as http;
import '../models/ccms_model.dart';
import '../models/vendor1.dart';
import '../widgets/ccmsListCheckCard.dart';

class Vendor1Page extends StatefulWidget {
  Vendor1 instance;

  Vendor1Page({Key? key, required this.instance}) : super(key: key);

  @override
  State<Vendor1Page> createState() => _Vendor1PageState();
}

class _Vendor1PageState extends State<Vendor1Page> {
  List<CCMSCheck> ccmsList = [];
  List<CcmsModel> x1 = [];
  List<CcmsModel> x2 = [];
  List<CcmsModel> x3 = [];

  List<FlSpot> f1 = [];
  List<FlSpot> f2 = [];
  List<FlSpot> f3 = [];

  void initState() {
    print(widget.instance.ccmsList);
    for (var i in widget.instance.ccmsList) {
      ccmsList.add(CCMSCheck(ccmsName: i, isVisible: true));
    }
    getData();
  }

  Future<void> getData() async {
    x1 = await getCCMSData(ccmsList[0].ccmsName, true);
    print("fe $x1");
    x2 = await getCCMSData(ccmsList[1].ccmsName, true);
    x3 = await getCCMSData(ccmsList[2].ccmsName, true);
    setState(() {
      f1 = convertToFlSpot(x1);
      f2 = convertToFlSpot(x2);
      f3 = convertToFlSpot(x3);
    });

  }


  Future<List<CcmsModel>> getCCMSData(String url, bool check) async {

    List<CcmsModel> v1_ccms = [];

      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          "content-type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );
      if (response.statusCode == 200) {
        List<CcmsModel> v1_ccms = ccmsModelFromJson(response.body);

        return v1_ccms;
      } else {
        print('Error in API Calling');
      }


    return v1_ccms;
  }

  List<FlSpot> convertToFlSpot(List<CcmsModel> t) {
    List<FlSpot> c = [];
    for (int i = 0; i < t.length; i++) {
      c.add(FlSpot(i * 1.0, t[i].a1));
    }
    print("c $c");
    return c;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor1"),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
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
                        Container(
                          height: 50,
                          child: Image.network(widget.instance.vendorLogo),
                        ),
                        for (int i = 0; i < ccmsList.length; i++)
                          CCMSListCheckCard(
                            api: ccmsList[i].ccmsName,
                            value: (s) {
                              setState(() {
                                print(s);
                                ccmsList[i].isVisible = s;
                                print(ccmsList[i].isVisible);
                              });
                            },
                            isVisible: ccmsList[i].isVisible,
                          ),
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 7,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 400,
                          child: LineChartSample1(
                            t1: f1,
                            t2: f2,
                            t3: f3,
                          ),
                        )
                        , Container(
                            height: 400,
                            width: 400,
                            child: Maps())
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
