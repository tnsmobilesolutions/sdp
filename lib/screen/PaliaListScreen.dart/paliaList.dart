import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaScreenBody.dart';

class PaliaListPage extends StatefulWidget {
  PaliaListPage({Key? key, required this.year}) : super(key: key);
  String year;

  @override
  State<PaliaListPage> createState() => _PaliaListPageState();
}

class _PaliaListPageState extends State<PaliaListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingImage(),
        automaticallyImplyLeading: false,
        title: const Text(
          'ସମ୍ମିଳନୀ ଦିନିକିଆ ପାଳି',
        ),
        actions: const [ActionWidget()],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: PaliaListBodyPage(
            year: widget.year,
          ))
        ],
      )),
    );
  }
}
