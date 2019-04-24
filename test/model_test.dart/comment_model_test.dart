import 'package:test/test.dart';
import 'package:sitcom_joke/models/comment.dart';

void main() {
  test('Check if two comments are equal', () {
    Comment comment1 = Comment((u) => u
      ..id = '1'
      ..content='content'
      ..dateAdded =DateTime(2000, 11, 22)
      ..owner.update((u) => u
          ..id = '1'
          ..username = 'John'
          ..photoUrl = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22)
      );
    
    Comment comment2 = Comment((u) => u
      ..id = '1'
      ..content='content'
      ..dateAdded =DateTime(2000, 11, 22)
      ..owner.update((u) => u
          ..id = '1'
          ..username = 'John'
          ..photoUrl = 'the_url'
          ..jokeCount = 10
          ..followed =false
          ..following =true
          ..followerCount = 25
          ..followingCount = 22)
      );
    

    expect(comment1, comment2);
  });

  test('Convert json to Comment object', () {
    
        String commentJsonString = """ {
          "id": "1", "content":"Content", "dateAdded":"2000-11-22", "owner":{"id":"1", "name":"John","photoUrl":"the_url"}
        } """;

        Comment commentObject = Comment((u) => u
            ..id = '1'
            ..content='content'
            ..dateAdded =DateTime(2000, 11, 22).toUtc()
            ..owner.update((u) => u
                ..id = '1'
                ..username = 'John'
                ..photoUrl = 'the_url'
                ..jokeCount = 10
                ..followed =false
                ..following =true
                ..followerCount = 25
                ..followingCount = 22)
            );
    
        
        expect(Comment.fromJson(commentJsonString).id, commentObject.id);
        expect(Comment.fromJson(commentJsonString).owner.id, commentObject.owner.id);
  }); 
}
