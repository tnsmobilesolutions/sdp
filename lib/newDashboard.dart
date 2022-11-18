import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/devoteeAPI.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/add_edit_user.dart';
import 'package:sdp/dashboard.dart';
import 'package:sdp/showdialougeboxwidget.dart';
import 'package:sdp/table_header.dart';
import 'package:uuid/uuid.dart';

class NewDashboard extends StatefulWidget {
  NewDashboard({Key? key}) : super(key: key);

  @override
  State<NewDashboard> createState() => _NewDashboardState();
}

class _NewDashboardState extends State<NewDashboard> {
  VaktaModel? editedVaktadata;
  List<VaktaModel> devotedetails = [];
  fetchDetails() async {
    final dddevotedetails = await DevoteeAPI().fetchAllDevotees();
    setState(() {
      devotedetails = dddevotedetails;
    });
  }

  final TextEditingController sdpSearchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final devoteeNameController = TextEditingController();

  final paliDateController = TextEditingController();

  final sanghaNameController = TextEditingController();

  //final medicineTypeController = TextEditingController();

  final pranamiController = TextEditingController();

  final sammilaniYearController = TextEditingController();

  final remarkController = TextEditingController();

  final sammilaniNumberController = TextEditingController();
  String? currentAppMode;
  List<VaktaModel>? searchItem;
  APIType? type;
  bool isSelected = false;
  String _selectedSearchType = 'Name';
  VaktaModel? selectedUser;
  List<String> searchBy = [
    'Name',
    'Sangha',
    'Pali Date',
  ];
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey,
                //     offset: Offset(0.0, 1.0), //(x,y)
                //     blurRadius: 1.0,
                //   ),
                // ],
              ),
              height: 435,
              width: 400,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Devotee Name
                    TextFormField(
                      controller: devoteeNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Name';
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9]+(?:[\w -]*[a-zA-Z0-9]+)*$')
                            .hasMatch(value)) {
                          return 'Please Enter Name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 5),
                    TextFormField(
                      focusNode: FocusNode(
                        descendantsAreFocusable: false,
                      ),
                      controller: sanghaNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sangha Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Sangha Name';
                        } else if (!RegExp(
                                r'^[a-zA-Z0-9]+(?:[\w -]*[a-zA-Z0-9]+)*$')
                            .hasMatch(value)) {
                          return 'Please Enter Sangha Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      focusNode: FocusNode(
                        descendantsAreFocusable: false,
                      ),
                      controller: pranamiController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Pranami',
                      ),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Please Enter Tab/Strip';
                      //   } else if (!RegExp(r'^[0-9.]*$').hasMatch(value)) {
                      //     return 'Please Enter Correct Tab/Strip';
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      focusNode: FocusNode(
                        descendantsAreFocusable: false,
                      ),
                      controller: paliDateController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2050));
                              if (selectedDate != null) {
                                setState(() {
                                  paliDateController.text =
                                      DateFormat('dd-MM-yyyy')
                                          .format(selectedDate);
                                });
                              } else {
                                paliDateController.text = '';
                              }
                            },
                            icon: const Icon(Icons.calendar_month_rounded)),
                        border: const OutlineInputBorder(),
                        labelText: 'Pali Date',
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      focusNode: FocusNode(
                        descendantsAreFocusable: false,
                      ),
                      controller: sammilaniNumberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Sammilani Number',
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      focusNode: FocusNode(
                        descendantsAreFocusable: false,
                      ),
                      controller: sammilaniYearController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'sammilani Year',
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      focusNode: FocusNode(
                        descendantsAreFocusable: false,
                      ),
                      controller: remarkController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Remark',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Center(
              child: CupertinoButton(
                color: const Color(0XFF3f51b5),
                child: Text(buttonText),
                onPressed: () async {
                  final currentUserData = await UserAPI().getCurrentUserData();

                  DateTime now = DateTime.now();
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(now);

                  if (_formKey.currentState != null) {
                    if (_formKey.currentState!.validate()) {
                      if (buttonText == 'Add') {
                        VaktaModel addUser = VaktaModel(
                          name: devoteeNameController.text.trim(),
                          createdBy: currentUserData?.name,
                          createdOn: formattedDate.toString(),
                          // formatted.toString(),
                          docId: const Uuid().v1(),
                          pranaami: pranamiController.text.trim(),
                          remark: remarkController.text.trim(),
                          sammilaniNo: sammilaniNumberController.text.trim(),
                          sammilaniYear: sammilaniYearController.text.trim(),
                          sangha: sanghaNameController.text.trim(),
                          paaliDate: paliDateController.text,
                        );
                        await DevoteeAPI().addUser(addUser);
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NewDashboard();
                          },
                        ));
                      }
                      if (buttonText == 'Update') {
                        VaktaModel editUser = VaktaModel(
                            name: devoteeNameController.text.trim(),
                            updatedBy: currentUserData?.name,
                            updatedOn: formattedDate.toString(),
                            pranaami: pranamiController.text.trim(),
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
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return NewDashboard();
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

  var tblHelper;
  TableRow? _headingtablerow;
  TableRow? _tablerow;
  @override
  void initState() {
    super.initState();

    tblHelper = TableHelper();
    _headingtablerow = tblHelper.getTableHeader();

    fetchDetails();

    setState(() {
      currentAppMode = 'fetched';
    });
  }

  // TableRow buildRow(cell) =>
  //     TableRow(children: [cell.map((cells) => Text(cells)).tolist()]);

  @override
  Widget build(BuildContext context) {
    //DashboardList
    List<TableRow> devoteesTableRows = devotedetails.map<TableRow>((item) {
      return TableHelper().getTableRowData(item,
          //Edit
          (() {
        setState(() {
          editedVaktadata = item;
          devoteeNameController.text = item.name ?? '';
          sanghaNameController.text = item.sangha ?? '';
          pranamiController.text = item.pranaami ?? '';
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
            return NewDashboard();
          },
        ));
      }));
    }).toList();
    devoteesTableRows.insert(0, TableHelper().getTableHeader());
//SearchItem
    List<TableRow> searchRow = searchItem != null
        ? searchItem!.map<TableRow>(
            (item) {
              return TableHelper().getTableRowData(
                item,
                (() {
                  setState(() {
                    editedVaktadata = item;
                    devoteeNameController.text = item.name ?? '';
                    sanghaNameController.text = item.sangha ?? '';
                    pranamiController.text = item.pranaami ?? '';
                    paliDateController.text = item.paaliDate ?? '';
                    sammilaniNumberController.text = item.sammilaniNo ?? '';
                    sammilaniYearController.text = item.sammilaniYear ?? '';
                    remarkController.text = item.remark ?? '';
                  });
                  showdilouge('Update Devotee Details', 'Update');
                }),
                (() {
                  DevoteeAPI().removeDevotee(item.docId);
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return NewDashboard();
                    },
                  ));
                }),
              );
            },
          ).toList()
        : [];
    searchRow.insert(0, TableHelper().getTableHeader());

    // List<TableRow> searchTableRows =
    // searchTableRows.insert(0, TableHelper().getTableHeader());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sammilani Dinikia Pali'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(15)),
              width: 500,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      controller: sdpSearchController,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {},
                      onChanged: (value) async {
                        final result = await DevoteeAPI()
                            .searchSDP(_selectedSearchType, value);
                        setState(() {
                          searchItem = result;
                        });
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          prefixIcon: IconButton(
                              onPressed: () async {
                                final result = await DevoteeAPI().searchSDP(
                                    _selectedSearchType,
                                    sdpSearchController.text);
                                setState(() {
                                  searchItem = result;
                                });
                              },
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                          contentPadding: const EdgeInsets.all(15),
                          hintText: 'Search item',
                          suffixIcon: _selectedSearchType == 'Pali Date'
                              ? IconButton(
                                  onPressed: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2022),
                                            lastDate: DateTime(2050));
                                    if (selectedDate != null) {
                                      setState(() {
                                        sdpSearchController.text =
                                            DateFormat('dd-MM-yyyy')
                                                .format(selectedDate);
                                      });
                                    } else {
                                      sdpSearchController.text = '';
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: Colors.white,
                                  ))
                              : null),
                      onTap: () {},
                    ),
                  ),
                  DropdownButton(
                    // focusColor: Colors.white,
                    hint: const Text('Search By'),
                    borderRadius: BorderRadius.circular(15),
                    value: _selectedSearchType,
                    onChanged: (value) {
                      setState(() {
                        _selectedSearchType = value.toString();
                      });
                    },
                    items: searchBy.map(
                      (val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    iconEnabledColor: Colors.white,

                    iconDisabledColor: Colors.black,
                    iconSize: 40,
                    icon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.white,
                    ),
                    underline: const Text(''),
                  ),
                ],
              ),
            ),
          ),
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
          IconButton(
            onPressed: () {
              UserAPI().logout();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const EmailSignIn();
                },
              ));
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: searchItem == null
          ? SafeArea(
              child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
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
                            return Table(
                              border: TableBorder
                                  .all(), // Allows to add a border decoration around your table
                              children: devoteesTableRows,
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
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Table(
                  border: TableBorder
                      .all(), // Allows to add a border decoration around your table
                  children: searchRow),
            ),
    );
  }
}
