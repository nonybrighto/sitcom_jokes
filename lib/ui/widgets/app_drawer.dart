import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/pages/auth_page.dart';

class AppDrawer extends StatelessWidget {


  AppDrawer();

  @override
  Widget build(BuildContext context) {
  ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    context = context;
    return Drawer(
      child: ListView(
        children: <Widget>[
            Divider(
                height: 1,
                color: Theme.of(context).accentColor,
            ),
            _drawerHeader(applicationBloc),
            _drawerItem(context, Icons.cloud, 'Home' , onTap: _handleHomeTap(context)),
            _drawerItem(context, Icons.list, 'All Sitcoms' , onTap: _handleAllSitcomsTap(context)),
            _drawerItem(context, Icons.favorite, 'Favorites', onTap: _handleFavoritesTap(context)),
            _drawerItem(context, Icons.favorite, 'Add Joke', onTap: _handleAddJokeTap(context)),
            Divider(),
            _drawerItem(context, Icons.favorite, 'Settings', onTap: _handleSettingsTap(context)),
            _drawerItem(context, Icons.favorite, 'Share', onTap: _handleShareTap()),
            _drawerItem(context, Icons.favorite, 'About' , onTap: _handleAboutTap(context)),

        ],
      ),
    );
  }

  _drawerHeader(ApplicationBloc appBloc){

      
          return StreamBuilder<User>(
            stream: appBloc.currentUser,
            builder: (BuildContext context, AsyncSnapshot<User> currentUserSnapshot ){

                if(currentUserSnapshot.hasData && currentUserSnapshot.data != null){

                   return _buildUserProfile(currentUserSnapshot.data, context);
                }else{
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                       _buildAuthNavButton(context, authType: AuthType.login, buttonText: 'Login'),
                        _buildAuthNavButton(context, authType: AuthType.signup, buttonText: 'Sign Up'),

                    ],
                  );
                }
            }
          );

    

  }

  _buildUserProfile(User user, BuildContext context){

    return Container(
      height: 70,
      child: Stack(
        children: <Widget>[
          Row(
                children: <Widget>[
                   _buildProfileDetail(context, title:'Followers', count:10, onPressed: (){
                     print('pressed');
                   }),
                   _buildProfileDetail(context, title:'Following', count:50, onPressed: (){
                     print('pressed');
                   }),
                ],
              ),

              Positioned(
                top: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                                  child: Container(
                    height: 70,
                    width: 70,
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.all(5.0),
                    color: Theme.of(context).accentColor,
                    child: CircleAvatar(
                        radius: 20,
                        child: Text('N'),
                    ),
                  ),
                ),
              )
        ],
      ),
    );
  }

  _buildProfileDetail(BuildContext context, {String title, int count, onPressed}){

        return InkWell(
                  onTap: onPressed,
                  splashColor: Theme.of(context).accentColor,
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12, top:10, bottom: 4),
                  child: Text(title, style: TextStyle(color: Theme.of(context).accentColor),),
                ),
                Text(count.toString(), style: TextStyle(color: Colors.grey[500],)),
                //Text(count.toString()),
              ],
          ),
        );
  }

   _buildAuthNavButton(BuildContext context, {String buttonText, AuthType authType }){

    return FlatButton(
      textColor: Theme.of(context).accentColor,
      child: Text(buttonText), onPressed: (){
        Router.gotoAuthPage(context, authType);
    });
  }

  _handleHomeTap(BuildContext context){
    return (){
      //Router.gotoJokeListPage(context, pageTitle: 'Latest Jokes', fetchType: JokeListFetchType.latestJokes);
      Router.gotoHomePage(context);
    };
  }

  _handleAllSitcomsTap(BuildContext context){
    return (){
      Router.gotoMoviePage(context);
    };
  }

  _handleFavoritesTap(BuildContext context){
    return (){
       Router.gotoJokeListPage(context, pageTitle: 'Favorite Jokes', fetchType: JokeListFetchType.userFavJokes);
    };
  }

  _handleAddJokeTap(BuildContext context){
    return (){
      Router.gotoAddJokePage(context);
    };
  }

  _handleSettingsTap(BuildContext context){
        return (){
      Router.gotoSettingsPage(context);
    };
  }

  _handleAboutTap(BuildContext context){
        return (){
      Router.gotoAboutPage(context);
    };
  }

  _handleShareTap(){ }


  _drawerItem(BuildContext context, IconData icon, String title, {CountDetails countDetails, @required onTap}){

    return  ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: (countDetails != null)? CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('1'),
              radius: 10.0,
            ):null,
            onTap: (onTap != null) ? (){
              Navigator.pop(context);
               onTap();
            }: null,
          );
  }



}

class CountDetails{

  final int count;
  final Color color;

  CountDetails(this.count, this.color);
}