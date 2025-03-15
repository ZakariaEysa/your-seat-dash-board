import 'package:flutter/material.dart';

class Sales extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final String imagePath; // مسار الصورة

  const Sales({
    Key? key,
    required this.title,
    required this.value,
    required this.color,
    required this.imagePath, // إضافة مسار الصورة
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 100,
        height: 150,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color, // لون الخلفية
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black, // لون خلفية الدائرة
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 4,height: 4,// استخدام الصورة من المسار الممرر
                //  fit: BoxFit.cover, // تغطية المساحة بالكامل
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // لون النص
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4.0),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // لون النص
              ),
            ),
          ],
        ),
      ),
    );
  }
}