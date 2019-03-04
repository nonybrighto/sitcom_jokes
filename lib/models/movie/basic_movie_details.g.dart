// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_movie_details.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BasicMovieDetails> _$basicMovieDetailsSerializer =
    new _$BasicMovieDetailsSerializer();

class _$BasicMovieDetailsSerializer
    implements StructuredSerializer<BasicMovieDetails> {
  @override
  final Iterable<Type> types = const [BasicMovieDetails, _$BasicMovieDetails];
  @override
  final String wireName = 'BasicMovieDetails';

  @override
  Iterable serialize(Serializers serializers, BasicMovieDetails object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'tmdbMovieId',
      serializers.serialize(object.tmdbMovieId,
          specifiedType: const FullType(int)),
    ];
    if (object.followed != null) {
      result
        ..add('followed')
        ..add(serializers.serialize(object.followed,
            specifiedType: const FullType(bool)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  BasicMovieDetails deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BasicMovieDetailsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tmdbMovieId':
          result.tmdbMovieId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'followed':
          result.followed = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BasicMovieDetails extends BasicMovieDetails {
  @override
  final String id;
  @override
  final String name;
  @override
  final int tmdbMovieId;
  @override
  final bool followed;
  @override
  final String description;

  factory _$BasicMovieDetails([void updates(BasicMovieDetailsBuilder b)]) =>
      (new BasicMovieDetailsBuilder()..update(updates)).build();

  _$BasicMovieDetails._(
      {this.id, this.name, this.tmdbMovieId, this.followed, this.description})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('BasicMovieDetails', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('BasicMovieDetails', 'name');
    }
    if (tmdbMovieId == null) {
      throw new BuiltValueNullFieldError('BasicMovieDetails', 'tmdbMovieId');
    }
  }

  @override
  BasicMovieDetails rebuild(void updates(BasicMovieDetailsBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BasicMovieDetailsBuilder toBuilder() =>
      new BasicMovieDetailsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BasicMovieDetails &&
        id == other.id &&
        name == other.name &&
        tmdbMovieId == other.tmdbMovieId &&
        followed == other.followed &&
        description == other.description;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), name.hashCode), tmdbMovieId.hashCode),
            followed.hashCode),
        description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BasicMovieDetails')
          ..add('id', id)
          ..add('name', name)
          ..add('tmdbMovieId', tmdbMovieId)
          ..add('followed', followed)
          ..add('description', description))
        .toString();
  }
}

class BasicMovieDetailsBuilder
    implements Builder<BasicMovieDetails, BasicMovieDetailsBuilder> {
  _$BasicMovieDetails _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _tmdbMovieId;
  int get tmdbMovieId => _$this._tmdbMovieId;
  set tmdbMovieId(int tmdbMovieId) => _$this._tmdbMovieId = tmdbMovieId;

  bool _followed;
  bool get followed => _$this._followed;
  set followed(bool followed) => _$this._followed = followed;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  BasicMovieDetailsBuilder();

  BasicMovieDetailsBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _tmdbMovieId = _$v.tmdbMovieId;
      _followed = _$v.followed;
      _description = _$v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BasicMovieDetails other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BasicMovieDetails;
  }

  @override
  void update(void updates(BasicMovieDetailsBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BasicMovieDetails build() {
    final _$result = _$v ??
        new _$BasicMovieDetails._(
            id: id,
            name: name,
            tmdbMovieId: tmdbMovieId,
            followed: followed,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
