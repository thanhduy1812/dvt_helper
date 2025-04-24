import 'dart:convert';

import 'package:gtd_network/network/network_service/gtd_json_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:path_provider/path_provider.dart' as path_provider;
enum CacheStorageType {
  appToken,
  appProfile,
  appUser,
  appLanguage,
}

class CacheHelper {
  SharedPreferences? prefs;

  CacheHelper._();

  static final shared = CacheHelper._();

  void initCachedMemory() async {
    try {
      prefs = await SharedPreferences.getInstance();
      cacheLanguage("vi");
      // cacheAppToken("Bearer ${GtdChannelSettingObject.shared.token}");
      if (kDebugMode) {
        print("Path initCachedMemory Stream success");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Path initCachedMemory PlatformException failed: $e");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Path initCachedMemory failed: $e");
      }
    }
  }

  String getCachedLanguage() {
    final code = prefs?.getString(CacheStorageType.appLanguage.name);
    if (code != null) {
      return code;
    } else {
      return 'vi';
    }
  }

  Future<void> cacheLanguage(String code) async {
    await prefs?.setString(CacheStorageType.appLanguage.name, code);
    if (kDebugMode) {
      print("VNLook cacheLanguage: $code");
    }
  }

  String getCachedAppToken() {
    if (prefs == null) {
      if (kDebugMode) {
        print("getCachedAppToken but prefs is null");
      }
    }
    final token = prefs?.getString(CacheStorageType.appToken.name);
    return token ?? "";
    //Handle token null here
  }

  Future<void> cacheAppToken(String token) async {
    if (prefs == null) {
      if (kDebugMode) {
        print("cacheAppToken but prefs is null");
      }
      initCachedMemory();
    }
    if (kDebugMode) {
      print("VNLook cache Token precache: $token");
    }
    try {
      // prefs ??= await SharedPreferences.getInstance();
      await prefs?.setString(CacheStorageType.appToken.name, token);
      if (kDebugMode) {
        print("VNLook cache Token success: $token");
      }
    } catch (e) {
      if (kDebugMode) {
        print("VNLook cache Token error: $e");
      }
    }
  }

  T? loadSavedObject<T>(T Function(Map<String, dynamic> map) fromJson, {required String key}) {
    final String? jsonString = prefs?.getString(key);
    if (jsonString != null) {
      T? model = GtdJsonParser.jsonToModel(fromJson, json.decode(jsonString));
      return model;
    }
    return null;
  }

  Future<void> saveSharedObject(Map<String, dynamic> mapObject, {required String key}) async {
    await prefs?.setString(key, json.encode(mapObject));
  }

  List<T> loadListSavedObject<T>(T Function(Map<String, dynamic> map) fromJson, {required String key}) {
    final List<String>? jsonListString = prefs?.getStringList(key);
    if (jsonListString != null) {
      List<T> models = GtdJsonParser.jsonArrayToModel(fromJson, jsonListString.map((e) => json.decode(e)).toList());
      return models;
    }
    return [];
  }

  Future<void> saveListSharedObject(List<Map<String, dynamic>> mapObjects, {required String key}) async {
    await prefs?.setStringList(key, mapObjects.map((e) => json.encode(e)).toList());
  }

  void removeCachedSharedObject(String key) async {
    await prefs?.remove(key);
  }
}
