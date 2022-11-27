import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Add_Edit_Dialougebox extends StatefulWidget {
  Add_Edit_Dialougebox(
      {Key? key,
      this.devoteeNameController,
      this.formKey,
      this.paliDateController,
      this.pranamiController,
      this.remarkController,
      this.sammilaniNumberController,
      this.sammilaniYearController,
      this.sanghaNameController})
      : super(key: key);
  GlobalKey<FormState>? formKey;
  TextEditingController? devoteeNameController;
  TextEditingController? paliDateController;
  TextEditingController? sanghaNameController;

  TextEditingController? pranamiController;
  TextEditingController? sammilaniYearController;
  TextEditingController? remarkController;
  TextEditingController? sammilaniNumberController;

  @override
  State<Add_Edit_Dialougebox> createState() => _Add_Edit_DialougeboxState();
}

class _Add_Edit_DialougeboxState extends State<Add_Edit_Dialougebox> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Devotee Name
            TextFormField(
              controller: widget.devoteeNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Name';
                } else if (!RegExp(r'^[a-zA-Z0-9]+(?:[\w -]*[a-zA-Z0-9]+)*$')
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
              controller: widget.sanghaNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Sangha Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Sangha Name';
                } else if (!RegExp(r'^[a-zA-Z0-9]+(?:[\w -]*[a-zA-Z0-9]+)*$')
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
              controller: widget.pranamiController,
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
              controller: widget.paliDateController,
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
                          widget.paliDateController?.text =
                              DateFormat('dd/MM/yyyy').format(selectedDate);
                        });
                      } else {
                        widget.paliDateController?.text = '';
                      }
                    },
                    icon: const Icon(Icons.calendar_month_rounded)),
                border: const OutlineInputBorder(),
                labelText: 'Pali Date (DD/MM/YYYY)',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              focusNode: FocusNode(
                descendantsAreFocusable: false,
              ),
              controller: widget.sammilaniNumberController,
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
              controller: widget.sammilaniYearController,
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
              controller: widget.remarkController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Remark',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
