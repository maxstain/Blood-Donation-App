import 'package:blood_donation/Shared/shared_data.dart';
import 'package:blood_donation/Views/offer_page.dart';
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
      ),
      body: Column(
        children: [
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
          SizedBox(
            height: 120,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: offers.length,
              itemBuilder: (BuildContext context, int index) {
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
              },
            ),
          ),
          const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                "Footer",
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
                ListTile(
                  title: const Text("Item 1"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Item 2"),
                  onTap: () {},
                ),
                ListTile(
                  title: const Text("Item 3"),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
