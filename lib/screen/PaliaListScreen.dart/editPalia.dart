import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Models/sammilaniModel.dart';
import 'package:sdp/Models/userDetailsModel.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/unUsedCodes/homeScreen.dart';

class EditPaliadilougePage extends StatefulWidget {
  EditPaliadilougePage({Key? key, required this.paliaDetails})
      : super(key: key);
  VaktaModel paliaDetails;

  @override
  State<EditPaliadilougePage> createState() => _EditPaliadilougePageState();
}

class _EditPaliadilougePageState extends State<EditPaliadilougePage> {
  final _formKey = GlobalKey<FormState>();
  final paliaNameController = TextEditingController();
  final paliDateController = TextEditingController();
  final receiptDateController = TextEditingController();
  final sanghaNameController = TextEditingController();
  final sammilaniPlaceController = TextEditingController();
  final pranamiController = TextEditingController();
  final sammilaniYearController = TextEditingController();
  final remarkController = TextEditingController();
  final sammilaniNumberController = TextEditingController();
  final receiptNumberController = TextEditingController();
  UserDetailsModel? currentPalia;
  String formattedDate =
      DateFormat('dd-MMM-yyyy  hh:mm a').format(DateTime.now());

  currentUser() async {
    final currentUser = await UserAPI().getCurrentUserData();
    setState(() {
      currentPalia = currentUser;
    });
  }

  @override
  void initState() {
    currentUser();
    super.initState();
    paliaNameController.text = widget.paliaDetails.name ?? '';
    sanghaNameController.text = widget.paliaDetails.sangha ?? '';
    paliDateController.text = widget.paliaDetails.paaliDate ?? '';
    receiptDateController.text = widget.paliaDetails.receiptDate ?? '';
    sammilaniPlaceController.text =
        widget.paliaDetails.sammilaniData?.sammilaniPlace ?? '';
    sammilaniNumberController.text =
        widget.paliaDetails.sammilaniData?.sammilaniNumber ?? '';
    sammilaniYearController.text =
        widget.paliaDetails.sammilaniData?.sammilaniYear ?? '';
    pranamiController.text = widget.paliaDetails.pranaami.toString();
    remarkController.text = widget.paliaDetails.remark ?? '';
    receiptNumberController.text = widget.paliaDetails.receiptNo ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: Colors.white,
      ),
      height: 435,
      width: 400,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Palia Name
              TextFormField(
                controller: paliaNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Name';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 5),
              //Sangha Name
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
                  }

                  return null;
                },
              ),
              const SizedBox(height: 5),
              // Pranami
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
              ),
              // Pali Date
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
                                DateFormat('dd-MMM-yyyy').format(selectedDate);
                          });
                        } else {
                          paliDateController.text = '';
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded)),
                  border: const OutlineInputBorder(),
                  labelText: 'Pali Date (DD-MMM-YYYY)',
                ),
              ),
              const SizedBox(height: 5),
              // C
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: receiptDateController,
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
                            receiptDateController.text =
                                DateFormat('dd-MMM-yyyy').format(selectedDate);
                          });
                        } else {
                          receiptDateController.text = '';
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded)),
                  border: const OutlineInputBorder(),
                  labelText: 'Receipt Date (DD-MMM-YYYY)',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // receipt Number
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: receiptNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Receipt Number',
                ),
              ),
              const SizedBox(height: 5),
              // Sammilani Number
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
              // Sammilani Year
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
              // Sammilani Place
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: sammilaniPlaceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'sammilani Place',
                ),
              ),

              const SizedBox(height: 5),
              // Remark
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
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0XFF3f51b5)),
                  ),
                  child: const Text('Edit Palia'),
                  onPressed: () async {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Edit Palia Details'),
                        content:
                            const Text('Do You Want to Update Palia Details'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              VaktaModel editUser = VaktaModel(
                                  name: paliaNameController.text.trim(),
                                  updatedBy: currentPalia?.name,
                                  updatedOn: formattedDate.toString(),
                                  pranaami: double.parse(
                                      pranamiController.text.trim() == ''
                                          ? '0.0'
                                          : pranamiController.text.trim()),
                                  remark: remarkController.text.trim(),
                                  sammilaniData: SammilaniModel(
                                    sammilaniNumber:
                                        sammilaniNumberController.text.trim(),
                                    sammilaniYear:
                                        sammilaniYearController.text.trim(),
                                    sammilaniPlace:
                                        sammilaniPlaceController.text.trim(),
                                  ),
                                  sangha: sanghaNameController.text.trim(),
                                  paaliDate: paliDateController.text,
                                  receiptDate: receiptDateController.text,
                                  receiptNo: receiptNumberController.text,
                                  docId: widget.paliaDetails.docId
                                  //
                                  );
                              PaliaAPI().editPaliaDetails(editUser);
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const PaliaListPage();
                                },
                              ));
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}