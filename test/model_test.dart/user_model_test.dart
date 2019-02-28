import 'package:test/test.dart';
import 'package:sitcom_joke/models/user.dart';

void main() {
  test('Check if two users are equal', () {
    User user1 = User((u) => u
      ..id = '1'
      ..name = 'John'
      ..profileIconUrl = 'the_url');
    User user2 = User((u) => u
      ..id = '1'
      ..name = 'John'
      ..profileIconUrl = 'the_url');

    expect(user1, user2);
  });

  test('Convert json to user object', () {
    
        String userJsonString = """ {
          "id": "1", "name":"John", "profileIconUrl":"the_url"
        } """;

        User userObject = User((u) => u
          ..id = '1'
          ..name = 'John'
          ..profileIconUrl = 'the_url');
        
        expect(User.fromJson(userJsonString), userObject);
  }); 
}
