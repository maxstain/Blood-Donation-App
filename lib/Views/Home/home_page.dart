import 'package:blood_donation/Shared/shared_data.dart';
import 'package:blood_donation/Shared/shared_types.dart';
import 'package:blood_donation/Views/Authentication/authentication.dart';
import 'package:blood_donation/Views/Offers/offer_page.dart';
import 'package:blood_donation/Views/Offers/offers_page.dart';
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          'Blood Donation',
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
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  'Blood Donation',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Offers'),
              onTap: () {
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
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    color: Colors.red,
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Authentication(),
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
            height: 120,
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
                    child: Card(
                      surfaceTintColor: Colors.red,
                      child: SizedBox(
                        width: 300,
                        child: Center(
                          child: Text(offers[index].name),
                        ),
                      ),
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
          SingleChildScrollView(
            child: Column(
              children: [
                for (var offer in offers)
                  ListTile(
                    title: Text(offer.name),
                    subtitle: Text(offer.description),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              OfferPage(offer: offer),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
