import 'package:flutter/material.dart';
import 'package:sitcom_joke/navigation/router.dart';

class AppDrawer extends StatelessWidget {

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Drawer(
      child: ListView(
        children: <Widget>[
            _drawerItem(Icons.cloud, 'Latest Posts' , countDetails: CountDetails(5, Colors.red), onTap: _handleLatestPostTap),
            _drawerItem(Icons.list, 'All Sitcoms' , onTap: _handleAllSitcomsTap(context)),
            _drawerItem(Icons.favorite, 'Favorites', onTap: _handleFavoritesTap),
            _drawerItem(Icons.favorite, 'Add Joke', onTap: _handleAddJokeTap(context)),
            Divider(color: Colors.grey[200],),
            _drawerItem(Icons.favorite, 'Settings', onTap: _handleSettingsTap(context)),
            _drawerItem(Icons.favorite, 'Share', onTap: _handleShareTap()),
            _drawerItem(Icons.favorite, 'About' , onTap: _handleAboutTap(context)),

        ],
      ),
    );
  }

  _handleLatestPostTap(){
    //TODO: change movie to be displayed
  }

  _handleAllSitcomsTap(context){
    return (){
      Router.gotoMoviePage(context);
    };
  }

  _handleFavoritesTap(){
    //TODO: fav
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

  _handleShareTap(){
     //TODO: share
  }


  _drawerItem(IconData icon, String title, {CountDetails countDetails, @required onTap}){

    return  ListTile(
            leading: Icon(icon),
            title: Text(title),
            trailing: (countDetails != null)? CircleAvatar(
              backgroundColor: Colors.red,
              child: Text('1'),
              radius: 10.0,
            ):null,
            onTap: (onTap != null) ? (){
              Navigator.pop(_context);
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