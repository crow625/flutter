import 'package:json_annotation/json_annotation.dart';

/// Convert DateTime to and from Milliseconds since epoch
class DateTimeMillisConverter implements JsonConverter<DateTime, int> {
  const DateTimeMillisConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.millisecondsSinceEpoch;
}

/// Convert DateTime to and from Microseconds since epoch
class DateTimeMicrosConverter implements JsonConverter<DateTime, int> {
  const DateTimeMicrosConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMicrosecondsSinceEpoch(json);

  @override
  int toJson(DateTime object) => object.microsecondsSinceEpoch;
}

/// Convert DateTime to and from ISO 8601 string
class DateTimeIsoConverter implements JsonConverter<DateTime, String> {
  const DateTimeIsoConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json);

  @override
  String toJson(DateTime object) => object.toIso8601String();
}
