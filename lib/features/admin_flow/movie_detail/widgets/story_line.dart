import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoryLine extends StatelessWidget {
  const StoryLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('                                                                 StoryLine',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: SizedBox(
          width: 170.w,height: 490.h,
          child: TextField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintText: 'Write  story line here ... ',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

