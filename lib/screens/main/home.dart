import 'package:dot_attend/screens/main/control/attendance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
final   List<Mycard> mycard = [
    Mycard(Icons.mark_email_read_sharp, 'Attendance', true,
        () => Get.to(AttendancePage())),
    Mycard(
        Icons.update, 'Downloads PDF', false, () => Get.to(AttendancePage())),
    Mycard(Icons.connect_without_contact, 'Connection', false,
        () => Get.to(AttendancePage())),
    Mycard(Icons.access_time_sharp, 'Active Attendance', false,
        () => Get.to(AttendancePage())),
    Mycard(Icons.timeline_rounded, 'Activity', false,
        () => Get.to(AttendancePage())),
    Mycard(Icons.settings, 'Settings', false, () => Get.to(AttendancePage())),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        backgroundColor: Color(0xFF6F35A5),
        title: Text('Dot Attend'),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Attendance marking made easy...',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: mycard
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          e.onTap();
                        },
                        child: Card(
                          color: e.isActive ? Colors.deepPurple : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                e.icon,
                                size: 50,
                                color: e.isActive
                                    ? Colors.white
                                    : Colors.deepPurple,
                              ),
                              SizedBox(height: 10),
                              Text(
                                e.title,
                                style: TextStyle(
                                    color: e.isActive
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
     // bottomNavigationBar: AppBottomBar(),
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;
  Function onTap;

  Mycard(this.icon, this.title, this.isActive, this.onTap);
}
