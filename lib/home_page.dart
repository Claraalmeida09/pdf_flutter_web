import 'dart:io';
import 'dart:io' as html;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: IconButton(
            onPressed: _print,
            icon: const Icon(
              Icons.print_outlined,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  _print() async {
    // - asset: assets/fonts/Poppins-Light.ttf
    //   weight: 300
    // - asset: assets/fonts/Poppins-Regular.ttf
    //   weight: 400
    // - asset: assets/fonts/Poppins-Medium.ttf
    //   weight: 500
    // - asset: assets/fonts/Poppins-Bold.ttf
    //   weight: 700

    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(
          await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
      bold: pw.Font.ttf(
          await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
      italic: pw.Font.ttf(
          await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
      boldItalic: pw.Font.ttf(
          await rootBundle.load("assets/fonts/Poppins-Regular.ttf")),
    );
    final pdf = pw.Document(theme: myTheme);
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text(
            'Hello World!',
          ),
        ),
      ),
    );

    // final file = File('example.pdf');
    // await file.writeAsBytes(await pdf.save());

    final fileHtml = html.File('example.pdf');
    await fileHtml.writeAsBytes(await pdf.save());
  }
}
