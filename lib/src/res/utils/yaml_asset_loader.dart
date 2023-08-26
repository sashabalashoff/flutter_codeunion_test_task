import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class YamlAssetLoader extends AssetLoader {
  static Map<String, dynamic> convertYamlMapToMap(YamlMap yamlMap) {
    final map = <String, dynamic>{};

    for (final entry in yamlMap.entries) {
      if (entry.value is YamlMap || entry.value is Map) {
        map[entry.key.toString()] = convertYamlMapToMap(entry.value as YamlMap);
      } else {
        map[entry.key.toString()] = entry.value.toString();
      }
    }
    return map;
  }

  String getLocalePath(String basePath, Locale locale) {
    return '$basePath/${locale.toStringWithSeparator(separator: "-")}.yaml';
  }

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    var localePath = getLocalePath(path, locale);
    log('easy localization loader: load yaml file $localePath');
    final yaml = loadYaml(await rootBundle.loadString(localePath)) as YamlMap;
    return convertYamlMapToMap(yaml);
  }
}
