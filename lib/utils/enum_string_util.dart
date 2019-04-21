import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/joke.dart';

class EnumStringUtil{

    String sortOrderToString(SortOrder sortOrder){
      return sortOrder.toString().split('.')[1];
    }

    String jokeSortPropertyToString(JokeSortProperty jokeSortProperty){
      return jokeSortProperty.toString().split('.')[1];
    }    
}