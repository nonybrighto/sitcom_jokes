// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'joke.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Joke> _$jokeSerializer = new _$JokeSerializer();

class _$JokeSerializer implements StructuredSerializer<Joke> {
  @override
  final Iterable<Type> types = const [Joke, _$Joke];
  @override
  final String wireName = 'Joke';

  @override
  Iterable serialize(Serializers serializers, Joke object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'content',
      serializers.serialize(object.content,
          specifiedType: const FullType(String)),
      'commentCount',
      serializers.serialize(object.commentCount,
          specifiedType: const FullType(int)),
      'jokeType',
      serializers.serialize(object.jokeType,
          specifiedType: const FullType(JokeType)),
      'liked',
      serializers.serialize(object.liked, specifiedType: const FullType(bool)),
      'favorited',
      serializers.serialize(object.favorited,
          specifiedType: const FullType(bool)),
    ];
    if (object.dateAdded != null) {
      result
        ..add('dateAdded')
        ..add(serializers.serialize(object.dateAdded,
            specifiedType: const FullType(DateTime)));
    }
    if (object.likeCount != null) {
      result
        ..add('likeCount')
        ..add(serializers.serialize(object.likeCount,
            specifiedType: const FullType(int)));
    }
    if (object.movie != null) {
      result
        ..add('movie')
        ..add(serializers.serialize(object.movie,
            specifiedType: const FullType(BasicMovieDetails)));
    }
    if (object.owner != null) {
      result
        ..add('owner')
        ..add(serializers.serialize(object.owner,
            specifiedType: const FullType(User)));
    }

    return result;
  }

  @override
  Joke deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new JokeBuilder();

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
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'commentCount':
          result.commentCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'jokeType':
          result.jokeType = serializers.deserialize(value,
              specifiedType: const FullType(JokeType)) as JokeType;
          break;
        case 'dateAdded':
          result.dateAdded = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'likeCount':
          result.likeCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'liked':
          result.liked = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'favorited':
          result.favorited = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'movie':
          result.movie.replace(serializers.deserialize(value,
                  specifiedType: const FullType(BasicMovieDetails))
              as BasicMovieDetails);
          break;
        case 'owner':
          result.owner.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
      }
    }

    return result.build();
  }
}

class _$Joke extends Joke {
  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final int commentCount;
  @override
  final JokeType jokeType;
  @override
  final DateTime dateAdded;
  @override
  final int likeCount;
  @override
  final bool liked;
  @override
  final bool favorited;
  @override
  final BasicMovieDetails movie;
  @override
  final User owner;

  factory _$Joke([void updates(JokeBuilder b)]) =>
      (new JokeBuilder()..update(updates)).build();

  _$Joke._(
      {this.id,
      this.title,
      this.content,
      this.commentCount,
      this.jokeType,
      this.dateAdded,
      this.likeCount,
      this.liked,
      this.favorited,
      this.movie,
      this.owner})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Joke', 'id');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Joke', 'title');
    }
    if (content == null) {
      throw new BuiltValueNullFieldError('Joke', 'content');
    }
    if (commentCount == null) {
      throw new BuiltValueNullFieldError('Joke', 'commentCount');
    }
    if (jokeType == null) {
      throw new BuiltValueNullFieldError('Joke', 'jokeType');
    }
    if (liked == null) {
      throw new BuiltValueNullFieldError('Joke', 'liked');
    }
    if (favorited == null) {
      throw new BuiltValueNullFieldError('Joke', 'favorited');
    }
  }

  @override
  Joke rebuild(void updates(JokeBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  JokeBuilder toBuilder() => new JokeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Joke &&
        id == other.id &&
        title == other.title &&
        content == other.content &&
        commentCount == other.commentCount &&
        jokeType == other.jokeType &&
        dateAdded == other.dateAdded &&
        likeCount == other.likeCount &&
        liked == other.liked &&
        favorited == other.favorited &&
        movie == other.movie &&
        owner == other.owner;
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
                                $jc(
                                    $jc(
                                        $jc($jc(0, id.hashCode),
                                            title.hashCode),
                                        content.hashCode),
                                    commentCount.hashCode),
                                jokeType.hashCode),
                            dateAdded.hashCode),
                        likeCount.hashCode),
                    liked.hashCode),
                favorited.hashCode),
            movie.hashCode),
        owner.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Joke')
          ..add('id', id)
          ..add('title', title)
          ..add('content', content)
          ..add('commentCount', commentCount)
          ..add('jokeType', jokeType)
          ..add('dateAdded', dateAdded)
          ..add('likeCount', likeCount)
          ..add('liked', liked)
          ..add('favorited', favorited)
          ..add('movie', movie)
          ..add('owner', owner))
        .toString();
  }
}

class JokeBuilder implements Builder<Joke, JokeBuilder> {
  _$Joke _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  int _commentCount;
  int get commentCount => _$this._commentCount;
  set commentCount(int commentCount) => _$this._commentCount = commentCount;

  JokeType _jokeType;
  JokeType get jokeType => _$this._jokeType;
  set jokeType(JokeType jokeType) => _$this._jokeType = jokeType;

  DateTime _dateAdded;
  DateTime get dateAdded => _$this._dateAdded;
  set dateAdded(DateTime dateAdded) => _$this._dateAdded = dateAdded;

  int _likeCount;
  int get likeCount => _$this._likeCount;
  set likeCount(int likeCount) => _$this._likeCount = likeCount;

  bool _liked;
  bool get liked => _$this._liked;
  set liked(bool liked) => _$this._liked = liked;

  bool _favorited;
  bool get favorited => _$this._favorited;
  set favorited(bool favorited) => _$this._favorited = favorited;

  BasicMovieDetailsBuilder _movie;
  BasicMovieDetailsBuilder get movie =>
      _$this._movie ??= new BasicMovieDetailsBuilder();
  set movie(BasicMovieDetailsBuilder movie) => _$this._movie = movie;

  UserBuilder _owner;
  UserBuilder get owner => _$this._owner ??= new UserBuilder();
  set owner(UserBuilder owner) => _$this._owner = owner;

  JokeBuilder();

  JokeBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _title = _$v.title;
      _content = _$v.content;
      _commentCount = _$v.commentCount;
      _jokeType = _$v.jokeType;
      _dateAdded = _$v.dateAdded;
      _likeCount = _$v.likeCount;
      _liked = _$v.liked;
      _favorited = _$v.favorited;
      _movie = _$v.movie?.toBuilder();
      _owner = _$v.owner?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Joke other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Joke;
  }

  @override
  void update(void updates(JokeBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Joke build() {
    _$Joke _$result;
    try {
      _$result = _$v ??
          new _$Joke._(
              id: id,
              title: title,
              content: content,
              commentCount: commentCount,
              jokeType: jokeType,
              dateAdded: dateAdded,
              likeCount: likeCount,
              liked: liked,
              favorited: favorited,
              movie: _movie?.build(),
              owner: _owner?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'movie';
        _movie?.build();
        _$failedField = 'owner';
        _owner?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Joke', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
