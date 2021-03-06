import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class PassthroughConverter<T> implements JsonConverter<T, T> {
  const PassthroughConverter();

  @override
  T fromJson(T json) => json;

  @override
  T toJson(T object) => object;
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp json) => json?.toDate();

  @override
  Timestamp toJson(DateTime object) =>
      object == null ? null : Timestamp.fromDate(object);
}

class DocumentReferenceSetConverter
    implements JsonConverter<Set<DocumentReference>, List> {
  const DocumentReferenceSetConverter();
  @override
  Set<DocumentReference> fromJson(List json) =>
      json == null ? null : Set.from(json);

  @override
  List toJson(Set<DocumentReference> refs) =>
      refs == null ? null : List<dynamic>.from(refs);
}

class DocumentReferenceListConverter
    implements JsonConverter<List<DocumentReference>, List> {
  const DocumentReferenceListConverter();
  @override
  List<DocumentReference> fromJson(List json) => json.cast();

  @override
  List toJson(List<DocumentReference> refs) => refs;
}

class DocumentReferenceConverter
    extends PassthroughConverter<DocumentReference> {
  const DocumentReferenceConverter();
}

class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();
  @override
  Color fromJson(int json) => Color(json);
  @override
  int toJson(Color object) => object.value;
}
