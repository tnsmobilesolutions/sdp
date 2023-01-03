import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';

class multipleEditPali extends StatefulWidget {
  multipleEditPali({Key? key, required this.docIds}) : super(key: key);
  List<String> docIds;

  @override
  State<multipleEditPali> createState() => _multipleEditPaliState();
}

class _multipleEditPaliState extends State<multipleEditPali> {
  TextEditingController editPaliDatecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            //   // color: Colors.white,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      width: 250,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: editPaliDatecontroller,
                keyboardType: TextInputType.number,
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2050));
                  if (selectedDate != null) {
                    setState(() {
                      editPaliDatecontroller.text =
                          DateFormat('dd-MMM-yyyy').format(selectedDate);
                    });
                  } else {
                    editPaliDatecontroller.text = '';
                  }
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Change Pali Date',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final a = VaktaModel(
                  paaliDate: editPaliDatecontroller.text,
                );
                await PaliaAPI().editPaliDateMultiple(widget.docIds, a);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashboardPage(),
                    ));
              },
              child: const Text('Update'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
