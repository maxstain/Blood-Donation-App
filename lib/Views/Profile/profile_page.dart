import 'dart:io';

import 'package:blood_donation/Models/UserData.dart';
import 'package:blood_donation/Services/UserServices.dart';
import 'package:blood_donation/Views/Profile/edit_profile_page.dart';
import 'package:blood_donation/Widgets/profile_info_container.dart';
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
  late UserData _userData = UserData.empty;

  // Variables
  final ImagePicker _picker = ImagePicker();
  late var _isLoading = false;

  @override
  void initState() {
    _userServices.getUserData().then(
          (value) => setState(() {
            _userData = value;
          }),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditProfilePage(),
                ),
              );
            },
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
        actionsIconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Form(
        child: ListView(
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
                                      .then(
                                        (value) => File(
                                          value!.path,
                                        ),
                                      );
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ??
                        'Username',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(FirebaseAuth.instance.currentUser?.email ?? 'Email'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _userData == UserData.empty
                      ? CircularProgressIndicator()
                      : ProfileInfoContainer(
                          data: _userData.bloodType.toString(),
                          title: 'Blood Type',
                          shadowColor: Theme.of(context).colorScheme.secondary,
                        ),
                  _userData == UserData.empty
                      ? CircularProgressIndicator()
                      : ProfileInfoContainer(
                          data: _userData.donated.toString(),
                          title: 'Donated',
                          shadowColor: Theme.of(context).colorScheme.secondary,
                        ),
                  _userData == UserData.empty
                      ? CircularProgressIndicator()
                      : ProfileInfoContainer(
                          data: _userData.received.toString(),
                          title: 'Requested',
                          shadowColor: Theme.of(context).colorScheme.secondary,
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
