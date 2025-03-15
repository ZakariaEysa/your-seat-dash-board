import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourseatgraduationproject/features/admin_flow/halls/widgets/hall_details.dart';

class BasicHall extends StatelessWidget {
  const BasicHall.BasicHall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFededed),
      width: 400,
      height: 500,
      child: Center(
        child: HallDetails(),
      ),
    );
  }
}