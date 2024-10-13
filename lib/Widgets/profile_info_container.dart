import 'package:flutter/material.dart';

class ProfileInfoContainer extends StatefulWidget {
  final String data, title;

  const ProfileInfoContainer({
    super.key,
    required this.data,
    required this.title,
  });

  @override
  State<StatefulWidget> createState() => _ProfileInfoContinerState();
}

class _ProfileInfoContinerState extends State<ProfileInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.data,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
