// // ignore_for_file: prefer__ructors, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:sdp/API/medicineAPI.dart';
// import 'package:sdp/Models/medicineModel.dart';
// import 'package:sdp/dashboard.dart';
// import 'package:sdp/pick_image.dart';

// import 'package:uuid/uuid.dart';

// class EditMedicineScreen extends StatefulWidget {
//   EditMedicineScreen({super.key, this.VaktaData});
//   VaktaModel? VaktaData;

//   @override
//   State<EditMedicineScreen> createState() => _EditMedicineScreenState();
// }

// class _EditMedicineScreenState extends State<EditMedicineScreen> {
//   String? _selectedMedicineType;
//   List<String> medicineTypes = ['Allopathy', 'Homeopathy', 'Ayurvedic'];

//   final _formKey = GlobalKey<FormState>();
//   final medicineNameController = TextEditingController();
//   final packingController = TextEditingController();
//   final companyNameController = TextEditingController();
//   final medicineTypeController = TextEditingController();
//   final genericNameController = TextEditingController();
//   final cimsClassController = TextEditingController();
//   final formController = TextEditingController();
//   final contentsController = TextEditingController();
//   final actClassificationController = TextEditingController();
//   final tabPerStripController = TextEditingController();
//   final priceController = TextEditingController();
//   final mfgDateController = TextEditingController();
//   final expDateController = TextEditingController();
//   final descriptionController = TextEditingController();

//   String prescriptionURL = '';
//   late XFile imageFromUploadButton;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       medicineNameController.text = widget.VaktaData?.devoteeName ?? '';
//       packingController.text = widget.VaktaData?.sangha ?? '';
//       companyNameController.text = widget.VaktaData?.paaliDate ?? '';
//       genericNameController.text = widget.VaktaData?.pranaami ?? '';
//       cimsClassController.text = widget.VaktaData?.createdBy ?? '';
//       formController.text = widget.VaktaData?.createdOn ?? '';
//       contentsController.text = widget.VaktaData?.remark ?? '';
//       actClassificationController.text = widget.VaktaData?.sammilaniNo ?? '';
//       tabPerStripController.text = widget.VaktaData?.sammilaniYear ?? '';
//       priceController.text = widget.VaktaData?.updatedBy ?? '';
//       mfgDateController.text = widget.VaktaData?.updatedOn ?? '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Edit Medicine'),
//         automaticallyImplyLeading: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(30),
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
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               width: 350,
//                               child: TextFormField(
//                                 focusNode: FocusNode(
//                                   descendantsAreFocusable: false,
//                                 ),
//                                 controller: medicineNameController,
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Medicine Name',
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter Medicine name';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                             SizedBox(width: 40),
//                             DropdownButton(
//                               borderRadius: BorderRadius.circular(15),
//                               value: medicineTypeController.text,
//                               onChanged: (value) {
//                                 setState(() {
//                                   // _selectedMedicineType = value as String;
//                                   medicineTypeController.text = value as String;
//                                 });
//                               },
//                               items: medicineTypes.map(
//                                 (val) {
//                                   return DropdownMenuItem(
//                                     value: val,
//                                     child: Text(val),
//                                   );
//                                 },
//                               ).toList(),
//                               iconEnabledColor: Colors.blue,
//                               iconDisabledColor: Colors.blue,
//                               iconSize: 40,
//                               icon: Icon(Icons.arrow_drop_down_circle_rounded),
//                               underline: Text(''),
//                             )
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: companyNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Company Name',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter company name';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: genericNameController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Generic Name',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter batch name';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: tabPerStripController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Tab/Strip',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter tabs/strip name';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: cimsClassController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'CIMS Class',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter company name';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: actClassificationController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Act Classification',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter company name';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: formController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Form',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter company name';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: contentsController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Cotents',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter company name';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: packingController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Packing',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter company name';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: priceController,
//                           keyboardType: TextInputType.number,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'MRP',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter MRP of medicine';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: mfgDateController,
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
//                                       mfgDateController.text =
//                                           DateFormat('dd-MM-yyyy')
//                                               .format(selectedDate);
//                                     });
//                                   } else {
//                                     mfgDateController.text = '';
//                                   }
//                                 },
//                                 icon: Icon(Icons.calendar_month_rounded)),
//                             border: OutlineInputBorder(),
//                             labelText: 'Mfg Date',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please select Mfg date';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: expDateController,
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
//                                       expDateController.text =
//                                           DateFormat('dd-MM-yyyy')
//                                               .format(selectedDate);
//                                     });
//                                   } else {
//                                     expDateController.text = '';
//                                   }
//                                 },
//                                 icon: Icon(Icons.calendar_month_rounded)),
//                             border: OutlineInputBorder(),
//                             labelText: 'Exp Date',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please select Exp date';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         TextFormField(
//                           maxLines: 50 ~/ 8,
//                           focusNode: FocusNode(
//                             descendantsAreFocusable: false,
//                           ),
//                           controller: descriptionController,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: 'Descriptions',
//                           ),
//                           // validator: (value) {
//                           //   if (value == null || value.isEmpty) {
//                           //     return 'Please enter description';
//                           //   }
//                           //   return null;
//                           // },
//                         ),
//                         SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             Text('Upload Medicine Image'),
//                             IconButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             PickImageToUpload()));
//                               },
//                               icon: Icon(Icons.upload),
//                             )
//                           ],
//                         ),
//                         SizedBox(height: 40),
//                         ElevatedButton(
//                             onPressed: () async {
//                               if (_formKey.currentState!.validate()) {
//                                 VaktaModel medicineModel = VaktaModel(
//                                   devoteeName: medicineNameController.text,
//                                   // medicineType: _selectedMedicineType,
//                                   paaliDate: cimsClassController.text,
//                                   pranaami: actClassificationController.text,
//                                   sangha: formController.text,
//                                   createdBy: contentsController.text,
//                                   createdOn: packingController.text,
//                                   remark: descriptionController.text,
//                                   // sammilaniNo: DateTime.now(),
//                                   sammilaniNo: descriptionController.text,
//                                   sammilaniYear: genericNameController.text,
//                                   updatedBy: companyNameController.text,
//                                   // medicineImageURL: '',
//                                   updatedOn: companyNameController.text,
//                                 );

//                                 await MedicineAPI().editMedicine(medicineModel);

//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                         elevation: 6,
//                                         behavior: SnackBarBehavior.floating,
//                                         content: Text('Updated successfully')));
//                                 //Navigator.of(context).pop();
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Dashboard()));
//                               }
//                             },
//                             child: Text('Update')),
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
