import 'package:book_track_app/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'create_account_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreateAccountClicked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: HexColor('#b9c2d1'),
                )),
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: isCreateAccountClicked != true
                      ? LoginForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController)
                      : CreateAccountForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController),
                ),
                TextButton.icon(
                  icon: Icon(Icons.portrait_rounded),
                  label: Text(isCreateAccountClicked
                      ? 'Aleready have an account?'
                      : 'Create Account'),
                  onPressed: () {
                    setState(() {
                      if (!isCreateAccountClicked) {
                        isCreateAccountClicked = true;
                      } else {
                        isCreateAccountClicked = false;
                      }
                    });
                  },
                  style: TextButton.styleFrom(
                      primary: HexColor('#fd5b28'),
                      textStyle:
                          TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                )
              ],
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: HexColor('#b9c2d1'),
                )),
          ],
        ),
      ),
    );
  }
}
