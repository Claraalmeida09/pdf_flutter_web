import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class PdfDemo extends StatelessWidget {
  Future<html.Blob> myGetBlobPdfContent() async {
    var data = await rootBundle.load("fonts/Poppins-Regular.ttf");
    var myFont = pw.Font.ttf(data);
    var myStyle = pw.TextStyle(
      font: myFont,
      fontSize: 12,
    );
    var date = DateTime.now().toString();

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  children: [
                    pw.Center(
                      child: pw.Text(
                          "Comprovante de prestação de informações para realização de cadastro"
                              .toUpperCase(),
                          style: myStyle,
                          textAlign: pw.TextAlign.center),
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text("Cartão",
                            style: myStyle, textAlign: pw.TextAlign.center),
                        pw.SizedBox(width: 10),
                        pw.Text("C",
                            style: pw.TextStyle(
                                font: myFont,
                                fontSize: 12,
                                color: PdfColor.fromHex('#ee3d5b')),
                            textAlign: pw.TextAlign.center),
                        pw.Text("R",
                            style: pw.TextStyle(
                                font: myFont,
                                fontSize: 12,
                                color: PdfColor.fromHex('#0abdd0')),
                            textAlign: pw.TextAlign.center),
                        pw.Text("I",
                            style: pw.TextStyle(
                                font: myFont,
                                fontSize: 12,
                                color: PdfColor.fromHex('#f58d3a')),
                            textAlign: pw.TextAlign.center),
                        pw.Text("A",
                            style: pw.TextStyle(
                                font: myFont,
                                fontSize: 12,
                                color: PdfColor.fromHex('#8dc957')),
                            textAlign: pw.TextAlign.center),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Declaro, para os devidos fins, que Fulano Beltrano Cicrano, portador do NIS 12312312312, foi cadastrado(a) como beneficiário(a) no Cartão CRIA pelo profissional Fulano Beltrano Cicrano no dia 00/00/0000.',
                  style: myStyle,
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 15),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      children: [
                        pw.Text(
                          '__________________________________',
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          'Assinatura do(a) Profissional',
                          style: myStyle,
                        )
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Text(
                          '__________________________________',
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          'Assinatura do Beneficiário(a)',
                          style: myStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                pw.Text(
                  'Município - AL, (dia) de (mês) de (ano).',
                  style: myStyle,
                ),
                pw.SizedBox(height: 15),
                // pw.Center(
                //   child: pw.Text(
                //     date,
                //     style: myStyle,
                //   ),
                // ),
              ],
            );
          }),
    );
    final bytes = await pdf.save();
    html.Blob blob = html.Blob([bytes], 'application/pdf');
    return blob;
  }

  @override
  Widget build(BuildContext context) {
    myGetBlobPdfContent();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: const Text("Open"),
              onPressed: () async {
                final url = html.Url.createObjectUrlFromBlob(
                    await myGetBlobPdfContent());
                html.window.open(url, "_blank");
                html.Url.revokeObjectUrl(url);
              },
            ),
            RaisedButton(
              child: const Text("Download"),
              onPressed: () async {
                final url = html.Url.createObjectUrlFromBlob(
                    await myGetBlobPdfContent());
                final anchor =
                    html.document.createElement('a') as html.AnchorElement
                      ..href = url
                      ..style.display = 'none'
                      ..download = 'comprovante.pdf';
                html.document.body!.children.add(anchor);
                anchor.click();
                html.document.body!.children.remove(anchor);
                html.Url.revokeObjectUrl(url);
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
