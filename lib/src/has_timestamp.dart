import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

mixin HasTimestamp {
  DateTime get createdAt;
  DateTime get updatedAt;

  static Map<String, dynamic> _timestampJson(DateTime createdAt) {
    return <String, dynamic>{
      if (createdAt == null)
        TimestampField.createdAt: FieldValue.serverTimestamp(),
      TimestampField.updatedAt: FieldValue.serverTimestamp(),
    };
  }
}

class TimestampField {
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}

Map<String, dynamic> replacingTimestamp({
  @required Map<String, dynamic> json,
  @required DateTime createdAt,
}) =>
    <String, dynamic>{
      ...json..remove(TimestampField.createdAt),
      ...HasTimestamp._timestampJson(createdAt),
    };

DateTime parseTimestamp({
  @required Map<String, dynamic> json,
  @required String key,
}) {
  return dateFromTimestampValue(json[key]);
}

DateTime dateFromTimestampValue(dynamic value) =>
    (value as Timestamp)?.toDate();

Timestamp timestampFromDateValue(dynamic value) =>
    value is DateTime ? Timestamp.fromDate(value) : null;

const timestampJsonKey = JsonKey(
  fromJson: dateFromTimestampValue,
  toJson: timestampFromDateValue,
);
