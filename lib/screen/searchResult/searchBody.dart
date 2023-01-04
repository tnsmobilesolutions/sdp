import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/editPaliMultiple.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:sdp/screen/searchResult/searchtableRow.dart';

class searchresultBodyPage extends StatefulWidget {
  searchresultBodyPage({Key? key, required this.searchModel}) : super(key: key);
  List<VaktaModel> searchModel;

  @override
  State<searchresultBodyPage> createState() => _searchresultBodyPageState();
}

class _searchresultBodyPageState extends State<searchresultBodyPage> {
  // dynamic baloobhainaheading;
  // font() async {
  //   final a = await PdfGoogleFonts.notoSansOriyaRegular();
  //   setState(() {
  //     baloobhainaheading = a;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   font();
  // }
  List<String> selectedPalia = [];
  bool checkedValue = false;
  bool? allCheck;

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
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: multipleEditPali(
                    docIds: selectedPalia,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ));
                  },
                  child: Text('Reset')),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Color(0XFF3f51b5),
                  ),
                  foregroundColor: Color(0XFF3f51b5),
                ),
                onPressed: () {
                  setState(() {
                    showMenu = !showMenu;
                  });
                },
                child: Text('Show Menu'),
              ),
              SizedBox(
                width: 10,
              ),
              //Print
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 1.0,
                      color: Color(0XFF3f51b5),
                    ),
                    foregroundColor: Color(0XFF3f51b5),
                  ),
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
                                mainAxisAlignment: pw.MainAxisAlignment.center,
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
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                    pw.Text(
                                        'Total Record - ${widget.searchModel.length}'),
                                    pw.Text(
                                        'Total Pranami = ${widget.searchModel.length} × 1101 = ${(widget.searchModel.length) * (1101)} ')
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
                                itemCount: widget.searchModel.length,
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
                                              '${widget.searchModel[index].name}',
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${widget.searchModel[index].sangha}',
                                              textAlign: pw.TextAlign.center,
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${widget.searchModel[index].paaliDate}',
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
                  child: Text('Print'),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Checkbox(
                      value: allCheck ?? false,
                      onChanged: (value) async {
                        print('**Allcheck Value $value');

                        setState(() {
                          allCheck = value!;

                          widget.searchModel.forEach((e) {
                            if (allCheck == true) {
                              if (!selectedPalia.contains(e)) {
                                selectedPalia.add(e.docId.toString());
                                print('***ALLTRUE***$selectedPalia');
                              }
                            } else {
                              selectedPalia.remove(e.docId);
                              print('***ALLFALSE***$selectedPalia');
                              if (selectedPalia == []) {
                                setState(() {});
                              }
                            }
                          });
                        });
                      }),
                )),
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
          Expanded(
            child: ListView.builder(
              itemCount: widget.searchModel.length,
              itemBuilder: (BuildContext context, int index) {
                //Table firebase Data
                return searchTableRow(
                  isCheckedBoolValue: (isCheckedValuee) {
                    checkedValue = isCheckedValuee;
                    if (isCheckedValuee == true) {
                      if (!selectedPalia
                          .contains(widget.searchModel[index].docId)) {
                        selectedPalia
                            .add(widget.searchModel[index].docId.toString());

                        print('***SELECTEDTRUE***$selectedPalia');
                      }
                    } else {
                      selectedPalia.remove(widget.searchModel[index].docId);
                      print('***SELECTED FALSE***$selectedPalia');
                      if (selectedPalia == []) {
                        setState(() {});
                      }
                    }
                  },
                  showMenu: showMenu,
                  slNo: index,
                  searchpaliaDetails: widget.searchModel[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
