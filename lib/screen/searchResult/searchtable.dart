import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/editPalia.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';
import 'package:sdp/screen/searchResult/searchResultScreen.dart';

class SearchTableData extends StatelessWidget {
  SearchTableData(
      {Key? key,
      required this.searchpaliaDetails,
      required this.slNo,
      required this.showMenu})
      : super(key: key);
  final VaktaModel searchpaliaDetails;
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
                  (slNo + 1).toString(),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${searchpaliaDetails.name}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${searchpaliaDetails.sangha}',
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Text(
                  '${searchpaliaDetails.paaliDate}',
                  textAlign: TextAlign.center,
                ),
              ),
              if (showMenu == true)
                Expanded(
                    child: IconButton(
                        color: Color(0XFF3f51b5),
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('View Palia Details'),
                              content: ViewPalia(item: searchpaliaDetails),
                            ),
                          );
                        },
                        icon: Icon(Icons.visibility))),
              if (showMenu == true)
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
                                    paliaDetails: searchpaliaDetails),
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.edit))),
              if (showMenu == true)
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
                                        .removePalia(searchpaliaDetails.docId);
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return PaliaListPage();
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
