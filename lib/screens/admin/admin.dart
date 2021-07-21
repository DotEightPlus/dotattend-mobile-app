import 'dart:io';

import 'package:clay_containers/clay_containers.dart';
import 'package:client_server_lan/client_server_lan.dart';
import 'package:device_info/device_info.dart';
import 'package:dot_attend/constants/asset_path.dart';
import 'package:dot_attend/controllers/app_controller.dart';
import 'package:dot_attend/screens/client/client.dart';
import 'package:dot_attend/screens/convert_to_pdf.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Admin extends StatefulWidget {
  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  bool kIsAndroid = false;
  String dropdownValue = 'Server';
  bool isLoading = false;
  String dataReceived = '';
  bool isRunning = false;
  String status = '';
  AppController _appController = Get.find();

  //PDF
  var output;
  Future<File> createPDF() async {
    final pw.Document pdf = pw.Document();
    pdf.addPage(
        //Your PDF design here with the widget system of the plugin
        pw.MultiPage(
      // pageFormat:
      //     PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      theme: pw.Theme(
        tableHeader: pw.TextStyle(fontSize: 8.0),
        tableCell: pw.TextStyle(fontSize: 8.0),
      ),
      header: (pw.Context context) {
        if (context.pageNumber == 1) {
          return null;
        }
        return pw.Container(
          //alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
          decoration: const pw.BoxDecoration(
              border: pw.BoxBorder(
                  bottom: true, width: 0.5, color: PdfColors.grey)),
          // child: pw.Text(_appController.dataList.value,
          //     style: pw.Theme.of(context)
          //         .defaultTextStyle
          //         .copyWith(color: PdfColors.grey))
          child: pw.ListView.builder(
            //shrinkWrap: true,
            itemCount: _appController.dataList.length,
            itemBuilder: (context, index) {
              return pw.Text(_appController.dataList[index].toString());
            },
          ),
        );
      },
    ));

    output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/attendance.pdf');
    file.writeAsBytesSync(pdf.save());
    return file;
  }

  // Server
  ServerNode server;
  List<ConnectedClientNode> connectedClientNodes = [];
  void startServer() async {
    var name = 'Server';
    if (kIsAndroid) {
      var deviceInfo = await DeviceInfoPlugin().androidInfo;
      name = 'Server-${deviceInfo.brand}-${deviceInfo.model}';
    }
    setState(() {
      isLoading = true;
      server = ServerNode(
        name: name,
        verbose: true,
        onDispose: onDisposeServer,
        clientDispose: clientDispose,
        onError: onError,
      );
    });

    await server.init();
    await server.onReady;

    setState(() {
      status = 'Server ready on ${server.host}:${server.port} (${server.name})';
      isRunning = true;
      isLoading = false;
    });
    server.dataResponse.listen((DataPacket data) {
      _appController.dataList.add(data.payload.toString());
      setState(() {
        dataReceived = data.payload.toString();
      });
    });
  }

  void disposeServer() {
    setState(() {
      isLoading = true;
    });
    server.dispose();
  }

  void clientDispose(ConnectedClientNode c) async {
    setState(() {
      connectedClientNodes = [];
    });
    for (final s in server.clientsConnected) {
      setState(() {
        connectedClientNodes.add(s);
      });
    }
  }

  void findClients() async {
    await server.discoverNodes();
    await Future<Object>.delayed(const Duration(seconds: 2));
    setState(() {
      connectedClientNodes = [];
    });
    for (final s in server.clientsConnected) {
      setState(() {
        connectedClientNodes.add(s);
      });
    }
  }

  void serverToClient(String clientName, dynamic message) async {
    final client = server.clientUri(clientName);
    await server.sendData(message, 'userInfo', client);
  }

  void onDisposeServer() {
    setState(() {
      isRunning = false;
      status = 'Server is not running';
      isLoading = false;
      connectedClientNodes = [];
    });
  }

  Future<void> onError(String error) async {
    print('ERROR $error');
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(error),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    kIsAndroid =
        !kIsWeb && Theme.of(context).platform == TargetPlatform.android;
    // ignore: non_constant_identifier_names
    var WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          isRunning
              ? Container(
                  margin: EdgeInsets.only(top: 120),
                  child: Lottie.asset(
                    scanning,
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                  ),
                )
              : SizedBox(),
          Positioned(
            bottom: 0,
            child: CustomPaint(
              size: Size(
                  WIDTH,
                  (WIDTH * 0.825)
                      .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                isRunning ? disposeServer() : startServer();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                child: ClayContainer(
                  color: Colors.blue[900],
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: isRunning
                        ? ClayText(
                            "Stop",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : ClayText(
                            "Start",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.20),
              child: Obx(
                () => Text(
                  "Total Attendance Signed: ${_appController.dataList.length.toString()}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 30,
            child: GestureDetector(
              onTap: () async {
                print("here");
                Get.to(ClientScreen());
               
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Icon(Entypo.user, color: Colors.blue[900]),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: IconButton(
              icon: Icon(Entypo.save, color: Colors.blue[900]),
              onPressed: () async{
                var path = await createPDF();
                var ff = path.path;
                Get.to(ViewPdf(
                  pdfFile: ff,
                ));
              },
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 60),
              child: Text(
                "DotAttend",
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(status),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _appController.dataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 28.0, bottom: 10),
                        child: Text(
                          _appController.dataList[index].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
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
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0012500, size.height * 0.4060000);
    path_0.quadraticBezierTo(size.width * 0.0065625, size.height * 0.3020000,
        size.width * 0.0600000, size.height * 0.3020000);
    path_0.cubicTo(
        size.width * 0.5018750,
        size.height * 0.2035000,
        size.width * 0.5006250,
        size.height * 0.2025000,
        size.width * 0.9375000,
        size.height * 0.3000000);
    path_0.quadraticBezierTo(size.width * 0.9903125, size.height * 0.3010000,
        size.width * 0.9987500, size.height * 0.4000000);
    path_0.lineTo(size.width * 0.9987500, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width * 0.0012500, size.height * 0.4060000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
