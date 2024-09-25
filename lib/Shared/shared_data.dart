import 'package:blood_donation/Models/Offer.dart';
import 'package:blood_donation/Shared/shared_types.dart';

List<Offer> offers = [
  Offer(
    id: '1',
    name: 'John Doe',
    description: 'Blood Type: A+',
    image: 'assets/images/blood_donation.jpeg',
    bloodType: BloodTypes.Apos,
  ),
  Offer(
    id: '2',
    name: 'Jane Doe',
    description: 'Blood Type: B+',
    image: 'assets/images/blood_donation.jpeg',
    bloodType: BloodTypes.Bpos,
  ),
  Offer(
    id: '3',
    name: 'John Smith',
    description: 'Blood Type: O+',
    image: 'assets/images/blood_donation.jpeg',
    bloodType: BloodTypes.Opos,
  ),
];
