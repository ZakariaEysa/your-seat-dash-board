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
  Future<Map<String, dynamic>?> getCinemaData() async {
    try {
      print('Starting getCinemaData...');
      print('Cinema name to search: ${cinemaNameController.text}');
      
      // الوصول للـ Collection بتاعة Cinemas
      final cinemaRef = FirebaseFirestore.instance.collection('Cinemas');
      print('Accessing Firestore collection: Cinemas');

      // البحث عن السينما بالاسم
      print('Querying Firestore for cinema with name: ${cinemaNameController.text}');
      final querySnapshot = await cinemaRef
          .where('name', isEqualTo: cinemaNameController.text)
          .limit(1)
          .get();
      print('Query completed. Number of documents found: ${querySnapshot.docs.length}');

      // لو لقينا داتا
      if (querySnapshot.docs.isNotEmpty) {
        print('Cinema found! Document ID: ${querySnapshot.docs.first.id}');
        print('Original data from Firestore: ${querySnapshot.docs.first.data()}');
        
        querySnapshot.docs.first.data()['name'] = cinemaNameController.text;
        querySnapshot.docs.first.data()['phone'] = phoneController.text;
        querySnapshot.docs.first.data()['mail'] = emailController.text;
        querySnapshot.docs.first.data()['manager'] = managerController.text;
        querySnapshot.docs.first.data()['country'] = selectedCountry;
        
        print('Modified data to return: ${querySnapshot.docs.first.data()}');
        return querySnapshot.docs.first.data();
      } else {
        print('No cinema found with name: ${cinemaNameController.text}');
        return null;
      }
    } catch (e) {
      print('Error getting cinema data: $e');
      return null;
    }
  }

  // الفانكشن التانية لإضافة أو تحديث بيانات السينما
  Future<bool> addOrUpdateCinemaData() async {
    try {
      print('Starting addOrUpdateCinemaData...');
      print('Cinema name: ${cinemaNameController.text}');
      print('Phone: ${phoneController.text}');
      print('Email: ${emailController.text}');
      print('Manager: ${managerController.text}');
      print('Country: $selectedCountry');

      // الوصول للـ Collection بتاعة Cinemas
      final cinemaRef = FirebaseFirestore.instance.collection('Cinemas');
      print('Accessing Firestore collection: Cinemas');
      
      Map<String, dynamic> cinemaData = {};
      print('Initialized empty cinemaData map');

      // ندور الأول لو السينما موجودة
      print('Querying Firestore for cinema with name: ${cinemaNameController.text}');
      final querySnapshot = await cinemaRef
          .where('name', isEqualTo: cinemaNameController.text)
          .limit(1)
          .get();
      print('Query completed. Number of documents found: ${querySnapshot.docs.length}');

      if (querySnapshot.docs.isNotEmpty) {
        // لو موجودة نعمل update
        print('Cinema exists! Document ID: ${querySnapshot.docs.first.id}');
        cinemaData['rating'] = 0;
        cinemaData['rating_count'] = 0;
        cinemaData['name'] = cinemaNameController.text;
        cinemaData['phone'] = phoneController.text;
        cinemaData['mail'] = emailController.text;
        cinemaData['manager'] = managerController.text;
        cinemaData['country'] = selectedCountry;
        print('Data prepared for update: $cinemaData');

        print('Updating document with ID: ${querySnapshot.docs.first.id}');
        await cinemaRef.doc(querySnapshot.docs.first.id).update(cinemaData);
        print("Cinema updated successfully");
      } else {
        // لو مش موجودة نضيفها جديد باسم السينما كـ ID
        print('No cinema found. Preparing to add new cinema with ID: ${cinemaNameController.text}');
        cinemaData['rating'] = 0;
        cinemaData['rating_count'] = 0;
        cinemaData['name'] = cinemaNameController.text;
        cinemaData['phone'] = phoneController.text;
        cinemaData['mail'] = emailController.text;
        cinemaData['manager'] = managerController.text;
        cinemaData['country'] = selectedCountry;
        print('Data prepared for new document: $cinemaData');

        print('Adding new document with ID: ${cinemaNameController.text}');
        await cinemaRef.doc(cinemaNameController.text).set(cinemaData);
        print("Cinema added successfully with ID: ${cinemaNameController.text}");
      }

      print('addOrUpdateCinemaData completed successfully');
      return true;
    } catch (e) {
      print('Error adding/updating cinema data: $e');
      return false;
    }
  }
}