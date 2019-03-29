import 'package:flutter/material.dart';
import 'package:sitcom_joke/blocs/application_bloc.dart';
import 'package:sitcom_joke/blocs/auth_bloc.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sitcom_joke/models/auth.dart';
import 'package:sitcom_joke/models/bloc_delegate.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/auth_service.dart';
import 'package:sitcom_joke/ui/pages/home_page.dart';
import 'package:sitcom_joke/utils/validator.dart';

enum AuthType { login, signup }

class AuthPage extends StatefulWidget {
  final AuthType authType;
  AuthPage(this.authType, {Key key}) : super(key: key);

  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage> implements BlocDelegate<User> {
  Validator validator;
  BuildContext _context;
  final _formKey = GlobalKey<FormState>();
  AuthType authType;
  AuthBloc authBloc;

  TextEditingController _usernameController =
      TextEditingController(text: 'nony');
  TextEditingController _emailController =
      TextEditingController(text: 'example@gmail.com');
  TextEditingController _passwordController =
      TextEditingController(text: 'password');

  @override
  void initState() {
    super.initState();
    validator = Validator();
    authType = widget.authType;
  }

  @override
  Widget build(BuildContext context) {
    authBloc = AuthBloc(authService: AuthService(), delegate: this);
    return Scaffold(
        backgroundColor: const Color(0Xffe6e6e6),
        appBar: AppBar(
          title: Text((authType == AuthType.signup) ? 'Sign up' : 'Login'),
        ),
        body: Builder(
          builder: (context) {
            _context = context;

            return Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        //   child: Image.asset(
                        //     'assets/images/app_logo.jpg',
                        //     fit: BoxFit.fitHeight,
                        //     height: 80.0,
                        //   ),
                        // ),
                        Center(
                          child: Text('Sitcom Jokes'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              _buildAuthForm(),
                              SizedBox(height: 10.0),
                              _footerHorizontalDivider(),
                              _buildSocialButtons(),
                              Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: (authType == AuthType.signup)
                                      ? _buildFootDetail(
                                          infoText:
                                              'By Signing up, you agree to our',
                                          buttonText: 'Terms and Conditions',
                                          onPressed: () {})
                                      : _buildFootDetail(
                                          infoText: 'Don\'t have an account?',
                                          buttonText: 'Sign up',
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AuthPage(
                                                            AuthType.signup)));
                                          }))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  _buildAuthForm() {
    return Column(
      children: <Widget>[
        (authType == AuthType.signup)
            ? 
            _authFormTextField(hintText: 'Username', controller: _usernameController, validator: validator.usernameValidator)
            : Container(),
        (authType == AuthType.signup)
            ? SizedBox(height: 10.0)
            : Container(),
            _authFormTextField(hintText: 'Email', controller: _emailController, validator: validator.emailValidator),
        SizedBox(height: 10.0),
        _authFormTextField(hintText: 'Password', controller: _passwordController, validator: validator.passwordValidator, obscureText: true),
        SizedBox(height: 10.0),
        _buildAuthButton(),
      ],
    );
  }

  _authFormTextField(
      {TextEditingController controller,
      String hintText,
      Function(String) validator,
      bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintText: hintText),
      validator: validator,
    );
  }

  _buildAuthButton() {
    return StreamBuilder<LoadState>(
        initialData: Loaded(),
        stream: authBloc.loadState,
        builder: (context, AsyncSnapshot<LoadState> loadStateSnapShot) {
          LoadState loadState =loadStateSnapShot.data;
          return  SizedBox(
            width: double.infinity,
            child: RaisedButton(
              color: const Color(0Xfffe0e4f),
              child: (_canClickAuthButton(loadState))
                  ? Text(
                      (authType == AuthType.signup) ? 'SIGN UP' : 'LOGIN',
                      style: TextStyle(color: Colors.white),
                    )
                  : CircularProgressIndicator(
                      backgroundColor: const Color(0Xfffe0e4f),
                    ),
              onPressed: (_canClickAuthButton(loadState))
                  ? () {
                      if (_formKey.currentState.validate()) {
                        if (authType == AuthType.signup) {
                          authBloc.signUp(_usernameController.text,
                              _emailController.text, _passwordController.text);
                        } else {
                          authBloc.login(
                              _emailController.text, _passwordController.text);
                        }
                      }
                    }
                  : null,
            ),
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
                color: Colors.red,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              color: const Color(0Xffe6e6e6),
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
          LoadState loadState =loadStateSnapShot.data;
          bool buttonClickable = _canClickAuthButton(loadState);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _socialButton(
                  icon: Icons.ac_unit,
                  clickable: buttonClickable,
                  onTapCall: () {
                    authBloc.loginWithSocial(SocialLoginType.facebook);
                  }),
              SizedBox(width: 20.0),
              _socialButton(
                  icon: Icons.ac_unit,
                  clickable: buttonClickable,
                  onTapCall: () {
                    authBloc.loginWithSocial(SocialLoginType.google);
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

  @override
  success(User user) {
    BlocProvider.of<ApplicationBloc>(context).changeCurrentUser(user);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  error(String errorMessage) {
    Scaffold.of(_context).showSnackBar(SnackBar(
      content: Text('Error: ' + errorMessage),
    ));
  }
}

_canClickAuthButton(LoadState loadState) {
  return loadState is Loaded;
}
