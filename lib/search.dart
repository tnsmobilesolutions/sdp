import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/devoteeAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';

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
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            // color: Colors.white,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)),
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              onFieldSubmitted: (value) async {
                final result = await PaliaAPI()
                    .searchSDP(_selectedSearchType, sdpSearchController.text);
                widget.onSubmitPress(
                    result, _selectedSearchType, sdpSearchController.text);
              },

              autofocus: false,
              controller: sdpSearchController,
              // keyboardType: TextInputType.datetime,
              // },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0XFF3f51b5),
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  border: InputBorder.none,
                  hintText: 'Search item',
                  hintStyle: const TextStyle(
                    color: Color(0XFF3f51b5),
                  ),
                  suffixIcon: _selectedSearchType == 'Pali Date'
                      ? IconButton(
                          onPressed: () async {
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
                              DateFormat('dd/MM/yyyy').format(selectedDate);
                        });
                      } else {
                        sdpSearchController.text = '';
                      }
                    }
                  : () {},
            ),
          ),
          const VerticalDivider(
            color: Color(0XFF3f51b5),
            thickness: 0.5,
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
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ElevatedButton(
              onPressed: () async {
                widget.searchDasboardIndexNumber = 0;
                widget.dashboardindexNumber = 0;
                final result = await PaliaAPI()
                    .searchSDP(_selectedSearchType, sdpSearchController.text);
                widget.onSubmitPress(
                    result, _selectedSearchType, sdpSearchController.text);
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
