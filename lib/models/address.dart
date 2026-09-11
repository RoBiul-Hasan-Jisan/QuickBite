class Address {
  final String id;
  final String label; // 'Home', 'Work', 'Other'
  final String line1;
  final String line2;
  final bool isDefault;

  const Address({
    required this.id,
    required this.label,
    required this.line1,
    required this.line2,
    this.isDefault = false,
  });

  Address copyWith({bool? isDefault}) => Address(
        id: id,
        label: label,
        line1: line1,
        line2: line2,
        isDefault: isDefault ?? this.isDefault,
      );
}
