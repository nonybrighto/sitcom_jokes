import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/auth.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/ui/pages/home_page.dart';
import 'package:sitcom_joke/ui/widgets/buttons/general_buttons.dart';
import 'package:sitcom_joke/ui/widgets/clips/login_bottom_clipper.dart';
import 'package:sitcom_joke/ui/widgets/clips/login_top_clipper.dart';
import 'package:sitcom_joke/utils/validator.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';


enum AuthType { login, signup }

class AuthPage extends StatefulWidget {
  final AuthType authType;
  AuthPage(this.authType, {Key key}) : super(key: key);

  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage>{
  Validator validator;
  BuildContext _context;
  final _formKey = GlobalKey<FormState>();
  AuthType authType;
  AuthBloc authBloc;

  TextEditingController _usernameController =
      TextEditingController(text: 'larry');
  TextEditingController _emailController =
      TextEditingController(text: 'larry@gmail.com');
  TextEditingController _passwordController =
      TextEditingController(text: 'tested69#');

  @override
  void initState() {
    super.initState();
    validator = Validator();
    authType = widget.authType;
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        title: Text((authType == AuthType.signup) ? 'Sign up' : 'Login'),
      ),
      body: Builder(
        builder: (context) {
          _context = context;

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildHeader(),
                _buildAuthForm(),
                _footerHorizontalDivider(),
                _buildSocialButtons(),
                _buildFooter(authType)
              ],
            ),
          );
        },
      ),
    );
  }

  _buildHeader(){
    return Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: LoginBottomClipper(),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            //decoration: BoxDecoration(color: Color(0Xc0fc6b00)),
                            color: Colors.white24,
                            height: 300,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Color(0Xc0fc6b00)),
                            height: 300,
                          )
                        ],
                      ),
                    ),
                    ClipPath(
                      clipper: LoginTopClipper(),
                      child: Container(
                        height: 260,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color(0Xfffa7c05),
                              Color(0Xffee3e00)
                            ])),
                      ),
                    ),
                  ],
                );
  }

  _buildFooter(AuthType authType) {
    if (authType == AuthType.signup) {
      return _buildFootDetail(
          infoText: 'By Signing up, you agree to our',
          buttonText: 'Terms and Conditions',
          onPressed: () {});
    } else {
      return _buildFootDetail(
          infoText: 'Don\'t have an account?',
          buttonText: 'Sign up',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AuthPage(AuthType.signup)));
          });
    }
  }

  _buildAuthForm() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
            key: _formKey,
              child: Column(
          children: <Widget>[
            (authType == AuthType.signup)
                ? _authFormTextField(
                    hintText: 'Username',
                    controller: _usernameController,
                    icon: Icons.verified_user,
                    validator: validator.usernameValidator)
                : Container(),
            (authType == AuthType.signup) ? SizedBox(height: 10.0) : Container(),
            _authFormTextField(
                hintText: 'Email',
                controller: _emailController,
                icon: Icons.verified_user,
                validator: validator.emailValidator),
            SizedBox(height: 10.0),
            _authFormTextField(
                hintText: 'Password',
                controller: _passwordController,
                icon: Icons.verified_user,
                validator: validator.passwordValidator,
                obscureText: true),
            SizedBox(height: 10.0),
            _buildAuthButton(),
          ],
        ),
      ),
    );
  }

  _authFormTextField(
      {TextEditingController controller,
      String hintText,
      Function(String) validator,
      IconData icon,
      bool obscureText = false}) {

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(icon: Icon(icon), hintText: hintText),
    );
  }

  _buildAuthButton() {
    return StreamBuilder<LoadState>(
        initialData: Loaded(),
        stream: authBloc.loadState,
        builder: (context, AsyncSnapshot<LoadState> loadStateSnapShot) {
          LoadState loadState = loadStateSnapShot.data;
          return RoundedButton(
            child:  (_canClickAuthButton(loadState))
                  ? Text(
                      (authType == AuthType.signup) ? 'SIGN UP' : 'LOGIN',
                      style: TextStyle(color: Colors.white),
                    )
                  : CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
            onPressed: (_canClickAuthButton(loadState))
                  ? () {
                      if (_formKey.currentState.validate()) {
                        if (authType == AuthType.signup) {
                          authBloc.signUp(_usernameController.text,
                              _emailController.text, _passwordController.text, _authCallBack);
                        } else {
                          authBloc.login(
                              _emailController.text, _passwordController.text, _authCallBack);
                        }
                      }
                    }
                  : null,
                  
          );
        });
  }

  _footerHorizontalDivider() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0.0,
          left: 0.0,
          bottom: 0.0,
          top: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Text('OR'),
            )
          ],
        )
      ],
    );
  }

  _buildFootDetail({String infoText, String buttonText, Function() onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(infoText),
        FlatButton(
            child: Text(
              buttonText,
              style: TextStyle(color: const Color(0Xfffe0e4f)),
            ),
            onPressed: onPressed)
      ],
    );
  }

  _buildSocialButtons() {
    return StreamBuilder(
        initialData: Loaded(),
        stream: authBloc.loadState,
        builder: (context, loadStateSnapShot) {
          LoadState loadState = loadStateSnapShot.data;
          bool buttonClickable = _canClickAuthButton(loadState);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _socialButton(
                  icon: Icons.ac_unit,
                  clickable: buttonClickable,
                  onTapCall: () {
                    authBloc.loginWithSocial(SocialLoginType.facebook, _authCallBack);
                  }),
              SizedBox(width: 20.0),
              _socialButton(
                  icon: Icons.ac_unit,
                  clickable: buttonClickable,
                  onTapCall: () {
                    authBloc.loginWithSocial(SocialLoginType.google, _authCallBack);
                  }),
            ],
          );
        });
  }

  _socialButton({IconData icon, bool clickable, Function() onTapCall}) {
    return InkWell(
      child: CircleAvatar(
        //child: Icon(FontAwesomeIcons.facebookF),
        child: Icon(icon),
      ),
      onTap: clickable ? onTapCall : null,
    );
  }

  _authCallBack(bool didLogin, String errorMessage){

        if(didLogin){
            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        }else{
             Scaffold.of(_context).showSnackBar(SnackBar(
              content: Text('Error: ' + errorMessage),
            ));
        }
  }

_canClickAuthButton(LoadState loadState) {
  return !(loadState is Loading);
}

}


