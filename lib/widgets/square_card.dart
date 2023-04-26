import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SquareCard extends StatefulWidget {
  final String name;
  final String image;
  final VoidCallback onPressed;
  final Function(bool) value;

  SquareCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.onPressed,
      required this.value})
      : super(key: key);

  @override
  State<SquareCard> createState() => _SquareCardState();
}

class _SquareCardState extends State<SquareCard> {
  bool isSwitchOn = false;

  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            // boxShadow: [
            //   BoxShadow(
            //     offset: Offset(0, 1),
            //     blurRadius: 5,
            //     color: Colors.black.withOpacity(0.3),
            //   ),
            //],
          ),

          child: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        child: Image.network(widget.image),
                      ),
                      SizedBox(width: 20),
                      Container(
                        //width: 100,
                        child: Text(widget.name,
                            maxLines: 2,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  widget.onPressed();
                }),
          ),
        ));
  }
}
