import '../models/address.dart';

final List<Address> kInitialAddresses = [
  const Address(
    id: 'a1',
    label: 'Home',
    line1: '221B Baker Street',
    line2: 'Marylebone, London',
    isDefault: true,
  ),
  const Address(
    id: 'a2',
    label: 'Work',
    line1: '10 Canary Wharf',
    line2: 'Floor 14, London',
  ),
];
