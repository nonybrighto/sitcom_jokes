// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_genre.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TmdbMovieGenre> _$tmdbMovieGenreSerializer =
    new _$TmdbMovieGenreSerializer();

class _$TmdbMovieGenreSerializer
    implements StructuredSerializer<TmdbMovieGenre> {
  @override
  final Iterable<Type> types = const [TmdbMovieGenre, _$TmdbMovieGenre];
  @override
  final String wireName = 'TmdbMovieGenre';

  @override
  Iterable serialize(Serializers serializers, TmdbMovieGenre object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  TmdbMovieGenre deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TmdbMovieGenreBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$TmdbMovieGenre extends TmdbMovieGenre {
  @override
  final int id;
  @override
  final String name;

  factory _$TmdbMovieGenre([void updates(TmdbMovieGenreBuilder b)]) =>
      (new TmdbMovieGenreBuilder()..update(updates)).build();

  _$TmdbMovieGenre._({this.id, this.name}) : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TmdbMovieGenre', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('TmdbMovieGenre', 'name');
    }
  }

  @override
  TmdbMovieGenre rebuild(void updates(TmdbMovieGenreBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TmdbMovieGenreBuilder toBuilder() =>
      new TmdbMovieGenreBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TmdbMovieGenre && id == other.id && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, id.hashCode), name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TmdbMovieGenre')
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class TmdbMovieGenreBuilder
    implements Builder<TmdbMovieGenre, TmdbMovieGenreBuilder> {
  _$TmdbMovieGenre _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  TmdbMovieGenreBuilder();

  TmdbMovieGenreBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TmdbMovieGenre other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TmdbMovieGenre;
  }

  @override
  void update(void updates(TmdbMovieGenreBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TmdbMovieGenre build() {
    final _$result = _$v ?? new _$TmdbMovieGenre._(id: id, name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
