import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/Models/sammilaniModel.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/add_edit_dilougeBox.dart';
import 'package:sdp/homeScreen.dart';
import 'package:sdp/newSearch.dart';
import 'package:sdp/search.dart';
import 'package:uuid/uuid.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final PaliaNameController = TextEditingController();
  final paliDateController = TextEditingController();
  final receiptDateController = TextEditingController();
  final sanghaNameController = TextEditingController();
  final sammilaniPlaceController = TextEditingController();
  final pranamiController = TextEditingController();
  final sammilaniYearController = TextEditingController();
  final remarkController = TextEditingController();
  final sammilaniNumberController = TextEditingController();
  final receiptNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  VaktaModel? editedVaktadata;
  List<VaktaModel>? searchItem;
  // List<VaktaModel> devotedetails = [];
  int dashboardindexNumber = 0;
  int searchDasboardIndexNumber = 0;
  int printDashboardIndexNumber = 0;
  int printSearchIndexNumber = 0;
  bool showButtons = false;
  String? selectedtypesearch;
  String? sdpseacrchfield;
  var baloobhaina2font;
  var notoSansfont;
  @override
  Widget build(BuildContext context) {
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
              receiptDateController: receiptDateController,
              receiptNumberController: receiptNumberController,
              PaliaNameController: PaliaNameController,
              formKey: _formKey,
              paliDateController: paliDateController,
              pranamiController: pranamiController,
              remarkController: remarkController,
              sammilaniNumberController: sammilaniNumberController,
              sammilaniYearController: sammilaniYearController,
              sanghaNameController: sanghaNameController,
              sammilaniPlaceController: sammilaniPlaceController,
            )),
            actions: <Widget>[
              Center(
                child: CupertinoButton(
                  color: const Color(0XFF3f51b5),
                  child: Text(buttonText),
                  onPressed: () async {
                    final currentUserData =
                        await UserAPI().getCurrentUserData();

                    DateTime now = DateTime.now();
                    String formattedDate =
                        DateFormat('dd-MMM-yyyy  hh:mm a').format(now);
                    // DateFormat('yyyy-MM-dd – kk:mm').format(now);

                    if (_formKey.currentState != null) {
                      if (_formKey.currentState!.validate()) {
                        if (buttonText == 'Add') {
                          VaktaModel addUser = VaktaModel(
                            sammilaniData: SammilaniModel(
                                sammilaniNumber:
                                    sammilaniNumberController.text.trim(),
                                sammilaniYear:
                                    sammilaniYearController.text.trim(),
                                sammilaniPlace:
                                    sammilaniPlaceController.text.trim()),
                            name: PaliaNameController.text.trim(),
                            createdBy: currentUserData?.name,
                            createdOn: formattedDate.toString(),
                            // formatted.toString(),
                            docId: const Uuid().v1(),
                            pranaami: double.parse(
                                pranamiController.text.trim() == ''
                                    ? '0.0'
                                    : pranamiController.text.trim()),
                            remark: remarkController.text.trim(),
                            sangha: sanghaNameController.text.trim(),
                            paaliDate: paliDateController.text,
                            receiptDate: receiptDateController.text,
                            receiptNo: receiptNumberController.text,
                          );
                          await PaliaAPI().addUser(addUser);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const HomeScreen();
                            },
                          ));
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

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(
          child: Image(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
              height: 5.00,
              width: 20.00),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          'ସମ୍ମିଳନୀ ଦିନିକିଆ ପାଳି',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                ),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();
                  },
                ));
              },
              child: const Text('View Palia'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 1.0,
                  color: Colors.white,
                ),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Search Palia'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchSDP(
                        dashboardindexNumber: 0,
                        searchDasboardIndexNumber: 0,
                        onSubmitPress:
                            (result, selectedSearchType, sdpSearchController) {
                          searchDasboardIndexNumber = 0;
                          dashboardindexNumber = 0;
                          log(selectedSearchType);
                          log(sdpSearchController);
                          setState(() {
                            selectedtypesearch = selectedSearchType;
                            sdpseacrchfield = sdpSearchController;
                            searchItem = result;
                            print(result);
                          });
                        },
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Search'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed: (() {
                  dashboardindexNumber = 0;
                  searchDasboardIndexNumber = 0;
                  printDashboardIndexNumber = 0;
                  printSearchIndexNumber = 0;
                  showdilouge(
                    'Add Palia',
                    'Add',
                  );
                  PaliaNameController.text = '';

                  sanghaNameController.text = '';

                  pranamiController.text = '';
                  paliDateController.text = '';
                  sammilaniNumberController.text = '';
                  sammilaniYearController.text = '';
                  sammilaniPlaceController.text = '';
                  remarkController.text = '';
                  receiptDateController.text = '';
                  receiptNumberController.text = '';

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => Add_Edit_DetailsScreen(
                  //             title: 'Add Member', buttonText: 'Add')));
                }),
                child: const Text(
                  'Add Palia',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          // const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                // style: ButtonStyle(
                //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(15.0))),
                // ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Colors.white,
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  UserAPI().logout();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const EmailSignIn();
                    },
                  ));
                },
                child: const Text('Logout'),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Card(
                      elevation: 20,
                      shadowColor: const Color(0XFF3f51b5),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  '71',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'ସମ୍ମିଳନୀ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '2022',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                //  Text(
                                //       '71 ସମ୍ମିଳନୀ\n2000 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
                                //       style: TextStyle(
                                //           fontSize: 20, fontWeight: FontWeight.bold),
                                // ),
                              ],
                            ),
                            const Text(
                              'Satsikhya Mandir, Bhubaneswar',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: const [
                                Text(
                                  '2000',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  ' ଦିନିକିଆ ପାଳି',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 4,
                    child: const Card(
                      elevation: 20,
                      shadowColor: Color(0XFF3f51b5),
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          '70th ସମ୍ମିଳନୀ\n1500 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 4,
                    child: const Card(
                      elevation: 20,
                      shadowColor: Color(0XFF3f51b5),
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          '69th ସମ୍ମିଳନୀ\n1000 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 4,
                    child: const Card(
                      elevation: 20,
                      shadowColor: Color(0XFF3f51b5),
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          '68th ସମ୍ମିଳନୀ\n500 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 4,
                    child: const Card(
                      elevation: 20,
                      shadowColor: Color(0XFF3f51b5),
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          '67th ସମ୍ମିଳନୀ\n200 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 4,
                    child: const Card(
                      elevation: 20,
                      shadowColor: Color(0XFF3f51b5),
                      child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          '66th ସମ୍ମିଳନୀ\n100 ଦିନିକିଆ ପାଳି\nSatsikhya Mandir, Bhubaneswar',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
