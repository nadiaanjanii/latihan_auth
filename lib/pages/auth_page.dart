import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
// import './home_page.dart';
import '../providers/auth.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);

  get onConfirmSignup => null;

  Future<String?> _authUserSigUp(SignupData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then(
      (_) async {
        try {
          //benerin error The argument type 'String?' can't be assigned to the parameter type 'String'
          //yang seharusnya kurang nambahin tanda "!"
          await Provider.of<AuthProvider>(context, listen: false)
              .signup(data.name!, data.password!);
        } catch (err) {
          print(err);
          return err.toString();
        }

        return "";
      },
    );
  }

  Future<String?> _authUserLogin(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then(
      (_) async {
        try {
          //benerin error The argument type 'String?' can't be assigned to the parameter type 'String'
          //yang seharusnya kurang nambahin tanda "!"
          await Provider.of<AuthProvider>(context, listen: false)
              .login(data.name!, data.password!);
        } catch (err) {
          print(err);
          return err.toString();
        }

        return "";
      },
    );
  }

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'LOGIN',
      onLogin: _authUserLogin,
      onSignup: _authUserSigUp,
      onSubmitAnimationCompleted: () {
        Provider.of<AuthProvider>(context, listen: false).temDate();
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => HomePage(),
        // ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
