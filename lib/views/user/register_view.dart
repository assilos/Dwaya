import 'package:Dwaya/views/user/user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import controller
import 'package:Dwaya/controllers/user/user_controller.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  Color mainColor = Color.fromRGBO(	211, 232, 213,1.0);
  Color secondColor = Color.fromRGBO(19,117,71,1.0);
  UserController viewController = Get.put(UserController());
 // RegisterOneView one = Get.find();

  PageController _controller = PageController(
    initialPage: 0,
  );
  String a = "Suivant" ;


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: Get.height*0.85,
            child: PageView(
              onPageChanged: (int index) async {
                // Validate returns true if the form is valid, otherwise false.
             if (index == 3)
               {
                 setState(() {
                   a = 'Inscription';
                 });
               }
              },
              controller: _controller,

              children: [
                UserView()
                //RegisterOneView(),
              //  RegisterTwoView(),
                //RegisterThreeView(),
                //RegisterFourView(),
              ],
            ),
          ),
          Column(
          children: [
            RawMaterialButton(
              fillColor: secondColor,
              splashColor: mainColor,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:  <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                Text(
                  a,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white,fontSize: 20),
                ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)
              ),
              onPressed: () async {
                await viewController.Inscription("a", "a", "a", "a", "a", "a", "a", 56, 78, "aaeae", "zuzu", "zjzj", "aaa");
                Get.to(UserView()) ;
                // Validate returns true if the form is valid, otherwise false.
                _controller.nextPage(  duration: const Duration(milliseconds: 400),
                  curve: Curves.linear);
              },
            )
            ,
            Divider(
            height: Get.height * 0.05,
              color: Colors.white,
            ),
            SmoothPageIndicator(
                controller: _controller,  // PageController
                count:  4,
                effect:  WormEffect(
                  dotColor: mainColor,
                  activeDotColor: secondColor,
                  paintStyle:  PaintingStyle.fill,
                ),  // your preferred effect
                onDotClicked: (index){
                  _controller.jumpToPage(index) ;
                }
            )


          ],
          )

        ],
      ),
    );
  }

}