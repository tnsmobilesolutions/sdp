// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/Models/vaktaModel.dart';

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
  late VaktaModel singledevotee;
  final columns = [
    'Name',
    'Sangha',
    'Pranami',
    'Pali Date',
    'Sammilani No.',
    'Sammilani Year',
    'UserId',
    'Remark',
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
      rows: getRows(
        widget.allMeds,
      ),
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

  List<DataRow> getRows(List<VaktaModel>? alldevotee) {
    if (alldevotee != null) {
      return alldevotee.map((VaktaModel devoteedtails) {
        //print('mfg date - ${med.mfgDate}');
        setState(() {
          singledevotee = devoteedtails;
        });
        final cells = [
          devoteedtails.name,
          devoteedtails.sangha,
          devoteedtails.pranaami,
          devoteedtails.paaliDate,
          devoteedtails.sammilaniNo,
          devoteedtails.sammilaniYear,
          devoteedtails.docId,
          devoteedtails.remark,
          devoteedtails.createdBy,
          devoteedtails.createdOn,
          devoteedtails.updatedBy,
          devoteedtails.updatedOn,
        ];

        return DataRow(
          cells: getCells(cells),
          selected: isSelected,
          onSelectChanged: (value) {
            setState(() {
              isSelected = !isSelected;
            });
            if (isSelected) {
              widget.onRowTapped!(devoteedtails);
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

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      widget.allMeds?.sort((user1, user2) =>
          compareString(ascending, user1.name ?? '', user2.name ?? ''));
    } else if (columnIndex == 1) {
      widget.allMeds?.sort((user1, user2) =>
          compareString(ascending, user1.sangha ?? '', user2.sangha ?? ''));
    } else if (columnIndex == 2) {
      widget.allMeds?.sort((user1, user2) =>
          compareString(ascending, user1.pranaami ?? '', user2.pranaami ?? ''));
    } else if (columnIndex == 3) {
      widget.allMeds?.sort((user1, user2) => compareString(
          ascending, user1.paaliDate ?? '', user2.paaliDate ?? ''));
    } else if (columnIndex == 4) {
      widget.allMeds?.sort((user1, user2) => compareString(
          ascending, user1.sammilaniNo ?? '', user2.sammilaniNo ?? ''));
    } else if (columnIndex == 5) {
      widget.allMeds?.sort((user1, user2) => compareString(
          ascending, user1.sammilaniYear ?? '', user2.sammilaniYear ?? ''));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
