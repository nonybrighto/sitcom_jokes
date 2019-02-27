import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';
import 'package:sitcom_joke/models/movie.dart';
import 'package:sitcom_joke/constants/constants.dart';

class JokeService {
  final String jokeUrl = kAppApihost + '/jokes/';

  Future<List<Joke>> getJokes(
      {bool favorite,
      JokeType jokeType,
      SortOrder sortOrder,
      JokeSortProperty jokeSortProperty,
      Movie movie,
      int page}) async {


      await Future.delayed(Duration(seconds: 4));

    return [
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = 'content'
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
    ];
  }
}
