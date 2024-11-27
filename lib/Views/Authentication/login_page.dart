import 'package:blood_donation/Services/AuthenticationServices.dart';
import 'package:blood_donation/Views/Authentication/register_page.dart';
import 'package:blood_donation/Views/Splash/spalsh_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            Padding(
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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 8.0,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
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
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 2.0,
                horizontal: 8.0,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
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
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (emailController.text != '' &&
                        passwordController.text != '') {
                      await AuthenticationServices().signInWithEmailAndPassword(
                          emailController.text, passwordController.text);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const Wrapper(),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Please fill all fields");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
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
