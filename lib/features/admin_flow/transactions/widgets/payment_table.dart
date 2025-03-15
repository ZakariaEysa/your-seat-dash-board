import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentTable extends StatefulWidget {
  @override
  _PaymentTableState createState() => _PaymentTableState();
}

class _PaymentTableState extends State<PaymentTable> {
  String? selectedStatus;

  final List<Map<String, String>> transactions = [
    {'id': '#CXR001', 'date': 'Just now', 'status': 'Complete'},
    {'id': '#CXR002', 'date': 'A minute ago', 'status': 'Complete'},
    {'id': '#CXR003', 'date': '1 hour ago', 'status': 'Refund'},
    {'id': '#CXR004', 'date': 'Yesterday', 'status': 'Refund'},
    {'id': '#CXR005', 'date': 'Feb 2, 2025', 'status': 'Rejected'},
    {'id': '#CXR001', 'date': 'Just now', 'status': 'Complete'},
    {'id': '#CXR002', 'date': 'A minute ago', 'status': 'Complete'},
    {'id': '#CXR003', 'date': '1 hour ago', 'status': 'Refund'},
    {'id': '#CXR004', 'date': 'Yesterday', 'status': 'Refund'},
    {'id': '#CXR005', 'date': 'Feb 2, 2025', 'status': 'Rejected'},
    {'id': '#CXR001', 'date': 'Just now', 'status': 'Complete'},
    {'id': '#CXR002', 'date': 'A minute ago', 'status': 'Complete'},
    {'id': '#CXR003', 'date': '1 hour ago', 'status': 'Refund'},
    {'id': '#CXR004', 'date': 'Yesterday', 'status': 'Refund'},
  ];

  final List<String> paymentStatuses = ['Complete', 'Refund', 'Rejected', 'Suspended'];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredTransactions = selectedStatus == null
        ? transactions
        : transactions.where((t) => t['status'] == selectedStatus).toList();

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Filter', style: TextStyle(color: Colors.black)),
                  SizedBox(width: 5),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.filter_list, color: Colors.black),
                    onSelected: (value) {
                      setState(() {
                        selectedStatus = value == 'All' ? null : value;
                      });
                    },
                    itemBuilder: (context) => <PopupMenuEntry<String>>[
                      PopupMenuItem(value: 'All', child: Text('All')),
                      ...paymentStatuses.map((status) => PopupMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (filteredTransactions.isEmpty)
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.sp),
              child: Center(
                child: Text(
                  'No transactions found',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          else
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Transaction ID')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Payment Status')),
                ],
                rows: filteredTransactions.map((transaction) {
                  Color statusColor;
                  switch (transaction['status']) {
                    case 'Complete':
                      statusColor = Color(0xFF4AA785);
                      break;
                    case 'Refund':
                      statusColor = Color(0xFFFFC555);
                      break;
                    case 'Rejected':
                      statusColor = Colors.grey;
                      break;
                    case 'Suspended':
                      statusColor = Colors.indigo;
                      break;
                    default:
                      statusColor = Colors.black;
                  }
                  return DataRow(cells: [
                    DataCell(Text(
                      transaction['id']!,
                      style: TextStyle(color: Colors.black),
                    )),
                    DataCell(Row(
                      children: [
                        Icon(Icons.calendar_today, color: Colors.black),
                        SizedBox(width: 5.w),
                        Text(
                          transaction['date']!,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    )),
                    DataCell(Text(
                      transaction['status']!,
                      style: TextStyle(color: statusColor),
                    )),
                  ]);
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}