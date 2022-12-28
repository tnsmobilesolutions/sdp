import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/editPalia.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';

class PaliaTableData extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Center(
                      child: Checkbox(value: false, onChanged: (value) {}))),
              Expanded(
                child: Text(
                  (slNo).toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${paliaDetails.name}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${paliaDetails.sangha}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${paliaDetails.paaliDate}',
                  textAlign: TextAlign.center,
                ),
              ),
              if (showMenu == true)
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('View Palia Details'),
                              content: ViewPalia(item: paliaDetails),
                            ),
                          );
                        },
                        icon: Icon(Icons.visibility))),
              if (showMenu == true)
                Expanded(
                    child: IconButton(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Edit Palia Details'),
                                content: EditPaliadilougePage(
                                    paliaDetails: paliaDetails),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit))),
              if (showMenu == true)
                Expanded(
                    child: IconButton(
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
                                    PaliaAPI().removePalia(paliaDetails.docId);
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return const PaliaListPage();
                                      },
                                    ));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(Icons.delete))),
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
