import 'package:flutter/material.dart';

class ProfileInfoContainer extends StatefulWidget {
  final String data, title;
  final Color shadowColor;

  const ProfileInfoContainer({
    super.key,
    required this.data,
    required this.title,
    this.shadowColor = Colors.black,
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
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.secondary,
            blurRadius: 5,
            offset: const Offset(0, 1),
          )
        ],
        shape: BoxShape.rectangle,
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
