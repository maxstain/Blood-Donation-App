import 'package:blood_donation/Shared/shared_types.dart';

class Offer {
  String id;
  String name;
  String description;
  String image;
  BloodTypes bloodType;

  Offer({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.bloodType,
  });
}
