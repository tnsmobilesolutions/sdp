import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/sammilani_list.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/dashboard/dummyDashBoard.dart';
import 'package:sdp/screen/dashboard/hardCodeListDashboard.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  final sammilaniDetails = SammilaniUtility.getAllSammilaniName();
  String? numberOfPalia;
  paliaLength() async {
    final a = await PaliaAPI().fetchAllByYearPalias('2022');
    setState(() {
      numberOfPalia = a.length.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    paliaLength();
  }

  @override
  Widget build(BuildContext context) {
    var list = SammilaniUtility.lastnSammilani(6);
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1.5),
      itemCount: 6,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: PaliaAPI()
              .fetchAllByYearPalias(list[index].sammilaniYear.toString()),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    highlightColor: Color.fromARGB(255, 0, 0, 0),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaliaListPage(
                                year: list[index].sammilaniYear.toString()),
                          ));
                    },
                    child: Card(
                      elevation: 10,
                      shadowColor: const Color(0XFF3f51b5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list[index].sammilaniNumber.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'ସମ୍ମିଳନୀ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  list[index].sammilaniYear.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              list[index].sammilaniPlace.toString(),
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.normal),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data.length.toString(),
                                  style: const TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  'ଦିନିକିଆ ପାଳି',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Expanded(child: DUmmyDashBoard());
            }
          },
        );
      },
    );
  }
}
