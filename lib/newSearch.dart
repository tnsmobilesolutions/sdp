import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/paliaaAPI.dart';

class NewSearch extends StatefulWidget {
  const NewSearch({super.key, required this.onSubmitPress});
  final Function onSubmitPress;

  @override
  State<NewSearch> createState() => _NewSearchState();
}

class _NewSearchState extends State<NewSearch> {
  final searchPaliaNameController = TextEditingController();
  final searchpaliDateController = TextEditingController();
  final searchreceiptDateController = TextEditingController();
  final searchsanghaNameController = TextEditingController();
  final searchsammilaniPlaceController = TextEditingController();
  final searchpranamiController = TextEditingController();
  final searchsammilaniYearController = TextEditingController();
  final searchremarkController = TextEditingController();
  final searchsammilaniNumberController = TextEditingController();
  final searchreceiptNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: SingleChildScrollView(
        child: Scrollbar(
          child: Column(
            children: [
              //Palia Name
              TextFormField(
                controller: searchPaliaNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Palia Name',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: searchsanghaNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sangha Name',
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // PALI Date
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: searchpaliDateController,
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
                            searchpaliDateController.text =
                                DateFormat('dd-MMM-yyyy').format(selectedDate);
                          });
                        } else {
                          searchpaliDateController.text = '';
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded)),
                  border: const OutlineInputBorder(),
                  labelText: 'Pali Date (DD-MM-YYYY)',
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2050));
                  if (selectedDate != null) {
                    setState(() {
                      searchpaliDateController.text =
                          DateFormat('dd-MMM-yyyy').format(selectedDate);
                    });
                  } else {
                    searchpaliDateController.text = '';
                  }
                },
              ),
              SizedBox(height: 5),
              //  Sammilani Number
              TextFormField(
                controller: searchsammilaniNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sammilani Number',
                ),
              ),
              SizedBox(height: 5),
              //Sammilani Year
              TextFormField(
                controller: searchsammilaniYearController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sammilani Year',
                ),
              ),
              SizedBox(height: 5),
              //Sammilani Place
              TextFormField(
                controller: searchsammilaniPlaceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sammilani Place',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //Receipt Number
              TextFormField(
                controller: searchreceiptNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Receipt Number',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              // Receipt Date
              TextFormField(
                focusNode: FocusNode(
                  descendantsAreFocusable: false,
                ),
                controller: searchreceiptDateController,
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
                            searchreceiptDateController.text =
                                DateFormat('dd-MMM-yyyy').format(selectedDate);
                          });
                        } else {
                          searchreceiptDateController.text = '';
                        }
                      },
                      icon: const Icon(Icons.calendar_month_rounded)),
                  border: const OutlineInputBorder(),
                  labelText: 'Receipt Date (DD-MMM-YYYY)',
                ),
              ),
              const SizedBox(height: 10),
              CupertinoButton(
                  onPressed: () async {
                    final searchItem = await PaliaAPI().multipleSearchSDP(
                        searchPaliaNameController.text,
                        searchsanghaNameController.text,
                        searchpaliDateController.text,
                        searchsammilaniNumberController.text,
                        searchsammilaniYearController.text,
                        searchsammilaniPlaceController.text,
                        searchreceiptDateController.text,
                        searchreceiptNumberController.text);
                    print('...searchItem..................$searchItem');
                    Navigator.pop(context);
                    widget.onSubmitPress(searchItem);
                  },
                  child: Text('search'))
            ],
          ),
        ),
      ),
    );
  }
}
