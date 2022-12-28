import 'package:flutter/material.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/dashboard/hardCodeListDashboard.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 1.6),
        itemCount: cardDetailsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: 400,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaliaListPage(),
                      ));
                },
                child: Card(
                  elevation: 50,
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
                              cardDetailsList[index].sammilaniNumb,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              cardDetailsList[index].sammilani,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.normal),
                            ),
                            Text(
                              cardDetailsList[index].sammilaniYear,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          cardDetailsList[index].sammilaniPlace,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.normal),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cardDetailsList[index].paliaNumber,
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              cardDetailsList[index].dinikiaPali,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.normal),
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
        },
      ),
    );
  }

  List<SammilaniList> cardDetailsList = [
    SammilaniList(
        sammilaniNumb: '71',
        sammilani: 'ସମ୍ମିଳନୀ',
        sammilaniYear: '2022',
        sammilaniPlace: 'Satsikhya Mandir, Bhubaneswar',
        paliaNumber: '2000',
        dinikiaPali: 'ଦିନିକିଆ ପାଳି'),
    SammilaniList(
        sammilaniNumb: '71',
        sammilani: 'ସମ୍ମିଳନୀ',
        sammilaniYear: '2022',
        sammilaniPlace: 'Satsikhya Mandir, Bhubaneswar',
        paliaNumber: '2000',
        dinikiaPali: 'ଦିନିକିଆ ପାଳି'),
    SammilaniList(
        sammilaniNumb: '71',
        sammilani: 'ସମ୍ମିଳନୀ',
        sammilaniYear: '2022',
        sammilaniPlace: 'Satsikhya Mandir, Bhubaneswar',
        paliaNumber: '2000',
        dinikiaPali: 'ଦିନିକିଆ ପାଳି'),
    SammilaniList(
        sammilaniNumb: '71',
        sammilani: 'ସମ୍ମିଳନୀ',
        sammilaniYear: '2022',
        sammilaniPlace: 'Satsikhya Mandir, Bhubaneswar',
        paliaNumber: '2000',
        dinikiaPali: 'ଦିନିକିଆ ପାଳି'),
    SammilaniList(
        sammilaniNumb: '71',
        sammilani: 'ସମ୍ମିଳନୀ',
        sammilaniYear: '2022',
        sammilaniPlace: 'Satsikhya Mandir, Bhubaneswar',
        paliaNumber: '2000',
        dinikiaPali: 'ଦିନିକିଆ ପାଳି'),
    SammilaniList(
        sammilaniNumb: '71',
        sammilani: 'ସମ୍ମିଳନୀ',
        sammilaniYear: '2022',
        sammilaniPlace: 'Satsikhya Mandir, Bhubaneswar',
        paliaNumber: '2000',
        dinikiaPali: 'ଦିନିକିଆ ପାଳି'),
  ];
}
