import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sdp/Models/vaktaModel.dart';

class TableHelper {
  TableRow getTableHeader(bool showButtons) {
    return TableRow(children: <Widget>[
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Sl No.',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Name',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Sangha',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Pali Date',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          'Pranami',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      // Padding(
      //   padding: EdgeInsets.all(10.0),
      //   child: Text(
      //     'Sammilani No.',
      //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(10.0),
      //   child: Text(
      //     'Sammilani Year',
      //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(10.0),
      //   child: Text(
      //     'Created By',
      //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(10.0),
      //   child: Text(
      //     'Created On',
      //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(10.0),
      //   child: Text(
      //     'Updated By',
      //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(10.0),
      //   child: Text(
      //     'Updated On',
      //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      //   ),
      // ),
      if (showButtons == true)
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            textAlign: TextAlign.center,
            'View',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      if (showButtons == true)
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            textAlign: TextAlign.center,
            'Edit',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      if (showButtons == true)
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            textAlign: TextAlign.center,
            'Delete',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
    ]);
  }

  TableRow getTableRowData(
      VaktaModel item,
      int i,
      VoidCallback onViewPressed,
      VoidCallback editOnPressed,
      VoidCallback deleteOnPressed,
      bool showButtons) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(i.toString()),
      ),
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
        child: Text(item.paaliDate.toString()),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '₹${item.pranaami}',
        ),
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(item.sammilaniNo.toString()),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(item.sammilaniYear.toString()),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(item.createdBy.toString()),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(item.createdOn.toString()),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(item.updatedBy.toString()),
      // ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Text(item.updatedOn.toString()),
      // ),
      if (showButtons == true)
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              alignment: Alignment.center,
              onPressed: onViewPressed,
              icon: const Icon(
                Icons.visibility,
                color: Color(0XFF3f51b5),
              )),
        ),
      if (showButtons == true)
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              alignment: Alignment.center,
              onPressed: editOnPressed,
              icon: const Icon(
                Icons.edit,
                color: Color(0XFF3f51b5),
              )),
        ),
      if (showButtons == true)
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
              alignment: Alignment.center,
              onPressed: deleteOnPressed,
              icon: const Icon(
                Icons.delete,
                color: Color(0XFF3f51b5),
              )),
        )
    ]);
  }
}
