import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/editPalia.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';

class PaliaTableRow extends StatefulWidget {
  PaliaTableRow({
    Key? key,
    required this.paliaDetails,
    required this.slNo,
    required this.showMenu,
    required this.isCheckedBoolValue,
    this.allCheck,
  }) : super(key: key);
  final VaktaModel paliaDetails;
  final int slNo;
  Function isCheckedBoolValue;
  // Function isallCheckedBoolValue;
  bool showMenu;
  bool? allCheck;

  @override
  State<PaliaTableRow> createState() => _PaliaTableRowState();
}

class _PaliaTableRowState extends State<PaliaTableRow> {
  // List<String> selectedPalia = [];
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
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
                },
              ),
            ),
            Expanded(
              child: Text(
                (widget.slNo).toString(),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${widget.paliaDetails.name}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${widget.paliaDetails.sangha}',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '${widget.paliaDetails.paaliDate}',
                textAlign: TextAlign.center,
              ),
            ),
            if (widget.showMenu == true)
              Expanded(
                  child: IconButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('View Palia Details'),
                            content: ViewPalia(item: widget.paliaDetails),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.visibility,
                        color: Color(0XFF3f51b5),
                      ))),
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
                                  paliaDetails: widget.paliaDetails),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                      ))),
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
                                  PaliaAPI()
                                      .removePalia(widget.paliaDetails.docId);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return PaliaListPage(
                                        year:
                                            '${widget.paliaDetails.sammilaniData?.sammilaniYear}',
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
    );
  }
}
