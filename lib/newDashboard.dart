import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/devoteeAPI.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sdp/add_edit_dilougeBox.dart';
import 'package:sdp/search.dart';
import 'package:sdp/table_header.dart';
import 'package:sdp/utility.dart';
import 'package:sdp/viewDevotee.dart';
import 'package:uuid/uuid.dart';

// typedef OnSearchPress = void Function(List<VaktaModel>?);

class NewDashboard extends StatefulWidget {
  const NewDashboard({Key? key}) : super(key: key);

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  // List<VaktaModel>? searchItem;
  VaktaModel? editedVaktadata;
  List<VaktaModel>? searchItem;
  List<VaktaModel> devotedetails = [];
  bool showButtons = false;
  fetchDetails() async {
    final dddevotedetails = await DevoteeAPI().fetchAllDevotees();
    setState(() {
      devotedetails = dddevotedetails;
    });
  }

  final _formKey = GlobalKey<FormState>();

  final devoteeNameController = TextEditingController();

  final paliDateController = TextEditingController();

  final sanghaNameController = TextEditingController();

  //final medicineTypeController = TextEditingController();

  final pranamiController = TextEditingController();

  final sammilaniYearController = TextEditingController();

  final remarkController = TextEditingController();

  final sammilaniNumberController = TextEditingController();
  // String? currentAppMode;

  // APIType? type;
  bool isSelected = false;

  VaktaModel? selectedUser;

  showViewDialouge(VaktaModel item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Devotee Detils',
                    style: TextStyle(
                      color: Color(0XFF3f51b5),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: Color(0XFF3f51b5)))
                ],
              ),
              content: ViewDevotee(item: item));
        });
  }

  showdilouge(
    String title,
    String buttonText,
  ) {
    showDialog(
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF3f51b5),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          content: SingleChildScrollView(
              child: Add_Edit_Dialougebox(
            devoteeNameController: devoteeNameController,
            formKey: _formKey,
            paliDateController: paliDateController,
            pranamiController: pranamiController,
            remarkController: remarkController,
            sammilaniNumberController: sammilaniNumberController,
            sammilaniYearController: sammilaniYearController,
            sanghaNameController: sanghaNameController,
          )),
          actions: <Widget>[
            Center(
              child: CupertinoButton(
                color: const Color(0XFF3f51b5),
                child: Text(buttonText),
                onPressed: () async {
                  final currentUserData = await UserAPI().getCurrentUserData();

                  DateTime now = DateTime.now();
                  String formattedDate =
                      DateFormat('dd-MM-yyyy  hh:mm a').format(now);
                  // DateFormat('yyyy-MM-dd – kk:mm').format(now);

                  if (_formKey.currentState != null) {
                    if (_formKey.currentState!.validate()) {
                      if (buttonText == 'Add') {
                        VaktaModel addUser = VaktaModel(
                          name: devoteeNameController.text.trim(),
                          createdBy: currentUserData?.name,
                          createdOn: formattedDate.toString(),
                          // formatted.toString(),
                          docId: const Uuid().v1(),
                          pranaami: double.parse(
                              pranamiController.text.trim() == ''
                                  ? '0.0'
                                  : pranamiController.text.trim()),
                          remark: remarkController.text.trim(),
                          sammilaniNo: sammilaniNumberController.text.trim(),
                          sammilaniYear: sammilaniYearController.text.trim(),
                          sangha: sanghaNameController.text.trim(),
                          paaliDate: paliDateController.text,
                        );
                        await DevoteeAPI().addUser(addUser);
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const NewDashboard();
                          },
                        ));
                      }
                      if (buttonText == 'Update') {
                        VaktaModel editUser = VaktaModel(
                            name: devoteeNameController.text.trim(),
                            updatedBy: currentUserData?.name,
                            updatedOn: formattedDate.toString(),
                            pranaami: double.parse(
                                pranamiController.text.trim() == ''
                                    ? '0.0'
                                    : pranamiController.text.trim()),
                            remark: remarkController.text.trim(),
                            sammilaniNo: sammilaniNumberController.text.trim(),
                            sammilaniYear: sammilaniYearController.text.trim(),
                            sangha: sanghaNameController.text.trim(),
                            paaliDate: paliDateController.text,
                            docId: editedVaktadata?.docId,
                            createdBy: editedVaktadata?.createdBy,
                            createdOn: editedVaktadata?.createdOn
                            //
                            );
                        await DevoteeAPI().editDevoteeDetails(editUser);
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const NewDashboard();
                          },
                        ));
                        // Navigator.pop(context);
                        // setState(() {});
                      }
                    }
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    //DashboardList
    List<TableRow> devoteesTableRows = devotedetails.map<TableRow>((item) {
      // List<Map<String, dynamic>> _data = List.generate(200, ((index) => {}));
      return TableHelper().getTableRowData(item,

          //View
          () {
        showViewDialouge(item);
      },
          //Edit
          (() {
        setState(() {
          editedVaktadata = item;
          devoteeNameController.text = item.name ?? '';
          sanghaNameController.text = item.sangha ?? '';
          pranamiController.text = item.pranaami.toString();
          paliDateController.text = item.paaliDate ?? '';
          sammilaniNumberController.text = item.sammilaniNo ?? '';
          sammilaniYearController.text = item.sammilaniYear ?? '';
          remarkController.text = item.remark ?? '';
        });
        showdilouge('Update Devotee Details', 'Update');
      }),
          //delete
          (() {
        DevoteeAPI().removeDevotee(item.docId);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const NewDashboard();
          },
        ));
      }), showButtons);
    }).toList();
    devoteesTableRows.insert(0, TableHelper().getTableHeader(showButtons));
//SearchItem
    List<TableRow> searchRow = searchItem != null
        ? searchItem!.map<TableRow>(
            (item) {
              return TableHelper().getTableRowData(item,
                  //view
                  () {
                showViewDialouge(item);
              },
                  //Edit
                  (() {
                setState(() {
                  editedVaktadata = item;
                  devoteeNameController.text = item.name ?? '';
                  sanghaNameController.text = item.sangha ?? '';
                  pranamiController.text =
                      Utility.formatCurrency(item.pranaami);
                  paliDateController.text = item.paaliDate ?? '';
                  sammilaniNumberController.text = item.sammilaniNo ?? '';
                  sammilaniYearController.text = item.sammilaniYear ?? '';
                  remarkController.text = item.remark ?? '';
                });
                showdilouge('Update Devotee Details', 'Update');
              }),
                  //delete
                  (() {
                DevoteeAPI().removeDevotee(item.docId);
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const NewDashboard();
                  },
                ));
              }), showButtons);
            },
          ).toList()
        : [];
    searchRow.insert(0, TableHelper().getTableHeader(showButtons));

    final List<int> _data = List.generate(100,
        (i) => i); // generate a sample data ( integers ) list of 100 length
    int _page = 0; // default page to 0
    final int _perPage = 2; // per page items you want to show
    final dataToShow = _data.sublist(
        (_page * _perPage),
        ((_page * _perPage) +
            _perPage)); // extract a list of items to show on per page basis

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Image(
            image: AssetImage('assets/images/login.png'),
            fit: BoxFit.contain,
            height: 60,
            width: 60,
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Sammilani Dinikia Pali'),
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchSDP(
                onSubmitPress: (result) {
                  setState(() {
                    searchItem = result;
                  });
                },
              )),
          CupertinoButton(
            onPressed: (() {
              showdilouge(
                'Add Devotee',
                'Add',
              );
              devoteeNameController.text = '';

              sanghaNameController.text = '';

              pranamiController.text = '';
              paliDateController.text = '';
              sammilaniNumberController.text = '';
              sammilaniYearController.text = '';
              remarkController.text = '';

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => Add_Edit_DetailsScreen(
              //             title: 'Add Member', buttonText: 'Add')));
            }),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                UserAPI().logout();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const EmailSignIn();
                  },
                ));
              },
              icon: const Icon(Icons.logout_rounded),
            ),
          ),
        ],
      ),
      body: searchItem == null
          ? SafeArea(
              child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showButtons = !showButtons;
                          });
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Color(0XFF3f51b5),
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () async {
                          final doc = pw.Document();
                          // await Printing.layoutPdf(
                          // onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
                          //       format: format,
                          //       html: '<html><body><p>Hello!</p></body></html>',
                          //     ));

                          doc.addPage(pw.Page(
                              pageFormat: PdfPageFormat.a4,
                              build: (pw.Context context) {
                                return pw.Center(
                                  child: pw.Text('Hello World'),
                                ); // Center
                              }));
                          PdfPreview(
                            build: (format) => doc.save(),
                          );
                          await Printing.layoutPdf(
                              onLayout: (PdfPageFormat format) async =>
                                  doc.save());

                          print(doc);
                        },
                        icon: const Icon(
                          Icons.print,
                          color: Color(0XFF3f51b5),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: DevoteeAPI().fetchAllDevotees(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return const Text('SNAPSHOT ERROR');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(0.2),
                                        1: FlexColumnWidth(1),
                                        2: FlexColumnWidth(1),
                                        3: FlexColumnWidth(0.5),
                                        4: FlexColumnWidth(0.5),
                                        5: FlexColumnWidth(0.5),
                                        6: FlexColumnWidth(0.5),
                                      }, // border: TableBorder.symmetric(
                                      //   inside: BorderSide.none,
                                      //   outside: BorderSide.none,
                                      // ),
                                      border: TableBorder
                                          .all(), // Allows to add a border decoration around your table
                                      children: devoteesTableRows,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text('Items Per Page'),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _page -= 1;
                                              });
                                            },
                                            icon: Icon(Icons.arrow_left)),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _page += 1;
                                              });
                                            },
                                            icon: Icon(Icons.arrow_right))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          ));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(' Search Item - ${searchItem?.length}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const NewDashboard();
                                    },
                                  ));
                                },
                                child: const Text('Reset')),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  showButtons = !showButtons;
                                });
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Color(0XFF3f51b5),
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () async {
                                final doc = pw.Document();
                                // await Printing.layoutPdf(
                                // onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
                                //       format: format,
                                //       html: '<html><body><p>Hello!</p></body></html>',
                                //     ));

                                doc.addPage(pw.Page(
                                    pageFormat: PdfPageFormat.a4,
                                    build: (pw.Context context) {
                                      return pw.Center(
                                        child: pw.Text('Hello World'),
                                      ); // Center
                                    }));
                                PdfPreview(
                                  build: (format) => doc.save(),
                                );
                                await Printing.layoutPdf(
                                    onLayout: (PdfPageFormat format) async =>
                                        doc.save());

                                print(doc);
                              },
                              icon: const Icon(
                                Icons.print,
                                color: Color(0XFF3f51b5),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Table(
                        border: TableBorder
                            .all(), // Allows to add a border decoration around your table
                        children: searchRow),
                  ],
                ),
              ),
            ),
    );
  }
}
