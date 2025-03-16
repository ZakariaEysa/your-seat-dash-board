import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  TextEditingController cinemaNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  String? selectedCountry;
     static SettingsCubit get(context) => BlocProvider.of<SettingsCubit>(context);


// الفانكشن الأولى لجلب بيانات السينما
  Future<Map<String, dynamic>?> getCinemaData(String cinemaName) async {
    try {
      // الوصول للـ Collection بتاعة Cinemas
      final cinemaRef = FirebaseFirestore.instance.collection('Cinemas');

      // البحث عن السينما بالاسم
      final querySnapshot =
          await cinemaRef.where('name', isEqualTo: cinemaName).limit(1).get();

      // لو لقينا داتا
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      } else {
        // لو مفيش داتا
        return null;
      }
    } catch (e) {
      print('Error getting cinema data: $e');
      return null;
    }
  }

// الفانكشن التانية لإضافة أو تحديث بيانات السينما
  Future<bool> addOrUpdateCinemaData(
      String cinemaName, Map<String, dynamic> cinemaData) async {
    try {
      // الوصول للـ Collection بتاعة Cinemas
      final cinemaRef = FirebaseFirestore.instance.collection('Cinemas');

      // نضيف الـ name للداتا لو مش موجود
      cinemaData['name'] = cinemaName;

      // ندور الأول لو السينما موجودة
      final querySnapshot =
          await cinemaRef.where('name', isEqualTo: cinemaName).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        // لو موجودة نعمل update
        await cinemaRef.doc(querySnapshot.docs.first.id).update(cinemaData);
      } else {
        // لو مش موجودة نضيفها جديد
        await cinemaRef.add(cinemaData);
      }

      return true;
    } catch (e) {
      print('Error adding/updating cinema data: $e');
      return false;
    }
  }

// مثال للاستخدام:
  void exampleUsage() async {
    // جلب بيانات سينما
    final cinemaData = await getCinemaData('Cinema City');
    if (cinemaData != null) {
      print('Cinema found: $cinemaData');
    } else {
      print('مفيش داتا اتضافت لسه');
    }

    // بيانات جديدة عايزين نرفعها
    Map<String, dynamic> newCinemaData = {
      'location': 'Downtown',
      'capacity': 200,
      'open_hours': '10:00 - 22:00'
    };

    // إضافة أو تحديث البيانات
    bool success = await addOrUpdateCinemaData('Cinema City', newCinemaData);
    if (success) {
      print('تم رفع البيانات بنجاح');
    } else {
      print('فيه مشكلة حصلت');
    }
  }
}
