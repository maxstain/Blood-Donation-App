import 'package:blood_donation/Models/Offer.dart';
import 'package:flutter/material.dart';

class RequestCard extends StatefulWidget {
  final Offer offer;

  const RequestCard({super.key, required this.offer});

  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.black,
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            Image.asset(widget.offer.image),
            Text(
              widget.offer.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
