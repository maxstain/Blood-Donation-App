import 'package:blood_donation/Services/AuthenticationServices.dart';
import 'package:blood_donation/Views/Authentication/login_page.dart';
import 'package:blood_donation/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();

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
                top: 30.0,
                bottom: 40.0,
              ),
              child: Center(
                child: Text(
                  'Register',
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
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  icon: Icon(
                    Icons.person,
                    color: selectedColor,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid username';
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
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(
                    Icons.key,
                    color: selectedColor,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
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
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  icon: Icon(
                    Icons.key,
                    color: selectedColor,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
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
                controller: bloodTypeController,
                decoration: InputDecoration(
                  labelText: 'Blood type',
                  icon: Icon(
                    Icons.bloodtype,
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
                        passwordController.text != '' &&
                        confirmPasswordController.text != '') {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        await AuthenticationServices()
                            .registerWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                          usernameController.text,
                          bloodTypeController.text,
                        );
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const Wrapper(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(msg: "Passwords do not match");
                      }
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
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}