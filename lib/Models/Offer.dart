import 'package:blood_donation/Shared/shared_types.dart';

class Offer {
  String id;
  String name;
  String description;
  String image;
  BloodTypes bloodType;
  UserTypes userType = UserTypes.donor;
  DonationStatus donationStatus = DonationStatus.pending;

  Offer({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.bloodType,
    required this.userType,
    required this.donationStatus,
  });
}
