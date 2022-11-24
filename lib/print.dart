import 'package:flutter/material.dart';
import 'package:sdp/Models/vaktaModel.dart';

import 'package:pdf/widgets.dart' as pw;

class PrintTableHelper {
  pw.TableRow getPrintTableHeader() {
    return pw.TableRow(children: [
      pw.Padding(
        padding: pw.EdgeInsets.all(10.0),
        child: pw.Text(
          'Sl No.',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(10.0),
        child: pw.Text(
          'Name',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(10.0),
        child: pw.Text(
          'Sangha',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(10.0),
        child: pw.Text(
          'Pali Date',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
        ),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(10.0),
        child: pw.Text(
          'Pranami',
          style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold),
        ),
      ),
    ]);
  }

  pw.TableRow getPrintTableRowData(VaktaModel item) {
    return pw.TableRow(decoration: pw.BoxDecoration(), children: [
      pw.Padding(
        padding: pw.EdgeInsets.all(8.0),
        child: pw.Text('1'),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(8.0),
        child: pw.Text(item.name.toString()),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(8.0),
        child: pw.Text(item.sangha.toString()),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(8.0),
        child: pw.Text(item.paaliDate.toString()),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.all(8.0),
        child: pw.Text('₹${item.pranaami}'),
      ),
    ]);
  }
}
