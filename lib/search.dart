import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/sanghalist.dart';

class SearchSDP extends StatefulWidget {
  SearchSDP(
      {Key? key,
      required this.onSubmitPress,
      this.dashboardindexNumber,
      this.searchDasboardIndexNumber})
      : super(key: key);
  int? searchDasboardIndexNumber = 0;
  int? dashboardindexNumber = 0;
  final Function onSubmitPress;

  @override
  State<SearchSDP> createState() => _SearchSDPState();
}

class _SearchSDPState extends State<SearchSDP> {
  List<String?> searchSangha = [];
  bool sshowAllNames = false;
  TextEditingController searchSanghaController = TextEditingController();
  List<String> searchBy = [
    'Name',
    'Sangha',
    'Pali Date',
    'Sammilani Number',
    'Sammilani Year',
    'Sammilani Place',
    'Receipt Date',
    'Receipt Number',
  ];
  final TextEditingController sdpSearchController = TextEditingController();
  String _selectedSearchType = 'Name';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0XFF3f51b5),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        DropdownButton(
                          style: const TextStyle(
                              color: Color(0XFF3f51b5), //Font color
                              fontSize: 16 //font size on dropdown button
                              ),
                          // focusColor: Colors.white,
                          hint: const Text('Search By'),

                          borderRadius: BorderRadius.circular(20),
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
                            color: Color(0XFF3f51b5),
                          ),
                          underline: const Text(''),
                        ),
                      ],
                    ),
                  ),
                  // const VerticalDivider(
                  //   color: Color(0XFF3f51b5),
                  //   thickness: 0.5,
                  // ),
                  Expanded(
                    child: TextFormField(
                      onFieldSubmitted: (value) async {
                        final result = await PaliaAPI().searchSDP(
                            _selectedSearchType,
                            sdpSearchController.text,
                            searchSanghaController.text);
                        widget.onSubmitPress(result, _selectedSearchType,
                            sdpSearchController.text);
                      },

                      autofocus: false,
                      controller: sdpSearchController,
                      // keyboardType: TextInputType.datetime,
                      // },

                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          contentPadding: const EdgeInsets.all(15),
                          // border: InputBorder.none,
                          hintText: 'Search item',
                          hintStyle: const TextStyle(
                            color: Color(0XFF3f51b5),
                          ),
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
                                            DateFormat('dd/MM/yyyy')
                                                .format(selectedDate);
                                      });
                                    } else {
                                      sdpSearchController.text = '';
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                    color: Color(0XFF3f51b5),
                                  ))
                              : null),
                      onTap: _selectedSearchType == 'Pali Date'
                          ? () async {
                              DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2022),
                                  lastDate: DateTime(2050));
                              if (selectedDate != null) {
                                setState(() {
                                  sdpSearchController.text =
                                      DateFormat('dd/MM/yyyy')
                                          .format(selectedDate);
                                });
                              } else {
                                sdpSearchController.text = '';
                              }
                            }
                          : () {},
                    ),
                  ),
                ],
              ),
              if (_selectedSearchType == 'Sammilani Number')
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (value) {
                          final sanghaaList = SanghaUtility.getAllSanghaName();
                          if (sanghaaList.any((element) => value
                              .toLowerCase()
                              .contains((element?.toLowerCase()).toString()))) {
                            print(sanghaaList);
                            print('true');

                            searchSangha.add(value);
                          }
                          print(sanghaaList);

                          setState(() {
                            sshowAllNames = true;
                          });
                        },
                        controller: searchSanghaController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            labelText: 'Please enter Sangha Name'),
                      ),
                    ),
                  ),
                ),
              if (sshowAllNames == true)
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                      itemCount: searchSangha.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: InkWell(
                            onTap: () {
                              setState(() {
                                searchSanghaController.text =
                                    (searchSangha[index]?.toLowerCase())
                                        .toString();
                              });
                            },
                            child:
                                //  Text(
                                //   (searchSangha[index]).toString(),
                                // ),
                                Text(
                              SanghaUtility.getAllSanghaName()[index]
                                  .toString(),
                            ),
                          ),
                        );
                      }),
                )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ElevatedButton(
              onPressed: () async {
                widget.searchDasboardIndexNumber = 0;
                widget.dashboardindexNumber = 0;
                final result = await PaliaAPI().searchSDP(_selectedSearchType,
                    sdpSearchController.text, searchSanghaController.text);
                widget.onSubmitPress(
                    result, _selectedSearchType, sdpSearchController.text);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // setState(() {
                //   widget.searchItem = result;
                // });
              },
              child: const Text('Search'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
