// LW3 — Library Book Management System
// Classes + collection methods (.where, .fold).

class Book {
  final String title;
  final String author;
  final double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  });

  @override
  String toString() =>
      '"$title" by $author — \$${price.toStringAsFixed(2)}'
      '${isBorrowed ? " (borrowed)" : ""}';
}

class Library {
  final List<Book> _books = [];

  // Adds a book to the library.
  void addBook(Book book) {
    _books.add(book);
  }

  // Returns only the books nobody has borrowed yet.
  List<Book> getAvailableBooks() =>
      _books.where((book) => book.isBorrowed == false).toList();

  // Sums the price of every book in the library.
  double getTotalValue() =>
      _books.fold(0.0, (total, book) => total + book.price);
}

void main() {
  Library library = Library();

  library.addBook(Book(title: "Clean Code", author: "Robert Martin", price: 39.99));
  library.addBook(
    Book(
      title: "The Pragmatic Programmer",
      author: "Andrew Hunt",
      price: 45.50,
      isBorrowed: true,
    ),
  );
  library.addBook(Book(title: "Dart Apprentice", author: "Jonathan Sande", price: 29.95));
  library.addBook(Book(title: "Flutter in Action", author: "Eric Windmill", price: 54.25));

  print("===== AVAILABLE BOOKS =====");
  for (Book book in library.getAvailableBooks()) {
    print("- $book");
  }

  print("\n===== COLLECTION VALUE =====");
  print("Available: ${library.getAvailableBooks().length} book(s)");
  print("Total value: \$${library.getTotalValue().toStringAsFixed(2)}");
}
