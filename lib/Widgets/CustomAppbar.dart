import 'package:flutter/material.dart';
import 'LogoWithAppbar.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
   CustomAppbar({super.key, required this.ScaffoldKey,this.keytool=220,required this.title,required this.text,
   required this.isappear
   });
   final GlobalKey<ScaffoldState>? ScaffoldKey;
     double keytool;
     String title="";
      String text="";
      bool isappear=true;
  @override
  Size get preferredSize => Size.fromHeight(keytool);
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return AppBar(
     // toolbarHeight: 220,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70),
              ),
              color: Colors.orangeAccent[100],
            ),
            child: isappear?Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text("${text}",
                        style: TextStyle(
                          fontSize: mediaQuery.size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      isappear?Text("${title}",
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.09,
                            color: Colors.black
                        ),
                      ):SizedBox(),
                    ],
                  ),
                  isappear?Logowithappbar():SizedBox(),
                ],
              ),
            ):
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${text}",
                        style: TextStyle(
                          fontSize: mediaQuery.size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      isappear?Text("${title}",
                        style: TextStyle(
                            fontSize: mediaQuery.size.width * 0.09,
                            color: Colors.black
                        ),
                      ):SizedBox(),
                    ],
                  ),
                  isappear?Logowithappbar():SizedBox(),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                ScaffoldKey?.currentState?.openDrawer();
              },
              child: Icon(Icons.menu, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}