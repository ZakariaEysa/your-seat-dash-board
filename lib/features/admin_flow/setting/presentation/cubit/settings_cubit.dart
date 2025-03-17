import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourseatgraduationproject/utils/app_logs.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  TextEditingController cinemaNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  String? selectedCountry;

  String? cinemaId;

  static SettingsCubit get(context) => BlocProvider.of<SettingsCubit>(context);

  Future<void> getCinemaData() async {
    cinemaId = "almodhsheenN";
    emit(SettingsLoading());
    try {
      final cinemaRef = FirebaseFirestore.instance.collection('Cinemas');
      final querySnapshot =
          await cinemaRef.where('name', isEqualTo: cinemaId).limit(1).get();

      AppLogs.scussessLog(querySnapshot.docs.toString());
      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        cinemaNameController.text = data['name'] ?? '';
        phoneController.text = data['phone'] ?? '';
        emailController.text = data['mail'] ?? '';
        managerController.text = data['manager'] ?? '';
        selectedCountry = data['country'];
        emit(SettingsLoaded());
      } else {
        emit(SettingsLoaded());
      }
    } catch (e) {
      emit(SettingsError('Error getting cinema data: $e'));
    }
  }

  Future<void> addOrUpdateCinemaData() async {
    emit(SettingsLoading());
    try {
      final cinemaRef = FirebaseFirestore.instance.collection('Cinemas');
      Map<String, dynamic> cinemaData = {
        'rating': 0,
        'rating_count': 0,
        'name': cinemaNameController.text,
        'phone': phoneController.text,
        'mail': emailController.text,
        'manager': managerController.text,
        'country': selectedCountry,
      };

      final querySnapshot =
          await cinemaRef.where('name', isEqualTo: cinemaId).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        await cinemaRef.doc(querySnapshot.docs.first.id).update(cinemaData);
        AppLogs.debugLog("updated");
      } else {
        await cinemaRef.doc(cinemaId).set(cinemaData);
        AppLogs.debugLog("added");
      }

      emit(SettingsLoaded());
    } catch (e) {
      emit(SettingsError('Error adding/updating cinema data: $e'));
    }
  }
}
