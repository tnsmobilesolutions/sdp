// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/Models/medicineModel.dart';

class DataTableView extends StatefulWidget {
  DataTableView({Key? key, this.allMeds, this.onRowTapped, this.isRowSelected})
      : super(key: key);
  List<VaktaModel>? allMeds;
  Function? onRowTapped;
  Function? isRowSelected;

  @override
  State<DataTableView> createState() => _DataTableViewState();
}

class _DataTableViewState extends State<DataTableView> {
  @override
  void initState() {
    super.initState();

    //print('allMeds from dataTable ${widget.allMeds}');
  }

  List<VaktaModel>? selectedMedList;
  int? sortColumnIndex;
  bool isAscending = false;
  String? medId;
  bool isSelected = false;
  late VaktaModel singleMed;
  final columns = [
    'Name',
    'Sangha',
    'Pranami',
    'Pali Date',
    'Sammikani No.',
    'Sammilani Date',
    'UserId',
    'Remark'
        'CreatedBy',
    'Created On',
    'Updated By',
    'Updated On',
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dividerThickness: 5,
      dataRowHeight: 60,
      showBottomBorder: true,
      headingRowHeight: 80,
      horizontalMargin: 20,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.blue,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(15),
        //Bord
      ),
      headingRowColor:
          MaterialStateProperty.resolveWith((states) => Colors.blue),
      showCheckboxColumn: true,
      onSelectAll: ((value) {}),
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(widget.allMeds),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map(
        (String column) => DataColumn(
          label: Text(
            column,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.5,
            ),
          ),
          // onSort: onSort,
        ),
      )
      .toList();

  List<DataRow> getRows(List<VaktaModel>? allMeds) {
    if (allMeds != null) {
      return allMeds.map((VaktaModel med) {
        //print('mfg date - ${med.mfgDate}');
        setState(() {
          singleMed = med;
        });
        final cells = [
          med.devoteeName,
          med.sangha,
          med.sammilaniNo,
          med.sammilaniYear,
          med.paaliDate,
          med.pranaami,
          med.createdBy,
          med.createdOn,
          med.updatedBy,
          med.updatedOn,
          med.userId,
          med..remark,
        ];

        return DataRow(
          cells: getCells(cells),
          selected: isSelected,
          onSelectChanged: (value) {
            setState(() {
              isSelected = !isSelected;
            });
            if (isSelected) {
              widget.onRowTapped!(med);
              widget.isRowSelected!(isSelected);
            } else {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     elevation: 6,
              //     behavior: SnackBarBehavior.floating,
              //     content: Text('Choose a medicine first')));
            }
            //print('tapped medicine - $med');
          },
        );
      }).toList();
    } else {
      return [];
    }
  }

  List<DataCell> getCells(List<dynamic> cells) => cells.map((data) {
        return DataCell(
          Text('$data'),
        );
      }).toList();

  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     widget.allMeds?.sort((user1, user2) => compareString(
  //         ascending, user1.medicineName ?? '', user2.medicineName ?? ''));
  //   } else if (columnIndex == 1) {
  //     widget.allMeds?.sort((user1, user2) =>
  //         compareString(ascending, user1.company ?? '', user2.company ?? ''));
  //   } else if (columnIndex == 2) {
  //     widget.allMeds?.sort((user1, user2) => compareString(
  //         ascending, user1.genericName ?? '', user2.genericName ?? ''));
  //   } else if (columnIndex == 3) {
  //     widget.allMeds?.sort((user1, user2) => compareString(
  //         ascending, user1.cimsClass ?? '', user2.cimsClass ?? ''));
  //   } else if (columnIndex == 4) {
  //     widget.allMeds?.sort((user1, user2) => compareString(ascending,
  //         user1.actClassification ?? '', user2.actClassification ?? ''));
  //   } else if (columnIndex == 5) {
  //     widget.allMeds?.sort((user1, user2) =>
  //         compareString(ascending, user1.packing ?? '', user2.packing ?? ''));
  //   } else if (columnIndex == 6) {
  //     widget.allMeds?.sort((user1, user2) =>
  //         compareString(ascending, user1.form ?? '', user2.form ?? ''));
  //   } else if (columnIndex == 7) {
  //     widget.allMeds?.sort((user1, user2) =>
  //         compareString(ascending, user1.contents ?? '', user2.contents ?? ''));
  //   } else if (columnIndex == 8) {
  //     widget.allMeds?.sort((user1, user2) => compareString(ascending,
  //         user1.tabsPerStrip.toString(), user2.tabsPerStrip.toString()));
  //   } else if (columnIndex == 9) {
  //     widget.allMeds?.sort((user1, user2) => compareString(
  //         ascending, user1.mfgDate.toString(), user2.mfgDate.toString()));
  //   } else if (columnIndex == 10) {
  //     widget.allMeds?.sort((user1, user2) => compareString(
  //         ascending, user1.expDate.toString(), user2.expDate.toString()));
  //   } else if (columnIndex == 11) {
  //     widget.allMeds?.sort((user1, user2) => compareString(
  //         ascending, user1.price.toString(), user2.price.toString()));
  //   } else if (columnIndex == 12) {
  //     widget.allMeds?.sort((user1, user2) => compareString(
  //         ascending, user1.description ?? '', user2.description ?? ''));
  //   }

  //   setState(() {
  //     sortColumnIndex = columnIndex;
  //     isAscending = ascending;
  //   });
  // }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
