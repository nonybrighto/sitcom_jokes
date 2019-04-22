// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Movie> _$movieSerializer = new _$MovieSerializer();

class _$MovieSerializer implements StructuredSerializer<Movie> {
  @override
  final Iterable<Type> types = const [Movie, _$Movie];
  @override
  final String wireName = 'Movie';

  @override
  Iterable serialize(Serializers serializers, Movie object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'tmdbMovieId',
      serializers.serialize(object.tmdbMovieId,
          specifiedType: const FullType(int)),
      'jokeCount',
      serializers.serialize(object.jokeCount,
          specifiedType: const FullType(int)),
      'releaseDate',
      serializers.serialize(object.releaseDate,
          specifiedType: const FullType(DateTime)),
      'followerCount',
      serializers.serialize(object.followerCount,
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
    if (object.posterUrl != null) {
      result
        ..add('posterUrl')
        ..add(serializers.serialize(object.posterUrl,
            specifiedType: const FullType(String)));
    }
    if (object.tmdbDetails != null) {
      result
        ..add('tmdbDetails')
        ..add(serializers.serialize(object.tmdbDetails,
            specifiedType: const FullType(TmdbMovieDetails)));
    }

    return result;
  }

  @override
  Movie deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MovieBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
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
        case 'posterUrl':
          result.posterUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'jokeCount':
          result.jokeCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'releaseDate':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'followerCount':
          result.followerCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tmdbDetails':
          result.tmdbDetails.replace(serializers.deserialize(value,
                  specifiedType: const FullType(TmdbMovieDetails))
              as TmdbMovieDetails);
          break;
      }
    }

    return result.build();
  }
}

class _$Movie extends Movie {
  @override
  final String id;
  @override
  final String title;
  @override
  final int tmdbMovieId;
  @override
  final bool followed;
  @override
  final String description;
  @override
  final String posterUrl;
  @override
  final int jokeCount;
  @override
  final DateTime releaseDate;
  @override
  final int followerCount;
  @override
  final TmdbMovieDetails tmdbDetails;

  factory _$Movie([void updates(MovieBuilder b)]) =>
      (new MovieBuilder()..update(updates)).build();

  _$Movie._(
      {this.id,
      this.title,
      this.tmdbMovieId,
      this.followed,
      this.description,
      this.posterUrl,
      this.jokeCount,
      this.releaseDate,
      this.followerCount,
      this.tmdbDetails})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Movie', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Movie', 'title');
    }
    if (tmdbMovieId == null) {
      throw new BuiltValueNullFieldError('Movie', 'tmdbMovieId');
    }
    if (jokeCount == null) {
      throw new BuiltValueNullFieldError('Movie', 'jokeCount');
    }
    if (releaseDate == null) {
      throw new BuiltValueNullFieldError('Movie', 'releaseDate');
    }
    if (followerCount == null) {
      throw new BuiltValueNullFieldError('Movie', 'followerCount');
    }
  }

  @override
  Movie rebuild(void updates(MovieBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MovieBuilder toBuilder() => new MovieBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Movie &&
        id == other.id &&
        title == other.title &&
        tmdbMovieId == other.tmdbMovieId &&
        followed == other.followed &&
        description == other.description &&
        posterUrl == other.posterUrl &&
        jokeCount == other.jokeCount &&
        releaseDate == other.releaseDate &&
        followerCount == other.followerCount &&
        tmdbDetails == other.tmdbDetails;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, id.hashCode), title.hashCode),
                                    tmdbMovieId.hashCode),
                                followed.hashCode),
                            description.hashCode),
                        posterUrl.hashCode),
                    jokeCount.hashCode),
                releaseDate.hashCode),
            followerCount.hashCode),
        tmdbDetails.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Movie')
          ..add('id', id)
          ..add('title', title)
          ..add('tmdbMovieId', tmdbMovieId)
          ..add('followed', followed)
          ..add('description', description)
          ..add('posterUrl', posterUrl)
          ..add('jokeCount', jokeCount)
          ..add('releaseDate', releaseDate)
          ..add('followerCount', followerCount)
          ..add('tmdbDetails', tmdbDetails))
        .toString();
  }
}

class MovieBuilder implements Builder<Movie, MovieBuilder> {
  _$Movie _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  int _tmdbMovieId;
  int get tmdbMovieId => _$this._tmdbMovieId;
  set tmdbMovieId(int tmdbMovieId) => _$this._tmdbMovieId = tmdbMovieId;

  bool _followed;
  bool get followed => _$this._followed;
  set followed(bool followed) => _$this._followed = followed;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _posterUrl;
  String get posterUrl => _$this._posterUrl;
  set posterUrl(String posterUrl) => _$this._posterUrl = posterUrl;

  int _jokeCount;
  int get jokeCount => _$this._jokeCount;
  set jokeCount(int jokeCount) => _$this._jokeCount = jokeCount;

  DateTime _releaseDate;
  DateTime get releaseDate => _$this._releaseDate;
  set releaseDate(DateTime releaseDate) => _$this._releaseDate = releaseDate;

  int _followerCount;
  int get followerCount => _$this._followerCount;
  set followerCount(int followerCount) => _$this._followerCount = followerCount;

  TmdbMovieDetailsBuilder _tmdbDetails;
  TmdbMovieDetailsBuilder get tmdbDetails =>
      _$this._tmdbDetails ??= new TmdbMovieDetailsBuilder();
  set tmdbDetails(TmdbMovieDetailsBuilder tmdbDetails) =>
      _$this._tmdbDetails = tmdbDetails;

  MovieBuilder();

  MovieBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _tmdbMovieId = _$v.tmdbMovieId;
      _followed = _$v.followed;
      _description = _$v.description;
      _posterUrl = _$v.posterUrl;
      _jokeCount = _$v.jokeCount;
      _releaseDate = _$v.releaseDate;
      _followerCount = _$v.followerCount;
      _tmdbDetails = _$v.tmdbDetails?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Movie other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Movie;
  }

  @override
  void update(void updates(MovieBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Movie build() {
    _$Movie _$result;
    try {
      _$result = _$v ??
          new _$Movie._(
              id: id,
              title: title,
              tmdbMovieId: tmdbMovieId,
              followed: followed,
              description: description,
              posterUrl: posterUrl,
              jokeCount: jokeCount,
              releaseDate: releaseDate,
              followerCount: followerCount,
              tmdbDetails: _tmdbDetails?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tmdbDetails';
        _tmdbDetails?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Movie', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
