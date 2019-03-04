// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Movie extends Movie {
  @override
  final BasicMovieDetails basicDetails;
  @override
  final TmdbMovieDetails tmdbDetails;

  factory _$Movie([void updates(MovieBuilder b)]) =>
      (new MovieBuilder()..update(updates)).build();

  _$Movie._({this.basicDetails, this.tmdbDetails}) : super._();

  @override
  Movie rebuild(void updates(MovieBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MovieBuilder toBuilder() => new MovieBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Movie &&
        basicDetails == other.basicDetails &&
        tmdbDetails == other.tmdbDetails;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, basicDetails.hashCode), tmdbDetails.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Movie')
          ..add('basicDetails', basicDetails)
          ..add('tmdbDetails', tmdbDetails))
        .toString();
  }
}

class MovieBuilder implements Builder<Movie, MovieBuilder> {
  _$Movie _$v;

  BasicMovieDetailsBuilder _basicDetails;
  BasicMovieDetailsBuilder get basicDetails =>
      _$this._basicDetails ??= new BasicMovieDetailsBuilder();
  set basicDetails(BasicMovieDetailsBuilder basicDetails) =>
      _$this._basicDetails = basicDetails;

  TmdbMovieDetailsBuilder _tmdbDetails;
  TmdbMovieDetailsBuilder get tmdbDetails =>
      _$this._tmdbDetails ??= new TmdbMovieDetailsBuilder();
  set tmdbDetails(TmdbMovieDetailsBuilder tmdbDetails) =>
      _$this._tmdbDetails = tmdbDetails;

  MovieBuilder();

  MovieBuilder get _$this {
    if (_$v != null) {
      _basicDetails = _$v.basicDetails?.toBuilder();
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
              basicDetails: _basicDetails?.build(),
              tmdbDetails: _tmdbDetails?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'basicDetails';
        _basicDetails?.build();
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
