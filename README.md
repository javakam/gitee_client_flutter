# gitee_client_flutter

## 项目结构
```
文件夹	作用
common	一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等
l10n	国际化相关的类都在此目录下
models	Json文件对应的Dart Model类会在此目录下
states	保存APP中需要跨组件共享的状态类
routes	存放所有路由页面类
widgets	APP内封装的一些Widget组件都在该目录下
```

## 国际化


dart -> arb
```
flutter pub pub run intl_translation:extract_to_arb --output-dir=target/directory
      my_program.dart more_of_my_program.dart
my: 
flutter pub pub run intl_translation:extract_to_arb --output-dir=l10n-arb \ lib/l10n/localization_intl.dart
```
arb -> dart
```
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart l10n-arb/intl_*.arb
```

根目录下创建一个intl.sh的脚本，内容为：
```
flutter pub pub run intl_translation:extract_to_arb --output-dir=l10n-arb lib/l10n/localization_intl.dart
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart l10n-arb/intl_*.arb
```
Linux: 然后授予执行权限： `chmod +x intl.sh` , 执行intl.sh： `./intl.sh` <br>

Windows: `intl.sh`

## 使用`json_model`构建`json_serializable`实体类

🍎仅需一条指令 👉 `flutter packages pub run json_model`

🍎网页版 👉 <https://caijinglong.github.io/json2dart/index_ch.html>

## flukit
<https://github.com/flutterchina/flukit>

## enum 
<https://medium.com/flutter/enums-with-extensions-dart-460c42ea51f7>

```dart
///方式一
const tab_title_home = <String>["推荐项目", "热门项目", "最近更新"];

///方式二(推荐)
enum TabTitleHome {
  Recommend,
  Popular,
  Recent,
}

extension TabTitleHomeExtension on TabTitleHome {
  //eg: Recommend
  String get name => describeEnum(this);

  List<String> get  _titles => <String>["推荐项目", "热门项目", "最近更新"];

  String get _titles => titles.elementAt(this.index);
}
```

应用:
```dart
List<String> _tabs = tab_title_home.toList();
List<String> _tabs = TabTitleHome.Recommend.titles;//_titles -> titles
List<String> _tabs = TabTitleHome.values.map((e) => e.title).toList();//推荐
```