import '../models/payment_method.dart';

final List<PaymentCard> kInitialCards = [
  const PaymentCard(
    id: 'c1',
    brand: CardBrand.visa,
    last4: '4417',
    holderName: 'Alex Rivera',
    isDefault: true,
  ),
  const PaymentCard(
    id: 'c2',
    brand: CardBrand.mastercard,
    last4: '8821',
    holderName: 'Alex Rivera',
  ),
];
