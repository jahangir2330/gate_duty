import 'package:flutter/material.dart'; // Import for Locale
import 'package:gipms/data/source/user_service.dart';
import 'package:gipms/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for SharedPreferences

class UserAndLocaleService {
  Future<Locale> getCurrentLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedLocale = prefs.getString('locale');
    final String? localasparam;
    if (savedLocale == 'en') {
      localasparam = "en-us";
    } else if (savedLocale == 'ar') {
      localasparam = "ar-kw";
    } else {
      localasparam = "ar-kw";
    }
    if (savedLocale != null) {
      return Locale(localasparam);
      // return Locale(
      //   savedLocale.split('_')[0],
      //   savedLocale.split('_').length > 1 ? savedLocale.split('_')[1] : null,
      // );
    } else {
      return Locale(localasparam); // Default locale
    }
  }

  UserEntity? get currentUser => UserService().currentUser; // Simplified
}
