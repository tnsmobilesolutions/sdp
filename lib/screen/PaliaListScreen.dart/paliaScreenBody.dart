import 'package:flutter/material.dart';
import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/Models/vaktaModel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaTableData.dart';

class PaliaListBodyPage extends StatefulWidget {
  const PaliaListBodyPage({super.key});

  @override
  State<PaliaListBodyPage> createState() => _PaliaListBodyPageState();
}

class _PaliaListBodyPageState extends State<PaliaListBodyPage> {
  bool showMenu = false;
  Expanded headingText(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      showMenu = !showMenu;
                    });
                  },
                  icon: const Icon(Icons.menu_open)),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.print)),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: Center(
                        child: Checkbox(value: false, onChanged: (value) {}))),
                headingText('କ୍ରମିକ ନଂ'),
                headingText('ପାଳିଆ ନାମ'),
                headingText('ସଂଘ'),
                headingText('ପାଳି ତାରିଖ'),
                if (showMenu == true) headingText('View'),
                if (showMenu == true) headingText('Edit'),
                if (showMenu == true) headingText('Delete'),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          FutureBuilder(
            future: PaliaAPI().fetchAllPalias(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return const Text('SNAPSHOT ERROR');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      //Table firebase Data
                      return PaliaTableData(
                        showMenu: showMenu,
                        slNo: index + 1,
                        paliaDetails: snapshot.data[index],
                      );
                    },
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
