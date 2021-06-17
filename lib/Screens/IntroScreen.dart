import 'package:dotattend/Constants/color_constants.dart';
import 'package:dotattend/Constants/svg_constants.dart';
import 'package:dotattend/Models/IntroModel.dart';
import 'package:flutter/material.dart';
import 'package:concentric_transition/page_view.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: status_bar_color));
    List<IntroScreenModel> pageData=[
      IntroScreenModel(assetname:sign_attendance_with_ease,text:"Attendance ",description: "Sing attendance with ease",button: null,textcolor: Colors.white ),
      IntroScreenModel(assetname:sign_attendace_with_mobile_phone,text:"Mark attendance",description: "Mark attendace with your smartphones at ease",button: RaisedButton(
        color:HexColor("171461"),
        elevation: 20.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),

        ),
        child: Text(
          "Get started",
          style: TextStyle(
              color: Colors.white,
              fontSize: 25
          ),
        ),
        onPressed: (){
          Navigator.pushNamedAndRemoveUntil(context, "/accesscode", (route) => false);
        },
      ),
          textcolor: Colors.white
      ),

    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ConcentricPageView(
          verticalPosition: 0.82,
          pageController: PageController(initialPage: 0),
          opacityFactor: 1.0,
          scaleFactor: 0.0,
          direction: Axis.vertical,
          colors: pageview_color,
          curve: Curves.bounceInOut,
          itemCount: pageData.length,
          duration: Duration(seconds: 1),
          radius: 20,
          itemBuilder: (index,value){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                    Container(
                      height: MediaQuery.of(context).size.height*0.4,
                      width: MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        pageData[index].assetname,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      pageData[index].text,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                          color: pageData[index].textcolor
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                        pageData[index].description,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0,
                            color: pageData[index].textcolor
                        )
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                    pageData[index].button==null?Text("Swipe up",style: TextStyle(color: Colors.white),):pageData[index].button
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

