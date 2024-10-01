import 'package:blood_donation/Services/AuthenticationServices.dart';
import 'package:blood_donation/Views/Home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Colors.black;
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 150.0,
                bottom: 40.0,
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  icon: Icon(
                    Icons.email,
                    color: selectedColor,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                onTap: () {
                  setState(() {
                    selectedColor = Colors.red;
                  });
                },
                onTapOutside: (PointerDownEvent event) {
                  setState(() {
                    selectedColor = Colors.black;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(
                    Icons.key,
                    color: selectedColor,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedColor = Colors.red;
                  });
                },
                onTapOutside: (PointerDownEvent event) {
                  setState(() {
                    selectedColor = Colors.black;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (emailController.text != '' &&
                        passwordController.text != '') {
                      UserCredential user = await AuthenticationServices()
                          .signInWithEmailAndPassword(
                              emailController.text, passwordController.text);
                      if (user != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Please fill all fields");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 150.0,
                  ),
                ),
                child: const Text('Login'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
