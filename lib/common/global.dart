import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gitee_client_flutter/common/gitee_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../index.dart';

///四款主题色
const _themes = <MaterialColor>[Colors.blue, Colors.cyan, Colors.teal, Colors.green, Colors.red];

class Global {
  ///是否为 release 版本
  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  ///缓存
  static SharedPreferences prefs;
  static Profile profile = Profile();
  static NetCache netCache = NetCache();

  ///主题
  static List<MaterialColor> get themes => _themes;

  ///初始化全局信息
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    var _profile = prefs.getString(PREFS_PROFILE);
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }

    ///如果没有缓存策略, 设置默认缓存策略
    profile.cache ??= CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    ///初始化网络请求
    GiteeApi.init();
  }

  ///持久化Profile
  static saveProfile() => prefs.setString(PREFS_PROFILE, jsonEncode(profile.toJson()));
}
