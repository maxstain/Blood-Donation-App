import 'dart:io';

import 'package:blood_donation/Services/UserServices.dart';
import 'package:blood_donation/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Services
  final Userservices _userServices = Userservices();

  // Variables
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
        ),
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser?.photoURL ??
                        'https://st3.depositphotos.com/6672868/13801/v/450/depositphotos_138013506-stock-illustration-user-profile-group.jpg',
                  ),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            actionsAlignment: MainAxisAlignment.center,
                            title: const Text('Update Profile Picture'),
                            content: _isLoading == true
                                ? CircularProgressIndicator()
                                : Container(),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final File? image = await _picker
                                      .pickImage(
                                        source: ImageSource.camera,
                                      )
                                      .then((value) => File(value!.path));
                                  await _userServices.updatePhotoURL(
                                    image!,
                                  );
                                  setState(() {
                                    _isLoading = false;
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Text('Camera'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final File? image = await _picker
                                      .pickImage(
                                        source: ImageSource.gallery,
                                      )
                                      .then((value) => File(value!.path));
                                  await _userServices.updatePhotoURL(
                                    image!,
                                  );
                                  setState(() {
                                    _isLoading = false;
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: const Text('Gallery'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                    ),
                    color: Colors.white,
                    alignment: Alignment.center,
                    style: ButtonStyle(
                      iconSize: WidgetStateProperty.all(50),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                FirebaseAuth.instance.currentUser?.displayName ?? 'Username',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Email:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${FirebaseAuth.instance.currentUser?.email}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Update Email'),
                              content: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter new email',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await _userServices.updateEmail(
                                      _emailController.text,
                                    );
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      alignment: Alignment.center,
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Username:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        FirebaseAuth.instance.currentUser?.displayName ??
                            'Username',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Update Username'),
                              content: TextField(
                                controller: _usernameController,
                                decoration: const InputDecoration(
                                  hintText: 'Enter new username',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await _userServices.updateDisplayName(
                                      _usernameController.text,
                                    );
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const Text('Update'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                      color: Theme.of(context).colorScheme.primary,
                      alignment: Alignment.center,
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: TextButton(
                onPressed: () async {
                  await _userServices.deleteUser();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Wrapper(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.error,
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  fixedSize: WidgetStateProperty.all(
                    Size(MediaQuery.sizeOf(context).width - 8.0, 50),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
