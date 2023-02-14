import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  // text editing controllers
  var isLogin = true;
  var _formKey = GlobalKey<FormState>();
  var _email = "";
  var _username = "";
  var _password = "";
  Future<void> submitFunc() async {
    final valid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    UserCredential result;
    if (valid) {
      _formKey.currentState!.save();
      if (isLogin)
        result = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      else
        result = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            key: ValueKey('email'),
                            onSaved: (value) {
                              _email = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return "Enter the valid email Address";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                InputDecoration(labelText: 'Email Address'),
                          ),
                        ),
                        // username textfield

                        const SizedBox(height: 10),
                        if (!isLogin)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                              key: ValueKey('username'),
                              onSaved: (value) {
                                _username = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty || value.length < 4) {
                                  return "Enter the valid username greater than 4";
                                }
                                return null;
                              },
                              decoration:
                                  InputDecoration(labelText: 'UserName'),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: TextFormField(
                            key: ValueKey('password'),
                            onSaved: (value) {
                              _password = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return "Enter the valid password greater than 7 characters";
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                          ),
                        ),

                        const SizedBox(height: 10),
                      ],
                    )),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin
                        ? "Create new account"
                        : "I already have an Account")),

                const SizedBox(height: 15),

                // sign in button
                MyButton(
                  login: isLogin,
                  onTap: submitFunc,
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
