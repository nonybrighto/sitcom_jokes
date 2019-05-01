import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/constants/constants.dart';

class ApplicationService{


  Future<AppThemeType> getDefaultThemeType() async{
    
       SharedPreferences pref = await SharedPreferences.getInstance();
       String themeTypeString = pref.getString(kAppThemeTypePrefKey);
       if(themeTypeString == kAppThemeLight){
         return AppThemeType.light;
       }
       return AppThemeType.dark;
  }

  setDefaultThemeType(AppThemeType themeType) async{

      SharedPreferences pref = await SharedPreferences.getInstance();
      if(themeType == AppThemeType.light){
        await pref.setString(kAppThemeTypePrefKey, kAppThemeLight);
      }else{
        await pref.setString(kAppThemeTypePrefKey, kAppThemeDark);
      }

  }
}