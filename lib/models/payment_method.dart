enum CardBrand { visa, mastercard, amex }

class PaymentCard {
  final String id;
  final CardBrand brand;
  final String last4;
  final String holderName;
  final bool isDefault;

  const PaymentCard({
    required this.id,
    required this.brand,
    required this.last4,
    required this.holderName,
    this.isDefault = false,
  });

  String get brandLabel {
    switch (brand) {
      case CardBrand.visa:
        return 'Visa';
      case CardBrand.mastercard:
        return 'Mastercard';
      case CardBrand.amex:
        return 'Amex';
    }
  }

  PaymentCard copyWith({bool? isDefault}) => PaymentCard(
        id: id,
        brand: brand,
        last4: last4,
        holderName: holderName,
        isDefault: isDefault ?? this.isDefault,
      );
}
