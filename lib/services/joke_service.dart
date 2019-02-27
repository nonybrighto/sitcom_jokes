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

      String content;
      if(jokeType ==JokeType.image){
        content = 'https://images.pexels.com/photos/1151262/pexels-photo-1151262.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
      }else{
        content = 'this is the stupid joke that i just added';
      }

    return [
      Joke((b) => b
        ..id = 'id'
        ..title = 'title1'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title2'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = content
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
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = content
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
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = content
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
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = content
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
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = content
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
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = content
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
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = '-6title'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = '-5title'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = '-4title'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = '-3title'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = '-2title'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = '-1title'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.id='movid'
        ..movie.name='movie name'
        ..movie.description='description'
      ),
      Joke((b) => b
        ..id = 'id'
        ..title = 'title_last'
        ..content = content
        ..likes = 1
        ..dateAdded = DateTime(2003)
        ..jokeType = JokeType.text
        ..movie.update((b) => b..id ='The Id'..name='The name'..description='description')
      ),
    ];
  }
}
