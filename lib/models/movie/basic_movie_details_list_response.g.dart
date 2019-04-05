// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_movie_details_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BasicMovieDetailsListResponse>
    _$basicMovieDetailsListResponseSerializer =
    new _$BasicMovieDetailsListResponseSerializer();

class _$BasicMovieDetailsListResponseSerializer
    implements StructuredSerializer<BasicMovieDetailsListResponse> {
  @override
  final Iterable<Type> types = const [
    BasicMovieDetailsListResponse,
    _$BasicMovieDetailsListResponse
  ];
  @override
  final String wireName = 'BasicMovieDetailsListResponse';

  @override
  Iterable serialize(
      Serializers serializers, BasicMovieDetailsListResponse object,
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
          specifiedType: const FullType(
              BuiltList, const [const FullType(BasicMovieDetails)])),
    ];

    return result;
  }

  @override
  BasicMovieDetailsListResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BasicMovieDetailsListResponseBuilder();

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
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(BasicMovieDetails)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$BasicMovieDetailsListResponse extends BasicMovieDetailsListResponse {
  @override
  final int totalPages;
  @override
  final int perPage;
  @override
  final int currentPage;
  @override
  final BuiltList<BasicMovieDetails> results;

  factory _$BasicMovieDetailsListResponse(
          [void updates(BasicMovieDetailsListResponseBuilder b)]) =>
      (new BasicMovieDetailsListResponseBuilder()..update(updates)).build();

  _$BasicMovieDetailsListResponse._(
      {this.totalPages, this.perPage, this.currentPage, this.results})
      : super._() {
    if (totalPages == null) {
      throw new BuiltValueNullFieldError(
          'BasicMovieDetailsListResponse', 'totalPages');
    }
    if (perPage == null) {
      throw new BuiltValueNullFieldError(
          'BasicMovieDetailsListResponse', 'perPage');
    }
    if (currentPage == null) {
      throw new BuiltValueNullFieldError(
          'BasicMovieDetailsListResponse', 'currentPage');
    }
    if (results == null) {
      throw new BuiltValueNullFieldError(
          'BasicMovieDetailsListResponse', 'results');
    }
  }

  @override
  BasicMovieDetailsListResponse rebuild(
          void updates(BasicMovieDetailsListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  BasicMovieDetailsListResponseBuilder toBuilder() =>
      new BasicMovieDetailsListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BasicMovieDetailsListResponse &&
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
    return (newBuiltValueToStringHelper('BasicMovieDetailsListResponse')
          ..add('totalPages', totalPages)
          ..add('perPage', perPage)
          ..add('currentPage', currentPage)
          ..add('results', results))
        .toString();
  }
}

class BasicMovieDetailsListResponseBuilder
    implements
        Builder<BasicMovieDetailsListResponse,
            BasicMovieDetailsListResponseBuilder> {
  _$BasicMovieDetailsListResponse _$v;

  int _totalPages;
  int get totalPages => _$this._totalPages;
  set totalPages(int totalPages) => _$this._totalPages = totalPages;

  int _perPage;
  int get perPage => _$this._perPage;
  set perPage(int perPage) => _$this._perPage = perPage;

  int _currentPage;
  int get currentPage => _$this._currentPage;
  set currentPage(int currentPage) => _$this._currentPage = currentPage;

  ListBuilder<BasicMovieDetails> _results;
  ListBuilder<BasicMovieDetails> get results =>
      _$this._results ??= new ListBuilder<BasicMovieDetails>();
  set results(ListBuilder<BasicMovieDetails> results) =>
      _$this._results = results;

  BasicMovieDetailsListResponseBuilder();

  BasicMovieDetailsListResponseBuilder get _$this {
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
  void replace(BasicMovieDetailsListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BasicMovieDetailsListResponse;
  }

  @override
  void update(void updates(BasicMovieDetailsListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$BasicMovieDetailsListResponse build() {
    _$BasicMovieDetailsListResponse _$result;
    try {
      _$result = _$v ??
          new _$BasicMovieDetailsListResponse._(
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
            'BasicMovieDetailsListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
