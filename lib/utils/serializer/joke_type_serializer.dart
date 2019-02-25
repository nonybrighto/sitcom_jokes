import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:sitcom_joke/models/joke.dart';

class JokeTypeSerializer implements PrimitiveSerializer<JokeType> {
  @override
  JokeType deserialize(Serializers serializers, Object serialized, {FullType specifiedType = FullType.unspecified}) {
    return ((serialized as String) == 'image')?JokeType.image: JokeType.text;
  }

  @override
  Object serialize(Serializers serializers, JokeType object, {FullType specifiedType = FullType.unspecified}) {
    return (object == JokeType.image)?'image':'text';
  }

  @override
  Iterable<Type> get types => new BuiltList<Type>([JokeType]);

  @override
  String get wireName => 'jt';

  final bool structured = false;
}