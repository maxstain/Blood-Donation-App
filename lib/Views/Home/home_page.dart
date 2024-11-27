import 'package:blood_donation/Services/AuthenticationServices.dart';
import 'package:blood_donation/Shared/shared_data.dart';
import 'package:blood_donation/Shared/shared_types.dart';
import 'package:blood_donation/Views/Offers/offer_page.dart';
import 'package:blood_donation/Views/Offers/offers_page.dart';
import 'package:blood_donation/Views/Profile/profile_page.dart';
import 'package:blood_donation/Views/Splash/spalsh_page.dart';
import 'package:blood_donation/Widgets/bottom_sheet_widget.dart';
import 'package:blood_donation/Widgets/request_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                title: const Text('Add Offer'),
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const OffersPage(),
                        ),
                      );
                    },
                    child: const Text('Add Offer'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text('Add Request'),
                            children: [
                              SimpleDialogOption(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const OffersPage(),
                                    ),
                                  );
                                },
                                child: const Text('Add Request'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Add Request'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                image: DecorationImage(
                  image: NetworkImage(
                    FirebaseAuth.instance.currentUser?.photoURL ??
                        'https://st3.depositphotos.com/6672868/13801/v/450/depositphotos_138013506-stock-illustration-user-profile-group.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.displayName ?? "User",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Offers'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const OffersPage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 100,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {
                      await AuthenticationServices().signOut();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const SplashPage(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                "Urgent Requests",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 210.0,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              itemBuilder: (BuildContext context, int index) {
                if (offers[index].donationStatus == DonationStatus.pending) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              OfferPage(offer: offers[index]),
                        ),
                      );
                    },
                    child: RequestCard(
                      offer: offers[index],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                "Offers",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: offers.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: const Icon(
                    Icons.bloodtype,
                    color: Colors.red,
                  ),
                  title: Text(offers[index].name),
                  subtitle: Text(offers[index].description),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetWidget(offer: offers[index]);
                      },
                      backgroundColor: Colors.white,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
