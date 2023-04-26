import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CCMSListCheckCard extends StatefulWidget {
  String api;
  bool isVisible;
  final Function(bool) value;

  CCMSListCheckCard(
      {Key? key,
      required this.api,
      required this.isVisible,
      required this.value})
      : super(key: key);

  @override
  State<CCMSListCheckCard> createState() => _CCMSListCheckCardState();
}

class _CCMSListCheckCardState extends State<CCMSListCheckCard> {
  bool isSwitchOn = false;

  void initState() {
    isSwitchOn = widget.isVisible;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          //width: MediaQuery.of(context).size.width*0.5,
          decoration: BoxDecoration(
            //border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    //width: 100,
                    child: Text(widget.api,
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: FlutterSwitch(
                    inactiveColor: Colors.redAccent,
                    activeColor: Colors.green,
                    value: isSwitchOn,
                    onToggle: (value) {
                      setState(
                        () {
                          isSwitchOn = !isSwitchOn;
                          widget.value(value);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
