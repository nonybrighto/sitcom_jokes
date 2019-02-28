import 'package:test/test.dart';

void main(){


  test('check if two date objects with same values are equal', (){


    expect(DateTime(2000), DateTime(2000));
    expect(true,DateTime(2001, 10) == DateTime(2001,10));
    expect(true,DateTime(2001, 11) != DateTime(2001,10));

  });

  test('check if two list objects with same values are equal', (){


    expect([], []);
    expect([DateTime(2000)], [DateTime(2000)]);
//    expect(true,DateTime(2001, 10) == DateTime(2001,10));
//    expect(true,DateTime(2001, 11) != DateTime(2001,10));

  });
}