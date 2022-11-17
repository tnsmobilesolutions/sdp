import 'package:flutter/material.dart';
import 'package:sdp/Models/vaktaModel.dart';

class TableHelper {
  TableRow getTableHeader() {
    return const TableRow(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Name',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Sangha',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Pranami',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Pali Date',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Sammilani No.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Sammilani Year',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Created By',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Created On',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Updated By',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Updated On',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Edit',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Delete',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }

  TableRow getTableRowData(VaktaModel item, VoidCallback editOnPressed,
      VoidCallback deleteOnPressed) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.name.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.sangha.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.pranaami.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.paaliDate.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.sammilaniNo.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.sammilaniYear.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.createdBy.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.createdOn.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.updatedBy.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(item.updatedOn.toString()),
      ),
      IconButton(onPressed: editOnPressed, icon: const Icon(Icons.edit)),
      IconButton(onPressed: deleteOnPressed, icon: const Icon(Icons.delete))
    ]);
  }
}
