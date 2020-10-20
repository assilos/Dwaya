import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dweya/views/user/components/profil.dart';
import 'package:dweya/views/user/components/shopping.dart';
import 'package:dweya/views/user/layouts/main/main_interface.dart';
import 'package:dweya/views/user/layouts/main/list_tab.dart';
import 'package:dweya/views/user/components/details_produits.dart';
import 'package:dweya/views/user/layouts/main/recompenses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class MainTab extends StatefulWidget {
  @override
  _MainTabState createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  Color mainColor = Color.fromRGBO(236,236,236,1.0);
  Color secondColor = Color.fromRGBO(19,117,71,1.0);
  PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;
  @override
  void initState() {
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:       Container(
        child: PageView(
          physics:new NeverScrollableScrollPhysics(),
          controller: _controller,

          children: [
            MainInterface(),
            RecompenseScreen(),
            Shopping(),
            ListTab(),
            Profil(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        currentIndex: _currentPage,

        onItemSelected: (index) => setState(() {
          _currentPage = index;
          _controller.animateToPage(index,
              duration: Duration(milliseconds: 300), curve: Curves.easeOut);
        }),


        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Acceuil'),
            activeColor: secondColor,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.attach_money),
              title: Text('Ladderboard'),

              activeColor: secondColor
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.add),
              title: Text('Ajouter'),

              activeColor: secondColor
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text('Messages'),
              activeColor: secondColor
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text('Profil'),
              activeColor: secondColor
          ),
        ],
      ),

    );
  }

}