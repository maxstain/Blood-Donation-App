import 'package:blood_donation/Shared/shared_data.dart';
import 'package:blood_donation/Views/offer_page.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({Key? key}) : super(key: key);

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          'Offers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return OfferPage(offer: offers[index]);
                    },
                  ),
                );
              },
            );
          }),
    );
  }
}
