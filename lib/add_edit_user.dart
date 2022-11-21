// // ignore_for_file: prefer__ructors, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'package:sdp/API/devoteeAPI.dart';
// import 'package:sdp/API/userAPI.dart';
// import 'package:sdp/Models/vaktaModel.dart';
// import 'package:sdp/newDashboard.dart';
// import 'package:sdp/utility.dart';

// import 'package:uuid/uuid.dart';

// class Add_Edit_DetailsScreen extends StatefulWidget {
//   Add_Edit_DetailsScreen(
//       {Key? key, required this.title, required this.buttonText, this.vaktaData})
//       : super(key: key);
//   final String title;
//   final String buttonText;
//   VaktaModel? vaktaData;

//   @override
//   State<Add_Edit_DetailsScreen> createState() => _Add_Edit_DetailsScreenState();
// }

// class _Add_Edit_DetailsScreenState extends State<Add_Edit_DetailsScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final devoteeNameController = TextEditingController();

//   final paliDateController = TextEditingController();

//   final sanghaNameController = TextEditingController();

//   //final medicineTypeController = TextEditingController();

//   final pranamiController = TextEditingController();

//   final sammilaniYearController = TextEditingController();

//   final remarkController = TextEditingController();

//   final sammilaniNumberController = TextEditingController();
//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       devoteeNameController.text =
//           widget.vaktaData != null ? widget.vaktaData?.name ?? '' : '';

//       sanghaNameController.text =
//           widget.vaktaData != null ? widget.vaktaData?.sangha ?? '' : '';

//       pranamiController.text =
//           Utility.formatCurrency(widget.vaktaData?.pranaami);
//       paliDateController.text =
//           widget.vaktaData != null ? widget.vaktaData?.paaliDate ?? '' : '';
//       sammilaniNumberController.text =
//           widget.vaktaData != null ? widget.vaktaData?.sammilaniNo ?? '' : '';
//       sammilaniYearController.text =
//           widget.vaktaData != null ? widget.vaktaData?.sammilaniYear ?? '' : '';
//       remarkController.text =
//           widget.vaktaData != null ? widget.vaktaData?.remark ?? '' : '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         // automaticallyImplyLeading: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(8),
//           child: Center(
//             child: Container(
//               height: 900,
//               width: 600,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(10)),
//               child: Padding(
//                 padding:
//                     EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         //Devotee Name
//                         TextFormField(
//                           controller: devoteeNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Name',
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Name';
//                             } else if (!RegExp(
//                                     r'^[a-zA-Z0-9]+(?:[\w -]*[a-zA-Z0-9]+)*$')
//                                 .hasMatch(value)) {
//                               return 'Please Enter Name';
//                             }
//                             return null;
//                           },
//                         ),

//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: sanghaNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Sangha Name',
//                           ),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Sangha Name';
//                             } else if (!RegExp(
//                                     r'^[a-zA-Z0-9]+(?:[\w -]*[a-zA-Z0-9]+)*$')
//                                 .hasMatch(value)) {
//                               return 'Please Enter Sangha Name';
//                             }
//                             return null;
//                           },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: pranamiController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Pranami',
//                           ),
//                           // validator: (value) {
//                           //   if (value!.isEmpty) {
//                           //     return 'Please Enter Tab/Strip';
//                           //   } else if (!RegExp(r'^[0-9.]*$').hasMatch(value)) {
//                           //     return 'Please Enter Correct Tab/Strip';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: paliDateController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 onPressed: () async {
//                                   DateTime? selectedDate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(2022),
//                                       lastDate: DateTime(2050));
//                                   if (selectedDate != null) {
//                                     setState(() {
//                                       paliDateController.text =
//                                           DateFormat('dd-MM-yyyy')
//                                               .format(selectedDate);
//                                     });
//                                   } else {
//                                     paliDateController.text = '';
//                                   }
//                                 },
//                                 icon: Icon(Icons.calendar_month_rounded)),
//                             border: OutlineInputBorder(),
//                             labelText: 'Pali Date',
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: sammilaniNumberController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Sammilani Number',
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: sammilaniYearController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'sammilani Year',
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           maxLines: 7,
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: remarkController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Remark',
//                           ),
//                         ),
//                         SizedBox(height: 20),

//                         SizedBox(
//                           height: 20,
//                         ),

//                         ElevatedButton(
//                             onPressed: () async {
//                               // final DateTime now = DateTime.now();
//                               // final DateFormat formatter =
//                               //     DateFormat('yyyy-MM-dd');
//                               // final String formatted = formatter.format(now);
//                               // log(formatted); // something like 2013-04-20,
//                               // DateTime now = DateTime.now();
//                               // DateTime currentTime = DateTime(now.day, now.year,
//                               //     now.month, now.hour, now.minute);
//                               // log('$currentTime');
//                               final currentUserData =
//                                   await UserAPI().getCurrentUserData();
//                               // int userId = await UserAPI().countUsers();
//                               DateTime now = DateTime.now();
//                               String formattedDate =
//                                   DateFormat('yyyy-MM-dd – kk:mm').format(now);

//                               if (_formKey.currentState != null) {
//                                 if (_formKey.currentState!.validate()) {
//                                   if (widget.buttonText == 'Add') {
//                                     VaktaModel addUser = VaktaModel(
//                                       name: devoteeNameController.text.trim(),
//                                       createdBy: currentUserData?.name,
//                                       createdOn: formattedDate.toString(),
//                                       // formatted.toString(),
//                                       docId: Uuid().v1(),
//                                       pranaami: double.parse(
//                                           pranamiController.text.trim() == ''
//                                               ? '0.0'
//                                               : pranamiController.text.trim()),
//                                       remark: remarkController.text.trim(),
//                                       sammilaniNo:
//                                           sammilaniNumberController.text.trim(),
//                                       sammilaniYear:
//                                           sammilaniYearController.text.trim(),
//                                       sangha: sanghaNameController.text.trim(),
//                                       paaliDate: paliDateController.text,
//                                     );
//                                     DevoteeAPI().addUser(addUser);
//                                     Navigator.pop(context);
//                                   } else if (widget.buttonText == 'Update') {
//                                     VaktaModel editUser = VaktaModel(
//                                         name: devoteeNameController.text.trim(),
//                                         updatedBy: currentUserData?.name,
//                                         updatedOn: formattedDate.toString(),
//                                         pranaami: pranamiController.text.trim(),
//                                         remark: remarkController.text.trim(),
//                                         sammilaniNo: sammilaniNumberController
//                                             .text
//                                             .trim(),
//                                         sammilaniYear:
//                                             sammilaniYearController.text.trim(),
//                                         sangha:
//                                             sanghaNameController.text.trim(),
//                                         paaliDate: paliDateController.text,
//                                         docId: widget.vaktaData?.docId,
//                                         createdBy: widget.vaktaData?.createdBy,
//                                         createdOn: widget.vaktaData?.createdOn
//                                         //
//                                         );
//                                     await DevoteeAPI()
//                                         .editDevoteeDetails(editUser);
//                                     Navigator.push(context, MaterialPageRoute(
//                                       builder: (context) {
//                                         return NewDashboard();
//                                       },
//                                     ));
//                                   }
//                                 }
//                               }
//                             },
//                             child: Text(widget.buttonText)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
