// ignore_for_file: prefer__ructors, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:sdp/API/medicineAPI.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Models/vakta.dart';
import 'package:sdp/dashboard.dart';

import 'package:uuid/uuid.dart';

class Add_Edit_MedicineScreen extends StatefulWidget {
  Add_Edit_MedicineScreen(
      {Key? key, required this.title, required this.buttonText, this.VaktaData})
      : super(key: key);
  final String title;
  final String buttonText;
  VaktaModel? VaktaData;

  @override
  State<Add_Edit_MedicineScreen> createState() =>
      _Add_Edit_MedicineScreenState();
}

class _Add_Edit_MedicineScreenState extends State<Add_Edit_MedicineScreen> {
  String? _selectedMedicineType;

  final _formKey = GlobalKey<FormState>();

  final devoteeNameController = TextEditingController();

  final packingController = TextEditingController();

  final sanghaNameController = TextEditingController();

  final medicineTypeController = TextEditingController();

  final pranamiController = TextEditingController();

  final sammilaniYearController = TextEditingController();

  final remarkController = TextEditingController();

  final sammilaniNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        // automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Container(
              height: 900,
              width: 600,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Devotee Name
                        TextFormField(
                          controller: devoteeNameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Devotee Name',
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

                        SizedBox(height: 20),
                        TextFormField(
                          focusNode: FocusNode(
                            descendantsAreFocusable: false,
                          ),
                          controller: sanghaNameController,
                          decoration: InputDecoration(
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
                        SizedBox(height: 20),
                        TextFormField(
                          focusNode: FocusNode(
                            descendantsAreFocusable: false,
                          ),
                          controller: pranamiController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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
                        SizedBox(height: 20),
                        TextFormField(
                          focusNode: FocusNode(
                            descendantsAreFocusable: false,
                          ),
                          controller: sammilaniNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Sammilani Number',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          focusNode: FocusNode(
                            descendantsAreFocusable: false,
                          ),
                          controller: sammilaniYearController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'sammilani Year',
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLines: 7,
                          focusNode: FocusNode(
                            descendantsAreFocusable: false,
                          ),
                          controller: remarkController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Remark',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        ElevatedButton(
                            onPressed: () async {
                              String? name = await UserAPI().currentUserName();
                              log(name.toString());
                              if (_formKey.currentState!.validate()) {
                                VaktaModel vaktaDetails = VaktaModel(
                                  userId: Uuid().v1(),
                                  devoteeName: devoteeNameController.text,
                                  // medicineType: _selectedMedicineType,
                                  paaliDate: sammilaniYearController.text,
                                  pranaami: remarkController.text,

                                  createdOn: packingController.text,

                                  // sammilaniNo: DateTime.now(),
                                  sammilaniNo: name,
                                  sammilaniYear: pranamiController.text,
                                  updatedBy: sanghaNameController.text,
                                  // medicineImageURL: '',
                                  updatedOn: sanghaNameController.text,
                                  // price: double.tryParse(priceController.text),
                                  // mfgDate: DateTime.tryParse(mfgDateController
                                  //         .text
                                  //         .split('-')
                                  //         .reversed
                                  //         .join('-')) ??
                                  //     DateTime.tryParse(''),
                                  // expDate: DateTime.tryParse(expDateController
                                  //         .text
                                  //         .split('-')
                                  //         .reversed
                                  //         .join('-')) ??
                                  //     DateTime.tryParse(''),
                                );

                                if (vaktaDetails.devoteeName == '') {
                                  Navigator.of(context).pop();
                                } else {
                                  await MedicineAPI().addMedicine(vaktaDetails);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          elevation: 6,
                                          behavior: SnackBarBehavior.floating,
                                          content: Text('Added successfully')));

                                  // Navigator.of(context).pop();
                                  // setState(() {});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()));
                                }
                              }
                            },
                            child: Text(widget.buttonText)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
