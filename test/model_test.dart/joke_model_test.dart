import 'package:flutter_test/flutter_test.dart';
import 'package:sitcom_joke/models/joke.dart';

main() {
  test('Check if two objects with same values are equal', () {
    Joke firstJoke = Joke((d) => d
      ..id = '1'
      ..title = 'title'
      ..content = 'content'
      ..jokeType = JokeType.image
    );
    Joke secondJoke = Joke((d) => d
      ..id = '1'
      ..title = 'title'
      ..content = 'content'
      ..jokeType = JokeType.image
    );
    Joke thirdJoke = Joke((d) => d
      ..id = '1z'
      ..title = 'titlez'
      ..content = 'contentz'
      ..jokeType = JokeType.image

    );
    expect(firstJoke, secondJoke);
    expect(true, firstJoke == secondJoke);
    expect(true, firstJoke != thirdJoke);
  });

  test('Convert json to joke object', () {
    String jokeJson =
        '{ "id" : "id", "title" : "title", "content":"content", "jokeType":"image", "movie" : ' +
            '{ "id": "id", "name":"name", "description":"desc" } }';
    Joke jokeObject = Joke((b) => b
      ..id = 'id'
      ..title = 'title'
      ..content = 'content'
      ..jokeType = JokeType.image
      ..movie.update((b) => b
        ..id = 'id'
        ..name = 'name'
        ..description = 'desc'));

    //timestamp is in milliseconds
    String jokeJson2 =
        '{ "id" : "id", "title" : "title", "content":"content", "jokeType":"image", "dateAdded": "2019-09-27","movie" : ' +
            '{ "id": "id", "name":"name", "description":"desc" } }';
    Joke jokeObject2 = Joke((b) => b
      ..id = 'id'
      ..title = 'title'
      ..content = 'content'
      ..jokeType = JokeType.image
      ..dateAdded = DateTime(2019, 09, 27)
      ..movie.update((b) => b
        ..id = 'id'
        ..name = 'name'
        ..description = 'desc'));

    expect(Joke.fromJson(jokeJson), jokeObject);
    expect(Joke.fromJson(jokeJson2).dateAdded.year, jokeObject2.dateAdded.year);
  });

  test('can deserialize jokeType', (){

    String jokeJson =
        '{ "id" : "id", "title" : "title", "content":"content", "jokeType":"image","movie" : ' +
            '{ "id": "id", "name":"name", "description":"desc" } }';
    Joke jokeObject = Joke((b) => b
      ..id = 'id'
      ..title = 'title'
      ..content = 'content'
      ..jokeType = JokeType.image
      ..movie.update((b) => b
        ..id = 'id'
        ..name = 'name'
        ..description = 'desc'));

    expect(Joke.fromJson(jokeJson).jokeType, jokeObject.jokeType);

  });

  test('Convert from joke object to json', () {
    // String jokeJson = """ 
    //                       {
    //                         "id":"id",
    //                         "title": "title",
    //                         "content": "content"
    //                       }
    //                     """;
    //Joke jokeObject = Joke(id: 'id',title: 'title', content: 'content');
    // expect(jokeObject.toJSon() , jokeJson);
  });
}
