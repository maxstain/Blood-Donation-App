import 'package:blood_donation/Shared/shared_types.dart';

class Offer {
  late String id;
  late String name;
  late String description;
  late String image;
  late String bloodType;
  late UserTypes userType = UserTypes.donor;
  late DonationStatus donationStatus = DonationStatus.pending;

  Offer({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.bloodType,
    required this.userType,
    required this.donationStatus,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    bloodType = json['bloodType'];
    userType =
        json['userType'] == 'donor' ? UserTypes.donor : UserTypes.recipient;
    donationStatus = json['donationStatus'] == 'pending'
        ? DonationStatus.pending
        : json['donationStatus'] == 'accepted'
            ? DonationStatus.accepted
            : DonationStatus.rejected;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['bloodType'] = bloodType;
    data['userType'] = userType == UserTypes.donor ? 'donor' : 'recipient';
    data['donationStatus'] = donationStatus == DonationStatus.pending
        ? 'pending'
        : donationStatus == DonationStatus.accepted
            ? 'accepted'
            : 'rejected';
    return data;
  }

  @override
  String toString() {
    return 'Offer{id: $id, name: $name, description: $description, image: $image, bloodType: $bloodType, userType: $userType, donationStatus: $donationStatus}';
  }
}
