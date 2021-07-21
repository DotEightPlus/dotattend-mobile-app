import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';


class ViewPdf extends StatelessWidget {
  final pdfFile;

  const ViewPdf({Key key, this.pdfFile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  PDFViewerScaffold(
            appBar: AppBar(
              title: Text("Document"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
            path: pdfFile);
  }
}
