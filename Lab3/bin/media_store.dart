// HW3 — Digital E-Commerce Media Store
// Abstract class + mixin + collection methods (.where, .fold).

abstract class MediaItem {
  final String id;
  final String title;
  final double price;

  MediaItem({required this.id, required this.title, required this.price});

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print('  ⬇ Downloading "$title"... done.');
  }
}

class Audiobook extends MediaItem with Downloadable {
  final double durationHours;
  final String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });

  @override
  String getDetails() =>
      '[$id] Audiobook: "$title" — narrated by $narrator, '
      '${durationHours.toStringAsFixed(1)}h — \$${price.toStringAsFixed(2)}';
}

class EBook extends MediaItem with Downloadable {
  final double fileSizeMB;
  final String author;

  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });

  @override
  String getDetails() =>
      '[$id] EBook: "$title" — by $author, '
      '${fileSizeMB.toStringAsFixed(1)} MB — \$${price.toStringAsFixed(2)}';
}

class ShoppingCart {
  final List<MediaItem> _items = [];

  // Adds an item to the cart.
  void addItem(MediaItem item) {
    _items.add(item);
  }

  // Sums every price, then adds the tax on top (12% by default).
  double calculateTotalWithTax({double taxRate = 0.12}) {
    double subtotal = _items.fold(0.0, (total, item) => total + item.price);
    return subtotal + subtotal * taxRate;
  }

  // Keeps only the items priced at or below the given limit.
  List<MediaItem> filterByMaxPrice(double maxPrice) =>
      _items.where((item) => item.price <= maxPrice).toList();

  // Prints every item and downloads the ones that support it.
  void printReceipt() {
    print("===== RECEIPT =====");
    for (MediaItem item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
    print("-------------------");
    print("Items: ${_items.length}");
    print("Total (incl. 12% tax): \$${calculateTotalWithTax().toStringAsFixed(2)}");
  }
}

void main() {
  ShoppingCart cart = ShoppingCart();

  cart.addItem(
    Audiobook(
      id: "A-01",
      title: "Atomic Habits",
      price: 24.99,
      durationHours: 5.5,
      narrator: "James Clear",
    ),
  );
  cart.addItem(
    EBook(
      id: "E-01",
      title: "Clean Architecture",
      price: 32.40,
      fileSizeMB: 8.2,
      author: "Robert Martin",
    ),
  );
  cart.addItem(
    Audiobook(
      id: "A-02",
      title: "Deep Work",
      price: 18.75,
      durationHours: 7.2,
      narrator: "Jeff Bottoms",
    ),
  );
  cart.addItem(
    EBook(
      id: "E-02",
      title: "Dart in Practice",
      price: 12.00,
      fileSizeMB: 4.6,
      author: "Anna Petrova",
    ),
  );

  cart.printReceipt();

  print("\n===== ITEMS UNDER \$20.00 =====");
  for (MediaItem item in cart.filterByMaxPrice(20.00)) {
    print(item.getDetails());
  }

  print("\n===== TOTAL WITH CUSTOM 5% TAX =====");
  print("\$${cart.calculateTotalWithTax(taxRate: 0.05).toStringAsFixed(2)}");
}
