import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/editPalia.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';

class PaliaTableData extends StatefulWidget {
  PaliaTableData(
      {Key? key,
      required this.paliaDetails,
      required this.slNo,
      required this.showMenu})
      : super(key: key);
  final VaktaModel paliaDetails;
  final int slNo;
  bool showMenu;

  @override
  State<PaliaTableData> createState() => _PaliaTableDataState();
}

class _PaliaTableDataState extends State<PaliaTableData> {
  bool isChecked = false;

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
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          }))),
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
                                    // dashboardindexNumber = 0;
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
      ),
    );
  }
}
