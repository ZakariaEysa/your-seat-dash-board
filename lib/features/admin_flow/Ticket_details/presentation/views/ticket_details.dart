import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yourseatgraduationproject/features/admin_flow/Ticket_details/presentation/widets/Ticket_id.dart';
import '../widets/Ticket_Info/Ticket_info.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              const TicketId(),
              SizedBox(height: 50.h),
              const TicketInfo(),
              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
    );
  }}
