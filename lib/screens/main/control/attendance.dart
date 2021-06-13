import 'package:flutter/material.dart';

class Product {
  final image;
  final name;
  final price;

  Product(this.image, this.name, this.price);
}

class AttendancePage extends StatelessWidget {
  List products = [
    Product(
        'https://lh3.googleusercontent.com/proxy/2gvngPLBf-XuU77M62l_Wcr-8YSArI-PVfKHVKhf2zqwv2c8WAnt-EWwK0nUTtQM4SOT4ItbAd4rmRDtyg5k5htcIT_4Mu6X2FmbWTSZT6Uj5BJuSWMwy5NplZO15iA9BjrstZYI',
        'MTE 204',
        "Active Now"),
    Product(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdygFdB_FfadQmmrDZUgLeJTILZBTU0d9Ffs3mLpYSh2rulaJo&usqp=CAU',
        'CVE 204',
        'Active Soon'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Dot Attend'),
        backgroundColor: Color(0xFF6F35A5),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                'Featured ',
                'Most recent',
                'Tab 1',
                'Tab 2',
                'Tab 3',
                'Etc...'
              ]
                  .map((e) => Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: OutlineButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(e),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Column(
              children: products
                  .map(
                    (e) => Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey[200],
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(3, 4))
                        ],
                      ),
                      child: ListTile(
                        // leading: Image.network(
                        //   e.image,
                        //   fit: BoxFit.cover,
                        //   width: 90,
                        //   height: 100,
                        // ),
                        title: Text(
                          e.name,
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(" " + e.price.toString()),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }
}
