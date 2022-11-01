// ignore_for_file: prefer__ructors, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sdp/API/medicineAPI.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
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

  final paliDateController = TextEditingController();

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
                                icon: Icon(Icons.calendar_month_rounded)),
                            border: OutlineInputBorder(),
                            labelText: 'Pali Date',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                        SizedBox(height: 20),

                        SizedBox(
                          height: 20,
                        ),

                        ElevatedButton(
                            onPressed: () async {
                              DateTime now = DateTime.now();
                              DateTime currentTime = DateTime(now.day,
                                  now.month, now.year, now.hour, now.minute);
                              log('$currentTime');
                              final name = await UserAPI().currentUserName();
                              int userId = await UserAPI().countUsers();
                              if (widget.buttonText == 'Add') {
                                if (_formKey.currentState != null) {
                                  if (_formKey.currentState!.validate()) {
                                    VaktaModel user = VaktaModel(
                                      name: devoteeNameController.text.trim(),
                                      createdBy: name,
                                      createdOn: currentTime,
                                      docId: 'U${userId + 1}',
                                      pranaami: pranamiController.text.trim(),
                                      remark: remarkController.text.trim(),
                                      sammilaniNo:
                                          sammilaniNumberController.text.trim(),
                                      sammilaniYear:
                                          sammilaniYearController.text.trim(),
                                      sangha: sanghaNameController.text.trim(),
                                      paaliDate: DateTime.tryParse(
                                              paliDateController.text
                                                  .split('-')
                                                  .reversed
                                                  .join('-')) ??
                                          DateTime.tryParse(''),
                                    );
                                  }
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
