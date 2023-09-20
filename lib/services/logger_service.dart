library logger_service;

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoggerService {
  static final _singleton = LoggerService();

  static LoggerService get instance => _singleton;


  void e(String msg,{String tag="MESSAGE"}) {
    String colorCode = '\x1B[32m'; // Green
    String boxTopBottom = '+${'-' * 118}+';
    debugPrint(colorCode);
    debugPrint(boxTopBottom);
    debugPrint('${'| $tag: $msg'.padRight(119)}|');
    debugPrint(boxTopBottom);
    debugPrint('\x1B[0m'); // Reset color
  }
  void logLocalResponse({required String data, required String key}) {
    String statusLabel = 'INFO';
    String colorCode = '\x1B[32m'; // Green
    String boxTopBottom = '+${'-' * 118}+';
    String boxMiddle = '|${' ' * 118}|';

    String responseBodyBoxTopBottom = '|${'-' * 118}|';
    String responseBodyBoxMiddle = '|${' ' * 118}|';

    debugPrint(colorCode);
    debugPrint(boxTopBottom);
    debugPrint('${'| KEY: $key - $statusLabel'.padRight(119)}|');
    // debugPrint(boxMiddle);
    debugPrint('${'| DATA:'.padRight(119)}|');
    debugPrint(responseBodyBoxTopBottom);
    for (final line in _wrapText(data, 116)) {
      debugPrint('| ${line.padRight(117)}|');
    }
    // debugPrint(responseBodyBoxMiddle);
    // debugPrint(responseBodyBoxTopBottom);
    // debugPrint(boxMiddle);
    debugPrint(boxTopBottom);
    debugPrint('\x1B[0m'); // Reset color
  }
   void logNetworkResponse(Response response) {
    String statusLabel = 'INFO';
    String colorCode = '\x1B[32m'; // Green

    if (response.status.isOk) {
      statusLabel = 'SUCCESS';
    } else if (response.status.hasError) {
      statusLabel = 'CLIENT ERROR';
      colorCode = '\x1B[33m'; // Yellow
    } else if (response.status.isServerError) {
      statusLabel = 'SERVER ERROR';
      colorCode = '\x1B[31m'; // Red
    } else {
      statusLabel = 'SOMETHING WRONG';
      colorCode = '\x1B[36m'; // Cyan
    }

    String prettyResponse = _tryFormatJson(response.body.toString());
    String headers = response.headers?.toString() ?? 'No Headers'; // Assuming headers are available in your response object

    String boxTopBottom = '+${'-' * 118}+';
    String boxMiddle = '|${' ' * 118}|';

    String responseBodyBoxTopBottom = '|${'-' * 118}|';
    String responseBodyBoxMiddle = '|${' ' * 118}|';

    debugPrint(colorCode);
    debugPrint(boxTopBottom);
    debugPrint('${'| METHOD: ${response.request!.method}'.padRight(119)}|'); // Assuming method and url are available in your response object
    debugPrint('${'| URL: ${response.request!.url}'.padRight(119)}|'); // Assuming method and url are available in your response object
    debugPrint('${'| STATUS: ${response.statusCode} - $statusLabel'.padRight(119)}|');
    // debugPrint(boxMiddle);
    debugPrint('${'| RESPONSE:'.padRight(119)}|');
    debugPrint(responseBodyBoxTopBottom);
    for (final line in _wrapText(prettyResponse, 116)) {
      debugPrint('| ${line.padRight(117)}|');
    }
    // debugPrint(responseBodyBoxMiddle);
    // debugPrint(responseBodyBoxTopBottom);
    // debugPrint(boxMiddle);
    debugPrint(boxTopBottom);
    debugPrint('\x1B[0m'); // Reset color
  }

  List<String> _wrapText(String text, int width) {
    final lines = <String>[];
    final words = text.split(' ');
    String line = '';

    for (final word in words) {
      if ((line + word).length >= width) {
        lines.add(line.trim());
        line = '';
      }
      line += '$word ';
    }
    lines.add(line.trim());

    return lines;
  }

  String _tryFormatJson(String text) {
    try {
      final json = jsonDecode(text);
      return const JsonEncoder.withIndent('  ').convert(json);
    } catch (e) {
      return text; // Not JSON, return original text
    }
  }
}
