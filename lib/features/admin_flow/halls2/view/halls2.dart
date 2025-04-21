import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../widgets/button/button_builder.dart';
import '../widgets/basic_hall.dart';

class Halls2 extends StatefulWidget {
  const Halls2({super.key});

  @override
  State<Halls2> createState() => _Halls2State();
}

class _Halls2State extends State<Halls2> {
  final List<GlobalKey<HallConfigPageState>> hallKeys = [
    GlobalKey<HallConfigPageState>()
  ];

  final Set<int> selectedHalls = {};

  @override
  void initState() {
    super.initState();
    selectedHalls.clear(); // تأكيد عدم تحديد أي قاعة تلقائياً
  }

  void _validateAndSave() {
    bool allValid = true;

    for (var key in hallKeys) {
      if (key.currentState?.validate() != true) {
        allValid = false;
      }
    }

    if (allValid) {
      print("✅ All halls are valid. Proceed to save.");
      // Proceed with saving logic
    } else {
      print("❌ Some halls are invalid.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix all errors before saving')),
      );
    }
  }

  void _confirmDeleteSelected() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete selected halls?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final sorted = selectedHalls.toList()
                  ..sort((a, b) => b.compareTo(a));
                for (var index in sorted) {
                  hallKeys.removeAt(index);
                }
                selectedHalls.clear();
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _confirmAddHall() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Add'),
        content: const Text('Are you sure you want to add a new hall?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                hallKeys.add(GlobalKey<HallConfigPageState>());
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New hall added successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Add Hall Button
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 270.w),
              child: SizedBox(
                width: 90.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: _confirmAddHall,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF560B76),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_circle_outline,
                          color: Colors.white, size: 7.sp),
                      SizedBox(width: 2.w),
                      Text(
                        'Add Hall',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Halls Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: hallKeys.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      HallConfigPage(key: hallKeys[index]),
                      if (index != 0)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Checkbox(
                            value: selectedHalls.contains(index),
                            onChanged: (bool? selected) {
                              setState(() {
                                if (selected == true) {
                                  selectedHalls.add(index);
                                } else {
                                  selectedHalls.remove(index);
                                }
                              });
                            },
                          ),
                        ),
                    ],
                  );
                },

              ),
            ),

            // Save / Cancel Buttons
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonBuilder(
                    text: 'Save',
                    onTap: _validateAndSave,
                    width: 40.w,
                    height: 50.h,
                    buttonColor: const Color(0xFF560B76),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ButtonBuilder(
                    text: 'Cancel',
                    onTap: () {
                      // Cancel logic
                    },
                    width: 40.w,
                    height: 50.h,
                    buttonColor: const Color(0xFF560B76),
                    borderShape: BorderRadius.circular(10.r),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 7.sp,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ElevatedButton.icon(
                onPressed: _confirmDeleteSelected ,
                icon: const Icon(Icons.delete, color: Colors.white),
                label: const Text('Delete Selected'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                   Colors.red ,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
