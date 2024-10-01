import 'package:blood_donation/Models/Offer.dart';
import 'package:blood_donation/Shared/shared_data.dart';
import 'package:blood_donation/Views/Offers/offer_page.dart';
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Offer> searchResults = [];
  List<Offer> shownOffers = offers;

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: SearchBar(
              hintText: "Search for offers",
              controller: _searchController,
              onChanged: (String value) {
                searchResults.clear();
                if (value.isNotEmpty) {
                  for (Offer offer in offers) {
                    if (offer.name
                        .toLowerCase()
                        .contains(value.toLowerCase())) {
                      setState(() {
                        searchResults.add(offer);
                        offers = searchResults;
                      });
                    }
                  }
                } else {
                  setState(() {
                    searchResults.addAll(shownOffers);
                  });
                }
              },
            ),
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
      body: ListView.builder(
          itemCount: shownOffers.length,
          itemBuilder: (BuildContext context, int index) {
            if (shownOffers.isEmpty) {
              return const Center(
                child: Text('No offers available'),
              );
            } else {
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
            }
          }),
    );
  }
}
