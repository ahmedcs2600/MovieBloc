import 'dart:convert';

extension URLExt on String {
  Uri get toUri => Uri.parse(this);
}

extension JSONExt on String {
  dynamic get toJson => json.decode(this);
}