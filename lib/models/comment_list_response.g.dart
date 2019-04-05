// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CommentListResponse> _$commentListResponseSerializer =
    new _$CommentListResponseSerializer();

class _$CommentListResponseSerializer
    implements StructuredSerializer<CommentListResponse> {
  @override
  final Iterable<Type> types = const [
    CommentListResponse,
    _$CommentListResponse
  ];
  @override
  final String wireName = 'CommentListResponse';

  @override
  Iterable serialize(Serializers serializers, CommentListResponse object,
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
              const FullType(BuiltList, const [const FullType(Comment)])),
    ];

    return result;
  }

  @override
  CommentListResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentListResponseBuilder();

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
                  BuiltList, const [const FullType(Comment)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$CommentListResponse extends CommentListResponse {
  @override
  final int totalPages;
  @override
  final int perPage;
  @override
  final int currentPage;
  @override
  final BuiltList<Comment> results;

  factory _$CommentListResponse([void updates(CommentListResponseBuilder b)]) =>
      (new CommentListResponseBuilder()..update(updates)).build();

  _$CommentListResponse._(
      {this.totalPages, this.perPage, this.currentPage, this.results})
      : super._() {
    if (totalPages == null) {
      throw new BuiltValueNullFieldError('CommentListResponse', 'totalPages');
    }
    if (perPage == null) {
      throw new BuiltValueNullFieldError('CommentListResponse', 'perPage');
    }
    if (currentPage == null) {
      throw new BuiltValueNullFieldError('CommentListResponse', 'currentPage');
    }
    if (results == null) {
      throw new BuiltValueNullFieldError('CommentListResponse', 'results');
    }
  }

  @override
  CommentListResponse rebuild(void updates(CommentListResponseBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentListResponseBuilder toBuilder() =>
      new CommentListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentListResponse &&
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
    return (newBuiltValueToStringHelper('CommentListResponse')
          ..add('totalPages', totalPages)
          ..add('perPage', perPage)
          ..add('currentPage', currentPage)
          ..add('results', results))
        .toString();
  }
}

class CommentListResponseBuilder
    implements Builder<CommentListResponse, CommentListResponseBuilder> {
  _$CommentListResponse _$v;

  int _totalPages;
  int get totalPages => _$this._totalPages;
  set totalPages(int totalPages) => _$this._totalPages = totalPages;

  int _perPage;
  int get perPage => _$this._perPage;
  set perPage(int perPage) => _$this._perPage = perPage;

  int _currentPage;
  int get currentPage => _$this._currentPage;
  set currentPage(int currentPage) => _$this._currentPage = currentPage;

  ListBuilder<Comment> _results;
  ListBuilder<Comment> get results =>
      _$this._results ??= new ListBuilder<Comment>();
  set results(ListBuilder<Comment> results) => _$this._results = results;

  CommentListResponseBuilder();

  CommentListResponseBuilder get _$this {
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
  void replace(CommentListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CommentListResponse;
  }

  @override
  void update(void updates(CommentListResponseBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CommentListResponse build() {
    _$CommentListResponse _$result;
    try {
      _$result = _$v ??
          new _$CommentListResponse._(
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
            'CommentListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
