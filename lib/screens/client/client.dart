import 'package:client_server_lan/client_server_lan.dart';
import 'package:device_info/device_info.dart';
import 'package:dot_attend/constants/asset_path.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class ClientScreen extends StatefulWidget {
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final box = GetStorage();
  bool kIsAndroid = false;
  String dropdownValue = 'Server';
  bool isLoading = false;
  String dataReceived = '';
  bool isRunning = false;
  String status = '';
  // AppController _appController = Get.find();

  // Server
  ServerNode server;
  List<ConnectedClientNode> connectedClientNodes = [];

  // Client
  ClientNode client;

  void startClient() async {
    //print("here");
    var name = 'Client';
    if (kIsAndroid) {
      var deviceInfo = await DeviceInfoPlugin().androidInfo;
      name = 'Client-${deviceInfo.brand}-${deviceInfo.model}';
    }
    setState(() {
      isLoading = true;
      client = ClientNode(
        name: name,
        verbose: true,
        onDispose: onDisposeClient,
        onServerAlreadyExist: onServerAlreadyExist,
        onError: onError,
      );
    });

    await client.init();
    await client.onReady;

    setState(() {
      status = 'Client ready on ${client.host}:${client.port} (${client.name})';
      isRunning = true;
      isLoading = false;
    });

    client.dataResponse.listen((DataPacket data) {
      setState(() {
        if (data.payload.runtimeType == String) {
          dataReceived = data.payload;
        } else {
          // dataReceived = City.fromMap(data.payload).toString();
        }
      });
    });
  }

  void disposeClient() {
    client.dispose();
  }

  void onDisposeClient() {
    setState(() {
      isRunning = false;
      status = 'Client is not running';
      isLoading = false;
    });
  }

  Future<void> onServerAlreadyExist(DataPacket dataPacket) async {
    print('Server already exist on ${dataPacket.host} (${dataPacket.name})');
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Server Already Exist'),
          content:
              Text('Server ready on ${dataPacket.host} (${dataPacket.name})'),
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

  Future<void> checkServerExistance() async {
    await client.discoverServerNode();
  }

  void clientToServer(dynamic message) async {
    await client.sendData(message, 'userInfo');
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
    Size size = MediaQuery.of(context).size;
    var matric = box.read("matric");
    var name = box.read("name");
    return Scaffold(
      body: Stack(
        children: [
          isRunning
              ? Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(scanning),
                )
              : SizedBox(),
          Positioned(
            top: 0,
            child: Container(
              height: size.height * 0.40,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                isRunning ? disposeClient() : startClient();
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.20, right: size.width * 0.20),
                child: IconButton(
                  onPressed: () {
                    isRunning ? disposeClient() : startClient();
                  },
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                    size: 120,
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      margin: EdgeInsets.only(top: 40), child: Text(status))),
              SizedBox(height: 20),
              Text("${box.read("name")}:${box.read("matric")}"),
              SizedBox(height: 30),
              isRunning
                  ? GestureDetector(
                      onTap: () {
                        checkServerExistance().then((value) {
                          clientToServer("$name:$matric");
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Sign Attendance",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              if (isLoading) CircularProgressIndicator.adaptive(),
            ],
          )
        ],
      ),
    );
  }
}
