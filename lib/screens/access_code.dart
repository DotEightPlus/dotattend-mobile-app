import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';

class AccessCodePage extends StatelessWidget {
  Future<String> validateAccessCode(String accesscode) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (accesscode == "1234") {
      return null;
    } else {
      return "The entered access code is wrong";
    }
  }

  // action to be performed after access code validation is success
  void moveToNextScreen(context) {
    Navigator.pushNamedAndRemoveUntil(
        context, "/attendancepage", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    double HEIGTH = MediaQuery.of(context).size.height;
    double WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            CustomPaint(
              size: Size(
                  WIDTH,
                  (HEIGTH)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            ),
            Positioned(
              left: 0,
              top: MediaQuery.of(context).size.height * 0.2,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                child: OtpScreen(
                  otpLength: 4,
                  validateOtp: validateAccessCode,
                  routeCallback: moveToNextScreen,
                  themeColor: Colors.black54,
                  titleColor: Colors.black54,
                  title: "Access code Verification",
                  subTitle:
                      "Please provide access code \nto initiate attendance",
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                margin: EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width * 0.5,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/attendancepage", (route) => false);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue[900],
                  child: Text(
                    "Continue",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.blue[900]
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0024272, size.height * 0.0010638);
    path_0.lineTo(size.width * 0.0024272, size.height * 0.0723404);
    path_0.quadraticBezierTo(size.width * 0.0145631, size.height * 0.0840426,
        size.width * 0.0266990, size.height * 0.0737589);
    path_0.cubicTo(
        size.width * 0.0244235,
        size.height * 0.0598404,
        size.width * 0.0077427,
        size.height * 0.0497305,
        size.width * 0.0175971,
        size.height * 0.0180851);
    path_0.cubicTo(
        size.width * 0.0289745,
        size.height * 0.0174645,
        size.width * 0.0304854,
        size.height * 0.0038156,
        size.width * 0.0631068,
        size.height * 0.0156028);
    path_0.quadraticBezierTo(size.width * 0.0807039, size.height * 0.0414894,
        size.width * 0.0728155, size.height * 0.0624113);
    path_0.quadraticBezierTo(size.width * 0.0879854, size.height * 0.0773050,
        size.width * 0.0970874, size.height * 0.0609929);
    path_0.quadraticBezierTo(size.width * 0.0946602, size.height * 0.0514184,
        size.width * 0.0873786, size.height * 0.0226950);
    path_0.quadraticBezierTo(size.width * 0.0916262, size.height * 0.0100142,
        size.width * 0.1547330, size.height * 0.0063830);
    path_0.cubicTo(
        size.width * 0.1996359,
        size.height * 0.0085957,
        size.width * 0.1642900,
        size.height * 0.0622340,
        size.width * 0.1674757,
        size.height * 0.0808511);
    path_0.cubicTo(
        size.width * 0.1777913,
        size.height * 0.1177305,
        size.width * 0.2014563,
        size.height * 0.0975177,
        size.width * 0.2057039,
        size.height * 0.0865248);
    path_0.quadraticBezierTo(size.width * 0.2211893, size.height * 0.0726950,
        size.width * 0.1978155, size.height * 0.0099291);
    path_0.quadraticBezierTo(size.width * 0.2163350, size.height * 0.0035461,
        size.width * 0.2427184, size.height * 0.0014184);
    path_0.cubicTo(
        size.width * 0.2797330,
        size.height * 0.0202128,
        size.width * 0.2506068,
        size.height * 0.0312057,
        size.width * 0.2512136,
        size.height * 0.0411348);
    path_0.cubicTo(
        size.width * 0.2682039,
        size.height * 0.0692340,
        size.width * 0.2915777,
        size.height * 0.0509787,
        size.width * 0.3009709,
        size.height * 0.0400709);
    path_0.quadraticBezierTo(size.width * 0.3046117, size.height * 0.0268652,
        size.width * 0.2912621, size.height * 0.0085106);
    path_0.quadraticBezierTo(size.width * 0.3082524, size.height * -0.0024823,
        size.width * 0.3300971, size.height * 0.0056738);
    path_0.cubicTo(
        size.width * 0.3319175,
        size.height * 0.0152482,
        size.width * 0.3567961,
        size.height * 0.0255319,
        size.width * 0.3373786,
        size.height * 0.0439716);
    path_0.cubicTo(
        size.width * 0.3294903,
        size.height * 0.0787234,
        size.width * 0.3683252,
        size.height * 0.0418440,
        size.width * 0.3786408,
        size.height * 0.0411348);
    path_0.cubicTo(
        size.width * 0.3877427,
        size.height * 0.0283688,
        size.width * 0.3695388,
        size.height * 0.0187943,
        size.width * 0.3665049,
        size.height * 0.0113475);
    path_0.quadraticBezierTo(size.width * 0.3719660, size.height * 0.0035461,
        size.width * 0.4004854, size.height * 0.0014184);
    path_0.quadraticBezierTo(size.width * 0.4174757, size.height * 0.0443262,
        size.width * 0.4029126, size.height * 0.0751773);
    path_0.quadraticBezierTo(size.width * 0.4120146, size.height * 0.0932624,
        size.width * 0.4271845, size.height * 0.0765957);
    path_0.quadraticBezierTo(size.width * 0.4335558, size.height * 0.0292553,
        size.width * 0.4356796, size.height * 0.0134752);
    path_0.quadraticBezierTo(size.width * 0.4463107, size.height * 0.0000851,
        size.width * 0.4902913, size.height * 0.0024823);
    path_0.quadraticBezierTo(size.width * 0.5242718, size.height * 0.0123262,
        size.width * 0.4951456, size.height * 0.0865248);
    path_0.quadraticBezierTo(size.width * 0.5121359, size.height * 0.1088652,
        size.width * 0.5266990, size.height * 0.0836879);
    path_0.lineTo(size.width * 0.5242718, size.height * 0.0368794);
    path_0.quadraticBezierTo(size.width * 0.5358010, size.height * 0.0099291,
        size.width * 0.5800971, size.height * 0.0340426);
    path_0.quadraticBezierTo(size.width * 0.5843447, size.height * 0.0411348,
        size.width * 0.5940534, size.height * 0.0641844);
    path_0.quadraticBezierTo(size.width * 0.6061893, size.height * 0.0868794,
        size.width * 0.6274272, size.height * 0.0773050);
    path_0.quadraticBezierTo(size.width * 0.6510922, size.height * 0.0602837,
        size.width * 0.6310680, size.height * 0.0269504);
    path_0.quadraticBezierTo(size.width * 0.6498786, size.height * 0.0361702,
        size.width * 0.6601942, size.height * 0.0368794);
    path_0.quadraticBezierTo(size.width * 0.6686893, size.height * 0.0390071,
        size.width * 0.6820388, size.height * 0.0241135);
    path_0.quadraticBezierTo(size.width * 0.7299757, size.height * 0.0304965,
        size.width * 0.6650485, size.height * 0.1673759);
    path_0.quadraticBezierTo(size.width * 0.6759709, size.height * 0.1921986,
        size.width * 0.7087379, size.height * 0.1602837);
    path_0.lineTo(size.width * 0.7257282, size.height * 0.0184397);
    path_0.quadraticBezierTo(size.width * 0.7487864, size.height * 0.0443262,
        size.width * 0.7584951, size.height * 0.0517730);
    path_0.quadraticBezierTo(size.width * 0.7748786, size.height * 0.0677305,
        size.width * 0.7936893, size.height * 0.0482270);
    path_0.quadraticBezierTo(size.width * 0.8100728, size.height * 0.0269504,
        size.width * 0.8155340, size.height * 0.0198582);
    path_0.quadraticBezierTo(size.width * 0.8294903, size.height * 0.0124113,
        size.width * 0.8470874, size.height * 0.0184397);
    path_0.quadraticBezierTo(size.width * 0.8652913, size.height * 0.0287234,
        size.width * 0.8592233, size.height * 0.0723404);
    path_0.quadraticBezierTo(size.width * 0.8756068, size.height * 0.0840426,
        size.width * 0.8883495, size.height * 0.0695035);
    path_0.quadraticBezierTo(size.width * 0.8913835, size.height * 0.0184397,
        size.width * 0.9126214, size.height * 0.0156028);
    path_0.quadraticBezierTo(size.width * 0.9205097, size.height * 0.0148936,
        size.width * 0.9441748, size.height * 0.0127660);
    path_0.quadraticBezierTo(size.width * 0.9702670, size.height * 0.0081560,
        size.width * 0.9587379, size.height * 0.0397163);
    path_0.quadraticBezierTo(size.width * 0.9684466, size.height * 0.0503546,
        size.width * 0.9854369, size.height * 0.0397163);
    path_0.lineTo(size.width, size.height * 0.0007092);
    path_0.lineTo(size.width * 0.0024272, size.height * 0.0010638);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
