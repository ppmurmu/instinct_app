import 'package:flutter/material.dart';

import '../globals.dart';

class ResourceTile extends StatelessWidget {
  final String? name;
  final String data;

  const ResourceTile({
    Key? key,
    this.name,
    required this.data
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10, left: 10.0, right: 10.0),
      child: Container(
        width: 120,
         height: 120,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 5,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [resourceColorMap1[name]!, resourceColorMap2[name]!])
            //color: colorMap[name],
            ),
        child: Material(
          child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                print("tapped");
              },
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //todo: customizable textStyle

                    Container(
                      //width: 100,
                      child: Text(name!,
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      //width: 100,
                      child: Text(data,
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              )),
          color: Colors.transparent,
        ),
      ),
    );
  }
}
