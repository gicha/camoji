import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'serializers/date_serializer_plugin.dart';

part 'serializers.g.dart';

/// Serializers
/// Used to serialize/deserialize JSON
/// Before using Serializers you must to:
/// fill your Serializers in [@SerializersFor]
///
/// Then you can use Serializers
/// Examples:
/// * deserialize JSON
/// ```
/// var json='your json';
/// serializers.deserializeWith(YourSerializer.serializer, json)
/// ```
///
/// {@category Network}
@SerializersFor(const [
  ///
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
