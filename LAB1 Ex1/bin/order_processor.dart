// LAB1 Ex1 — Safe E-Commerce Order Processor
// Named parameters, optional nullable values and sound null safety (?, ??).

const String validPromoCode = "SAVE10";
const double defaultDeliveryFee = 500.0;

void main() {
  print("===== SAFE E-COMMERCE ORDER PROCESSOR =====");

  print("\n--- ORDER 1: promo code + custom delivery fee ---");
  processOrder(
    orderId: "ORD-001",
    itemPrice: 12000.0,
    promoCode: "SAVE10",
    deliveryFee: 990.0,
  );

  print("\n--- ORDER 2: no promo, no delivery fee entered ---");
  processOrder(orderId: "ORD-002", itemPrice: 7500.0);

  print("\n--- ORDER 3: unknown promo code ---");
  processOrder(orderId: "ORD-003", itemPrice: 4300.0, promoCode: "BLACKFRIDAY");

  print("\n--- ORDER 4: free delivery (0.0 is not null) ---");
  processOrder(
    orderId: "ORD-004",
    itemPrice: 25000.0,
    promoCode: "SAVE10",
    deliveryFee: 0.0,
  );
}

// Builds the order summary and returns the final total.
double processOrder({
  required String orderId,
  required double itemPrice,
  String? promoCode,
  double? deliveryFee,
}) {
  // A missing delivery fee falls back to 500.0 ₸ via ??.
  double fee = deliveryFee ?? defaultDeliveryFee;

  bool promoApplied = promoCode == validPromoCode;
  double discount = promoApplied ? itemPrice * 0.10 : 0.0;
  double total = itemPrice - discount + fee;

  print("ORDER SUMMARY - $orderId");
  print("item price: ${itemPrice.toStringAsFixed(2)} ₸");

  if (promoApplied) {
    print("promo code: $promoCode applied (-10%)");
    print("discount: -${discount.toStringAsFixed(2)} ₸");
  } else {
    print("promo code: ${promoCode ?? "none entered"} — no discount");
  }

  print(
    "delivery fee: ${fee.toStringAsFixed(2)} ₸"
    "${deliveryFee == null ? " (default)" : ""}",
  );
  print("TOTAL: ${total.toStringAsFixed(2)} ₸");

  return total;
}
