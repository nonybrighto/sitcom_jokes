import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/blocs/joke_list_bloc.dart';
import 'package:sitcom_joke/models/general.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/navigation/router.dart';
import 'package:sitcom_joke/ui/pages/auth_page.dart';

class AppDrawer extends StatelessWidget {

  final JokeListBloc imageJokeListBloc;
  final JokeListBloc textJokeListBloc;

  AppDrawer({this.imageJokeListBloc, this.textJokeListBloc});

  @override
  Widget build(BuildContext context) {
  ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
    context = context;
    return Drawer(
      child: ListView(
        children: <Widget>[
            _drawerHeader(applicationBloc),
            _drawerItem(context, Icons.cloud, 'Latest Posts' , countDetails: CountDetails(5, Colors.red), onTap: _handleLatestPostTap),
            _drawerItem(context, Icons.list, 'All Sitcoms' , onTap: _handleAllSitcomsTap(context)),
            _drawerItem(context, Icons.favorite, 'Favorites', onTap: _handleFavoritesTap),
            _drawerItem(context, Icons.favorite, 'Add Joke', onTap: _handleAddJokeTap(context)),
            Divider(color: Colors.grey[200],),
            _drawerItem(context, Icons.favorite, 'Settings', onTap: _handleSettingsTap(context)),
            _drawerItem(context, Icons.favorite, 'Share', onTap: _handleShareTap()),
            _drawerItem(context, Icons.favorite, 'About' , onTap: _handleAboutTap(context)),

        ],
      ),
    );
  }

  _drawerHeader(ApplicationBloc appBloc){

      return Row(children: <Widget>[

          StreamBuilder<User>(
            stream: appBloc.currentUser,
            builder: (BuildContext context, AsyncSnapshot<User> currentUserSnapshot ){

                if(currentUserSnapshot.hasData && currentUserSnapshot.data != null){

                   return _buildUserProfile(currentUserSnapshot.data);
                }else{
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                        _buildAuthNavButton(context, authType: AuthType.login, buttonText: 'Login'),
                        _buildAuthNavButton(context, authType: AuthType.signup, buttonText: 'Sign Up'),
                    ],
                  );
                }
            
            }
          )

      ],);

  }

  _buildUserProfile(User user){

      return Text(user.name);
  }

  _buildAuthNavButton(BuildContext context, {String buttonText, AuthType authType }){

    return FlatButton(child: Text(buttonText), onPressed: (){
        Router.gotoAuthPage(context, authType);
    });
  }

  _handleLatestPostTap(){
    _handleLatestPostForBloc(imageJokeListBloc);
    _handleLatestPostForBloc(textJokeListBloc);

  }

  _handleLatestPostForBloc(JokeListBloc bloc){

    bloc.changeMovie(null);
    bloc.changeSortOrder(SortOrder.desc);
    bloc.getItems();
  }

  _handleAllSitcomsTap(context){
    return (){
      Router.gotoMoviePage(context);
    };
  }

  _handleFavoritesTap(){
    _handleFavoriteForBloc(imageJokeListBloc);
    _handleFavoriteForBloc(textJokeListBloc);
  }

  _handleFavoriteForBloc(JokeListBloc bloc){
    bloc.changeMovie(null);
    bloc.changeFavorites(true);
    bloc.getItems();
  }

  _handleAddJokeTap(context){
    return (){
      Router.gotoAddJokePage(context);
    };
  }

  _handleSettingsTap(context){
        return (){
      Router.gotoSettingsPage(context);
    };
  }

  _handleAboutTap(context){
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