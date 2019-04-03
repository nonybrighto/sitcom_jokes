import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sitcom_joke/blocs/bloc_provider.dart';
import 'package:sitcom_joke/models/auth.dart';
import 'package:sitcom_joke/models/bloc_delegate.dart';
import 'package:sitcom_joke/models/load_state.dart';
import 'package:sitcom_joke/models/user.dart';
import 'package:sitcom_joke/services/auth_service.dart';

class AuthBloc extends BlocBase {
  BlocDelegate<User> delegate;
  AuthService authService;

  final _currentUserController = BehaviorSubject<User>();
  final _loadStateController = BehaviorSubject<LoadState>();
  final _socialLoginController = StreamController<SocialLoginType>();
  final _signUpController = StreamController<Map>();
  final _loginController = StreamController<Map>();

  Function(SocialLoginType) get loginWithSocial =>
      (socialLoginType) => _socialLoginController.sink.add(socialLoginType);
  Function(String, String, String) get signUp =>
      (username, email, password) => _signUpController.sink
          .add({'username': username, 'email': email, 'password': password});
  Function(String, String) get login => (email, password) =>
      _loginController.sink.add({'email': email, 'password': password});

  Stream<LoadState> get loadState => _loadStateController.stream;


  AuthBloc({this.authService, this.delegate}) {
      _loadStateController.sink.add(Loaded());
      
      _socialLoginController.stream.listen(_handleSocialLogin);
      _loginController.stream.listen(_handleLogin);
      _signUpController.stream.listen(_handleSignUp);
  }

  _handleSignUp(Map signUpCredential) async {
    _startAuthProcess(() {
      return authService.signUpWithEmailAndPassword(
          signUpCredential['username'],
          signUpCredential['email'],
          signUpCredential['password']);
    });
  }

  _handleLogin(Map loginCredential) async {
    _startAuthProcess(() {
      return authService.signInWithEmailAndPassword(
          loginCredential['email'], loginCredential['password']);
    });
  }

  _handleSocialLogin(SocialLoginType socialLoginType) async {
    if (socialLoginType == SocialLoginType.facebook) {
      _startAuthProcess(() {
        return authService.authenticateWithFaceBook();
      });
    } else if (socialLoginType == SocialLoginType.google) {
      _startAuthProcess(() {
        return authService.authenticateWithGoogle();
      });
    }
  }

  _startAuthProcess(Future<User> Function() authResult) async {
    _loadStateController.sink.add(Loading());
    try {
      User user = await authResult();
      _loadStateController.sink.add(Loaded());
      delegate.success(user);
    } catch (appError) {
      String errorMessage = appError.toString();
      _loadStateController.sink.add(LoadError(errorMessage));
      delegate.error(errorMessage);
    }
  }

  @override
  void dispose() {
    _currentUserController.close();
    _socialLoginController.close();
    _loadStateController.close();
    _signUpController.close();
    _loginController.close();
  }
}
