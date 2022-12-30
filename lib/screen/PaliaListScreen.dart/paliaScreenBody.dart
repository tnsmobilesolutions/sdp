import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaTableData.dart';

class PaliaListBodyPage extends StatefulWidget {
  const PaliaListBodyPage({super.key});

  @override
  State<PaliaListBodyPage> createState() => _PaliaListBodyPageState();
}

class _PaliaListBodyPageState extends State<PaliaListBodyPage> {
  List<VaktaModel>? allPaliaList;

  bool showMenu = false;
  Expanded headingText(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  pw.Expanded printSearchheadingText(String text) {
    return pw.Expanded(
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 20,
          // font: baloobhainaheading,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      showMenu = !showMenu;
                    });
                  },
                  color: Color(0XFF3f51b5),
                  icon: const Icon(Icons.menu_open)),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: IconButton(
                    color: Color(0XFF3f51b5),
                    onPressed: () async {
                      final _baloobhaina2font =
                          await PdfGoogleFonts.balooBhaina2Regular();
                      final doc = pw.Document();
                      doc.addPage(
                        pw.Page(
                          pageFormat: PdfPageFormat.a4,
                          build: (pw.Context context) {
                            return pw.Column(children: [
                              pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      'ଜୟଗୁରୁ',
                                      style: pw.TextStyle(
                                        decoration: pw.TextDecoration.underline,
                                        font: _baloobhaina2font,
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.normal,
                                      ),
                                    ),
                                  ]),
                              pw.Column(
                                children: [
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                          'Total Record - ${allPaliaList?.length}'),
                                    ],
                                  )
                                ],
                              ),
                              pw.Divider(),
                              pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  children: []),
                              pw.SizedBox(height: 20),
                              pw.Row(children: [
                                printSearchheadingText('Sl no.'),
                                printSearchheadingText('Palia Name'),
                                printSearchheadingText('Sangha'),
                                printSearchheadingText('pali Date'),
                              ]),
                              pw.Divider(thickness: 0.5),
                              // pw.SizedBox(
                              //   height: 12,
                              // ),
                              pw.Expanded(
                                child: pw.ListView.builder(
                                  itemCount: allPaliaList != null
                                      ? allPaliaList!.length
                                      : 0,
                                  itemBuilder: (pw.Context context, int index) {
                                    return pw.Column(
                                      children: [
                                        pw.Row(
                                          children: [
                                            pw.Expanded(
                                              child: pw.Text(
                                                (index).toString(),
                                                textAlign: pw.TextAlign.center,
                                              ),
                                            ),
                                            pw.Expanded(
                                              child: pw.Text(
                                                '${allPaliaList?[index].name}',
                                                textAlign: pw.TextAlign.center,
                                              ),
                                            ),
                                            pw.Expanded(
                                              child: pw.Text(
                                                '${allPaliaList?[index].sangha}',
                                                textAlign: pw.TextAlign.center,
                                              ),
                                            ),
                                            pw.Expanded(
                                              child: pw.Text(
                                                '${allPaliaList?[index].paaliDate}',
                                                textAlign: pw.TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Divider(
                                          thickness: 0.5,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ]);
                          },
                        ),
                      ); //
                      PdfPreview(
                        build: (format) => doc.save(),
                      );
                      await Printing.layoutPdf(
                          onLayout: (PdfPageFormat format) async => doc.save());
                    },
                    icon: const Icon(Icons.print)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Center(
                        child: Checkbox(value: false, onChanged: (value) {}))),
                headingText('କ୍ରମିକ ନଂ'),
                headingText('ପାଳିଆ ନାମ'),
                headingText('ସଂଘ'),
                headingText('ପାଳି ତାରିଖ'),
                if (showMenu == true) headingText('View'),
                if (showMenu == true) headingText('Edit'),
                if (showMenu == true) headingText('Delete'),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          FutureBuilder(
            future: PaliaAPI().fetchAllPalias(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              allPaliaList = snapshot.data;
              if (snapshot.hasError) {
                return const Text('SNAPSHOT ERROR');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Table firebase Data
                      return PaliaTableData(
                        showMenu: showMenu,
                        slNo: index + 1,
                        paliaDetails: snapshot.data[index],
                      );
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
