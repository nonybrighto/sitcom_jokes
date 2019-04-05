// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MovieListResponse> _$movieListResponseSerializer =
    new _$MovieListResponseSerializer();

class _$MovieListResponseSerializer
    implements StructuredSerializer<MovieListResponse> {
  @override
  final Iterable<Type> types = const [MovieListResponse, _$MovieListResponse];
  @override
  final String wireName = 'MovieListResponse';

  @override
  Iterable serialize(Serializers serializers, MovieListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'totalPages',
      serializers.serialize(object.totalPages,
          specifiedType: const FullType(int)),
      'perPage',
      serializers.serialize(object.perPage, specifiedType: const FullType(int)),
      'currentPage',
      serializers.serialize(object.currentPage,
          specifiedType: const FullType(int)),
      'results',
      serializers.serialize(object.results,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Movie)])),
    ];

    return result;
  }

  @override
  MovieListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MovieListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'totalPages':
          result.totalPages = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'perPage':
          result.perPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'currentPage':
          result.currentPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'results':
          result.results.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Movie)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$MovieListResponse extends MovieListResponse {
  @override
  final int totalPages;
  @override
  final int perPage;
  @override
  final int currentPage;
  @override
  final BuiltList<Movie> results;

  factory _$MovieListResponse([void updates(MovieListResponseBuilder b)]) =>
      (new MovieListResponseBuilder()..update(updates)).build();

  _$MovieListResponse._(
      {this.totalPages, this.perPage, this.currentPage, this.results})
      : super._() {
    if (totalPages == null) {
      throw new BuiltValueNullFieldError('MovieListResponse', 'totalPages');
    }
    if (perPage == null) {
      throw new BuiltValueNullFieldError('MovieListResponse', 'perPage');
    }
    if (currentPage == null) {
      throw new BuiltValueNullFieldError('MovieListResponse', 'currentPage');
    }
    if (results == null) {
      throw new BuiltValueNullFieldError('MovieListResponse', 'results');
    }
  }

  @override
  MovieListResponse rebuild(void updates(MovieListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  MovieListResponseBuilder toBuilder() =>
      new MovieListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MovieListResponse &&
        totalPages == other.totalPages &&
        perPage == other.perPage &&
        currentPage == other.currentPage &&
        results == other.results;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, totalPages.hashCode), perPage.hashCode),
            currentPage.hashCode),
        results.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MovieListResponse')
          ..add('totalPages', totalPages)
          ..add('perPage', perPage)
          ..add('currentPage', currentPage)
          ..add('results', results))
        .toString();
  }
}

class MovieListResponseBuilder
    implements Builder<MovieListResponse, MovieListResponseBuilder> {
  _$MovieListResponse _$v;

  int _totalPages;
  int get totalPages => _$this._totalPages;
  set totalPages(int totalPages) => _$this._totalPages = totalPages;

  int _perPage;
  int get perPage => _$this._perPage;
  set perPage(int perPage) => _$this._perPage = perPage;

  int _currentPage;
  int get currentPage => _$this._currentPage;
  set currentPage(int currentPage) => _$this._currentPage = currentPage;

  ListBuilder<Movie> _results;
  ListBuilder<Movie> get results =>
      _$this._results ??= new ListBuilder<Movie>();
  set results(ListBuilder<Movie> results) => _$this._results = results;

  MovieListResponseBuilder();

  MovieListResponseBuilder get _$this {
    if (_$v != null) {
      _totalPages = _$v.totalPages;
      _perPage = _$v.perPage;
      _currentPage = _$v.currentPage;
      _results = _$v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MovieListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MovieListResponse;
  }

  @override
  void update(void updates(MovieListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$MovieListResponse build() {
    _$MovieListResponse _$result;
    try {
      _$result = _$v ??
          new _$MovieListResponse._(
              totalPages: totalPages,
              perPage: perPage,
              currentPage: currentPage,
              results: results.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'results';
        results.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MovieListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
