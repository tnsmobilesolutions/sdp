// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sdp/API/medicineAPI.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/add_edit_medicine.dart';
import 'package:sdp/dataTable.dart';
import 'package:sdp/edit_medicine.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

enum APIType { search, fetchAll }

class _DashboardState extends State<Dashboard> {
  final TextEditingController sdpSearchController = TextEditingController();
  String searchItem = '';
  APIType? type;
  bool isSelected = false;
  String? _selectedSearchType;
  VaktaModel? selectedUser;
  List<String> searchBy = ['Name', 'Sangha', 'Paali Date', 'Devotee'];
  @override
  void initState() {
    super.initState();
    setState(() {
      type = APIType.fetchAll;
    });
  }

  onRowSelected(value) {
    setState(() {
      selectedUser = value;
    });
  }

  isRowselected(value) {
    setState(() {
      isSelected = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              UserAPI().logout();
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return EmailSignIn();
                },
              ));
            },
            icon: Icon(Icons.logout_rounded),
          )
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Sammilani Dinikia Paali'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      autofocus: false,
                      controller: sdpSearchController,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {},
                      onChanged: (value) {
                        setState(() {
                          searchItem = value.toLowerCase();
                        });
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () async {
                              setState(() {
                                type = APIType.search;
                              });
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.blue,
                            )),
                        contentPadding: EdgeInsets.all(15),
                        hintText: 'Search By',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: DropdownButton(
                          focusColor: Colors.grey,
                          hint: Text('Search By'),
                          borderRadius: BorderRadius.circular(15),
                          value: _selectedSearchType,
                          onChanged: (value) {
                            setState(() {
                              _selectedSearchType = value;
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
                          iconEnabledColor: Colors.blue,
                          iconDisabledColor: Colors.blue,
                          iconSize: 40,
                          icon: Icon(Icons.arrow_drop_down_outlined),
                          underline: Text(''),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: (() async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Add_Edit_MedicineScreen(
                                  title: 'Add Member', buttonText: 'Add')));
                      setState(() {});
                    }),
                    child: SizedBox(
                      height: 40,
                      width: 70,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.add),
                            //Text('Add'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: (() {
                      if (selectedUser != null && isSelected) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Add_Edit_MedicineScreen(
                              VaktaData: selectedUser,
                              title: 'Edit Details',
                              buttonText: 'Edit',
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            elevation: 6,
                            behavior: SnackBarBehavior.floating,
                            content: Text('select a Devotee first')));
                      }
                    }),
                    child: SizedBox(
                      height: 40,
                      width: 70,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.mode_edit_outline_rounded),
                            //Text('Edit'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(10),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: (() async {
                      if (selectedUser != null) {
                        await MedicineAPI()
                            .removeMedicine(selectedUser?.userId);
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            elevation: 6,
                            behavior: SnackBarBehavior.floating,
                            content: Text('Removed successfully')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            elevation: 6,
                            behavior: SnackBarBehavior.floating,
                            content: Text('Choose a medicine first')));
                      }
                    }),
                    child: SizedBox(
                      height: 40,
                      width: 70,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.delete),
                            // Text('Delete'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: FutureBuilder(
                  future: type == APIType.fetchAll
                      ? MedicineAPI().fetchAllMedicines()
                      : MedicineAPI()
                          .searchSDP(_selectedSearchType, searchItem),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print('allMeds from Dashboard - ${snapshot.data}');
                    return DataTableView(
                      allMeds: snapshot.data,
                      onRowTapped: onRowSelected,
                      isRowSelected: isRowselected,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
