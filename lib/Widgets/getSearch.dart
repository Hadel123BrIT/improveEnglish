import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Core/Constances/all_colors.dart';
class Getsearch extends StatelessWidget {
  const Getsearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: grey),
                  hintText: "Search",
                  hintStyle:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: grey,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(color: Colors.grey[300]),
            child: Center(
              // child: SvgPicture.asset(
              //   color: Colors.black,
              //   "assets/icons/filter.svg",
              //   width: MediaQuery.of(context).size.width * 0.03,
              //   height: MediaQuery.of(context).size.height * 0.03,
              // ),
              child: Icon(Icons.filter_list_sharp),
            ),
          ),
        ],
      ),
    );
  }
}
