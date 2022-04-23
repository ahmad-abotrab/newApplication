import 'dart:io';

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '/helpers/utils.dart';
import '/models/Human/Customer.dart';

import '/models/Operations/Sell.dart';
import '/models/Operations/SellUp.dart';

import 'PdfApi.dart';

class PdfBilleApi {
  static Future<File> generate(Sell bill, left) async {
    final pdf = Document();
    pdf.addPage(
      MultiPage(
          build: (context) => [
                buildHeader(bill, left),
                SizedBox(height: 1 * PdfPageFormat.cm),
                buildTitle(bill),
                buildBill(bill),
                Divider(),
                SizedBox(height: 1 * PdfPageFormat.cm),
                buildTotal(bill),
              ],
          footer: (context) => buildFooter(bill)),
    );
    return PdfApi.saveDocument(name: 'bill.pdf', pdf: pdf);
  }

  static buildHeader(Sell bill, left) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1 * PdfPageFormat.cm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildSupplierAddress(bill.customer),
            Container(
                width: 50,
                height: 50,
                child: BarcodeWidget(
                  data: '8787978',
                  barcode: Barcode.qrCode(),
                )),
          ],
        ),
        SizedBox(height: 1 * PdfPageFormat.cm),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: left),
          child: buildBillInfo(bill),
        ),
      ],
    );
  }

  static buildBillInfo(Sell bill) {
    final titles = <String>[
      'Bill Number',
      'Bill Date',
      // 'Payment Terms',
      // 'Due Date'
    ];
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    final date = <String>[
      bill.id,
      dateFormat.format(bill.date == null ? DateTime(1900) : bill.date),
    ];
    return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(titles.length, (index) {
          final title = titles[index];
          final value = date[index];
          return Row(children: [
            Text(title + ' : ', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(width: 2 * PdfPageFormat.mm),
            Text(
              value,
            ),
          ]);
        }));
  }

  static buildSupplierAddress(Customer customer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          customer.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 1 * PdfPageFormat.mm),
        Text(customer.address),
      ],
    );
  }

  static buildFooter(Sell bill) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: 'BabToma')
        ],
      );

  static buildSimpleText({
    String title,
    String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);
    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style: style),
          SizedBox(width: 2 * PdfPageFormat.mm),
          Text(value),
        ]);
  }

  static buildTitle(Sell bill) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Bill',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        Text(bill.notes.toString()),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
      ]);

  static buildTotal(Sell bill) {
    double netTotal = 0;
    for (SellUp sellUp in bill.productsSell) {
      netTotal += sellUp.quantity * sellUp.unitPrice * 1.0;
    }

    return Container(
      alignment: Alignment.centerRight,
      child: Row(children: [
        Spacer(flex: 5),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              buildText(
                title: 'Total',
                titleStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
                value: netTotal.toString(),
                unit: true,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  static buildText({
    String title,
    String value,
    double width = double.infinity,
    TextStyle titleStyle,
    bool unit = false,
  }) {
    final style = titleStyle == null
        ? TextStyle(
            fontWeight: FontWeight.bold,
          )
        : titleStyle;

    return Container(
      width: width,
      child: Row(children: [
        Expanded(child: Text(title, style: style)),
        Text(value, style: unit ? style : null),
      ]),
    );
  }

  static buildBill(Sell bill) {
    final headers = [
      'Name',
      'Date',
      'Quantity',
      'Unit Price',
      'Total',
    ];
    final data = bill.productsSell.map((item) {
      final total = item.unitPrice * item.quantity;
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      return [
        item.nameProduct,
        dateFormat.format(bill.date),
        '\$ ${item.quantity}',
        '\$ ${item.unitPrice}',
        '\$ $total',
      ];
    }).toList();
    return Table.fromTextArray(
        headers: headers,
        data: data,
        border: null,
        headerStyle: TextStyle(fontWeight: FontWeight.bold),
        headerDecoration: BoxDecoration(color: PdfColors.grey300),
        cellHeight: 30,
        cellAlignments: {
          0: Alignment.centerLeft,
          1: Alignment.centerRight,
          2: Alignment.centerRight,
          3: Alignment.centerRight,
          4: Alignment.centerRight,
          5: Alignment.centerRight,
        });
  }
}
