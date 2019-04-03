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
          ..profileIconUrl = 'the_url')
      );
    
    Comment comment2 = Comment((u) => u
      ..id = '1'
      ..content='content'
      ..dateAdded =DateTime(2000, 11, 22)
      ..owner.update((u) => u
          ..id = '1'
          ..username = 'John'
          ..profileIconUrl = 'the_url')
      );
    

    expect(comment1, comment2);
  });

  test('Convert json to Comment object', () {
    
        String commentJsonString = """ {
          "id": "1", "content":"Content", "dateAdded":"2000-11-22", "owner":{"id":"1", "name":"John","profileIconUrl":"the_url"}
        } """;

        Comment commentObject = Comment((u) => u
            ..id = '1'
            ..content='content'
            ..dateAdded =DateTime(2000, 11, 22).toUtc()
            ..owner.update((u) => u
                ..id = '1'
                ..username = 'John'
                ..profileIconUrl = 'the_url')
            );
    
        
        expect(Comment.fromJson(commentJsonString).id, commentObject.id);
        expect(Comment.fromJson(commentJsonString).owner.id, commentObject.owner.id);
  }); 
}
