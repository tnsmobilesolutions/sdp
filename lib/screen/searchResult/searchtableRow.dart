import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/editPalia.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';

class searchTableRow extends StatefulWidget {
  searchTableRow({
    Key? key,
    required this.searchpaliaDetails,
    required this.slNo,
    required this.showMenu,
    required this.isCheckedBoolValue,
    this.allCheck,
  }) : super(key: key);
  final VaktaModel searchpaliaDetails;
  final int slNo;
  bool showMenu;
  Function isCheckedBoolValue;
  bool? allCheck;

  @override
  State<searchTableRow> createState() => _searchTableRowState();
}

class _searchTableRowState extends State<searchTableRow> {
  bool isCheck = false;
  @override
  @override
  void initState() {
    if (widget.allCheck == false) {
      widget.allCheck = null;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Center(
                      child: Checkbox(
                          value: widget.allCheck ?? isCheck,
                          onChanged: (value) {
                            setState(() {
                              isCheck = value!;
                              print('***Value****$value');
                              widget.isCheckedBoolValue(value);
                              // widget.isallCheckedBoolValue(value);
                            });

                            // print('*************$selectedPalia**************');
                          }))),
              Expanded(
                child: Text(
                  (widget.slNo).toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${widget.searchpaliaDetails.name}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${widget.searchpaliaDetails.sangha}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${widget.searchpaliaDetails.paaliDate}',
                  textAlign: TextAlign.center,
                ),
              ),
              if (widget.showMenu == true)
                Expanded(
                    child: IconButton(
                        color: Color(0XFF3f51b5),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('View Palia Details'),
                              content:
                                  ViewPalia(item: widget.searchpaliaDetails),
                            ),
                          );
                        },
                        icon: Icon(Icons.visibility))),
              if (widget.showMenu == true)
                Expanded(
                    child: IconButton(
                        color: Color(0XFF3f51b5),
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Edit Palia Details'),
                                content: EditPaliadilougePage(
                                    paliaDetails: widget.searchpaliaDetails),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit))),
              if (widget.showMenu == true)
                Expanded(
                    child: IconButton(
                        color: Color(0XFF3f51b5),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Delete User'),
                              content: const Text(
                                  'Do You Want to delete the user permanently?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // dashboardindexNumber = 0;
                                    PaliaAPI().removePalia(
                                        widget.searchpaliaDetails.docId);
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return PaliaListPage(
                                          year:
                                              '${widget.searchpaliaDetails.sammilaniData?.sammilaniYear}',
                                        );
                                      },
                                    ));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.delete,
                        ))),
            ],
          ),
          const Divider(
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
