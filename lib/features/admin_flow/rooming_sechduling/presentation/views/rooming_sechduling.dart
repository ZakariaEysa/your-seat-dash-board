import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/schedule_item.dart';
import 'edit_schedule_page.dart';

class RoomingScheduling extends StatefulWidget {
  final List<ScheduleItem> scheduleItems;

  const RoomingScheduling({super.key, required this.scheduleItems});

  @override
  State<RoomingScheduling> createState() => _RoomingSchedulingState();
}

class _RoomingSchedulingState extends State<RoomingScheduling> {
  void _deleteItem(ScheduleItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete the table"),
        content: const Text("Are you sure you want to delete this item?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.scheduleItems.remove(item);
              });
              Navigator.pop(context);
            },
            child: const Text("yes"),
          ),
        ],
      ),
    );
  }void _editItem(ScheduleItem item) async {
    final index = widget.scheduleItems.indexOf(item);

    if (index == -1) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSchedulePage(
          item: item,
          onSave: (updatedItem) {
            setState(() {
              widget.scheduleItems.removeAt(index);
              widget.scheduleItems.insert(0, updatedItem);
            });
          },
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding:  EdgeInsets.all(16.sp),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.75),child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
            dataRowMaxHeight: 50,
            columnSpacing:1,
            headingTextStyle:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize:5.sp),
            dataTextStyle: const TextStyle(color: Colors.black),
            columns: const [
              DataColumn(label: Text('Room')),
              DataColumn(label: Text('Movie')),
              DataColumn(label: Text('Start Date')),
              DataColumn(label: Text('Start Time')),
              DataColumn(label: Text('End Date')),
              DataColumn(label: Text('End Time')),
              DataColumn(label: Text('Action')),
            ],
            rows: widget.scheduleItems.map((item) {
              return DataRow(cells: [
                DataCell(Text(item.room)),
                DataCell(Text(item.movie)),
                DataCell(Text(item.startDate)),
                DataCell(Text(item.startTime)),
                DataCell(Text(item.endDate)),
                DataCell(Text(item.endTime)),
                DataCell(
              Row(
              children: [
              IconButton(
              icon: const Icon(Icons.edit, color: Colors.green),
              onPressed: () => _editItem(item),
              ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteItem(item),
                  ),
                ]),
              )
             ] );
            }).toList(),
          ),
        ),
      ),)
    );
  }
}
