import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection(
      {super.key, required this.city, required this.updatedTime});

  final String city;
  final String updatedTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(0,0,4,0),
          child: Icon(
            CupertinoIcons.location,
            size: 40,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 8,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              city,
              style: const TextStyle(
                  color: Colors.white, fontFamily: "poppins", fontSize: 24),
            ),
            Text(
              "Updated at $updatedTime",
              style: const TextStyle(
                  color: Colors.white, fontFamily: "poppins", fontSize: 14),
            )
          ],
        )
      ],
    );
  }
}
