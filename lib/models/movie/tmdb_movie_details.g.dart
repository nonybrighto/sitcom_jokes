// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_details.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TmdbMovieDetails> _$tmdbMovieDetailsSerializer =
    new _$TmdbMovieDetailsSerializer();

class _$TmdbMovieDetailsSerializer
    implements StructuredSerializer<TmdbMovieDetails> {
  @override
  final Iterable<Type> types = const [TmdbMovieDetails, _$TmdbMovieDetails];
  @override
  final String wireName = 'TmdbMovieDetails';

  @override
  Iterable serialize(Serializers serializers, TmdbMovieDetails object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'backdrop_path',
      serializers.serialize(object.backdropPath,
          specifiedType: const FullType(String)),
      'overview',
      serializers.serialize(object.overview,
          specifiedType: const FullType(String)),
      'release_date',
      serializers.serialize(object.releaseDate,
          specifiedType: const FullType(DateTime)),
      'vote_average',
      serializers.serialize(object.voteAverage,
          specifiedType: const FullType(double)),
    ];
    if (object.genres != null) {
      result
        ..add('genres')
        ..add(serializers.serialize(object.genres,
            specifiedType: const FullType(
                BuiltList, const [const FullType(TmdbMovieGenre)])));
    }
    if (object.credits != null) {
      result
        ..add('credits')
        ..add(serializers.serialize(object.credits,
            specifiedType: const FullType(TmdbMovieCredit)));
    }

    return result;
  }

  @override
  TmdbMovieDetails deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TmdbMovieDetailsBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'backdrop_path':
          result.backdropPath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'overview':
          result.overview = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'release_date':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'vote_average':
          result.voteAverage = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'genres':
          result.genres.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(TmdbMovieGenre)]))
              as BuiltList);
          break;
        case 'credits':
          result.credits.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TmdbMovieCredit))
              as TmdbMovieCredit);
          break;
      }
    }

    return result.build();
  }
}

class _$TmdbMovieDetails extends TmdbMovieDetails {
  @override
  final int id;
  @override
  final String title;
  @override
  final String backdropPath;
  @override
  final String overview;
  @override
  final DateTime releaseDate;
  @override
  final double voteAverage;
  @override
  final BuiltList<TmdbMovieGenre> genres;
  @override
  final TmdbMovieCredit credits;

  factory _$TmdbMovieDetails([void updates(TmdbMovieDetailsBuilder b)]) =>
      (new TmdbMovieDetailsBuilder()..update(updates)).build();

  _$TmdbMovieDetails._(
      {this.id,
      this.title,
      this.backdropPath,
      this.overview,
      this.releaseDate,
      this.voteAverage,
      this.genres,
      this.credits})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('TmdbMovieDetails', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('TmdbMovieDetails', 'title');
    }
    if (backdropPath == null) {
      throw new BuiltValueNullFieldError('TmdbMovieDetails', 'backdropPath');
    }
    if (overview == null) {
      throw new BuiltValueNullFieldError('TmdbMovieDetails', 'overview');
    }
    if (releaseDate == null) {
      throw new BuiltValueNullFieldError('TmdbMovieDetails', 'releaseDate');
    }
    if (voteAverage == null) {
      throw new BuiltValueNullFieldError('TmdbMovieDetails', 'voteAverage');
    }
  }

  @override
  TmdbMovieDetails rebuild(void updates(TmdbMovieDetailsBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TmdbMovieDetailsBuilder toBuilder() =>
      new TmdbMovieDetailsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TmdbMovieDetails &&
        id == other.id &&
        title == other.title &&
        backdropPath == other.backdropPath &&
        overview == other.overview &&
        releaseDate == other.releaseDate &&
        voteAverage == other.voteAverage &&
        genres == other.genres &&
        credits == other.credits;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, id.hashCode), title.hashCode),
                            backdropPath.hashCode),
                        overview.hashCode),
                    releaseDate.hashCode),
                voteAverage.hashCode),
            genres.hashCode),
        credits.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TmdbMovieDetails')
          ..add('id', id)
          ..add('title', title)
          ..add('backdropPath', backdropPath)
          ..add('overview', overview)
          ..add('releaseDate', releaseDate)
          ..add('voteAverage', voteAverage)
          ..add('genres', genres)
          ..add('credits', credits))
        .toString();
  }
}

class TmdbMovieDetailsBuilder
    implements Builder<TmdbMovieDetails, TmdbMovieDetailsBuilder> {
  _$TmdbMovieDetails _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _backdropPath;
  String get backdropPath => _$this._backdropPath;
  set backdropPath(String backdropPath) => _$this._backdropPath = backdropPath;

  String _overview;
  String get overview => _$this._overview;
  set overview(String overview) => _$this._overview = overview;

  DateTime _releaseDate;
  DateTime get releaseDate => _$this._releaseDate;
  set releaseDate(DateTime releaseDate) => _$this._releaseDate = releaseDate;

  double _voteAverage;
  double get voteAverage => _$this._voteAverage;
  set voteAverage(double voteAverage) => _$this._voteAverage = voteAverage;

  ListBuilder<TmdbMovieGenre> _genres;
  ListBuilder<TmdbMovieGenre> get genres =>
      _$this._genres ??= new ListBuilder<TmdbMovieGenre>();
  set genres(ListBuilder<TmdbMovieGenre> genres) => _$this._genres = genres;

  TmdbMovieCreditBuilder _credits;
  TmdbMovieCreditBuilder get credits =>
      _$this._credits ??= new TmdbMovieCreditBuilder();
  set credits(TmdbMovieCreditBuilder credits) => _$this._credits = credits;

  TmdbMovieDetailsBuilder();

  TmdbMovieDetailsBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _backdropPath = _$v.backdropPath;
      _overview = _$v.overview;
      _releaseDate = _$v.releaseDate;
      _voteAverage = _$v.voteAverage;
      _genres = _$v.genres?.toBuilder();
      _credits = _$v.credits?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TmdbMovieDetails other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TmdbMovieDetails;
  }

  @override
  void update(void updates(TmdbMovieDetailsBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TmdbMovieDetails build() {
    _$TmdbMovieDetails _$result;
    try {
      _$result = _$v ??
          new _$TmdbMovieDetails._(
              id: id,
              title: title,
              backdropPath: backdropPath,
              overview: overview,
              releaseDate: releaseDate,
              voteAverage: voteAverage,
              genres: _genres?.build(),
              credits: _credits?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'genres';
        _genres?.build();
        _$failedField = 'credits';
        _credits?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TmdbMovieDetails', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
