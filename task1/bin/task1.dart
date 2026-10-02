// Task 1 — Dart basics practice (simplified)

void main() {
  warmUp();

  print("\n===== TASK 1: MULTIPLICATION TABLE =====");
  printMultiplicationTable(3);

  print("\n===== TASK 2: NEXT DAY =====");
  for (String date in [
    "05.09.2026",
    "28.02.2024",
    "28.02.2026",
    "29.02.2026",
    "28.02.2100",
    "28.02.2000",
    "31.12.2025",
  ]) {
    print("$date -> ${nextDay(date)}");
  }

  print("\n===== TASK 3: VOWEL COUNTER =====");
  String phrase = "flutter mobile development";
  print('"$phrase" -> ${countVowels(phrase)}');

  print("\n===== TASK 4: MANUAL MIN & MAX =====");
  List<int> numbers = [14, 88, 3, 42, 99, 12, 67];
  List<int> numbers1 = [234, 34, 123, 44, 949, 112, 67];
  print("$numbers -> max: ${findMax(numbers)}, min: ${findMin(numbers)}");
  print("$numbers1 -> max: ${findMax(numbers1)}, min: ${findMin(numbers1)}");

  print("\n===== TASK 5: PRIME NUMBER CHECKER =====");
  for (int n in [3, 6, 1, 2, 17, 25, 97]) {
    print("$n -> ${isPrime(n) ? "prime number" : "not prime number"}");
  }
}

// Warm-up: variables, null safety.
void warmUp() {
  String name = "Bekzat";
  int age = 25;
  double gpa = 3.4;
  bool isStudent = false;

  print("name : $name\nage: $age y.o.\ngpa: $gpa\nis Teacher: ${!isStudent}");

  String text1 = "Hello";
  // String nullText = null; // error: plain String can't be null
  String? text2; // nullable, starts as null
  print('text1: $text1');
  print('text2: $text2');

  print(text1.length);
  print(text2?.length ?? 0);

  String confirmedText = text2 ?? "default";
  print("confirmed $confirmedText length: ${confirmedText.length}");
}

// TASK 1
void printMultiplicationTable(int digit) {
  print("MULTIPLICATION TABLE for digit $digit");
  for (int i = 1; i <= 10; i++) {
    print("$digit * $i = ${digit * i}");
  }
}

// TASK 2
String nextDay(String date) {
  List<String> parts = date.split('.');
  if (parts.length != 3) return "invalid date";

  // Bad text becomes 0, and 0 is rejected by the check below.
  int day = int.tryParse(parts[0]) ?? 0;
  int month = int.tryParse(parts[1]) ?? 0;
  int year = int.tryParse(parts[2]) ?? 0;

  if (year < 1 || month < 1 || month > 12) return "invalid date";
  if (day < 1 || day > daysInMonth(month, year)) return "invalid date";

  // Move to tomorrow.
  day++;

  // Day too big? Go to the 1st of next month.
  if (day > daysInMonth(month, year)) {
    day = 1;
    month++;
  }

  // Month too big? Go to January of next year.
  if (month > 12) {
    month = 1;
    year++;
  }

  return "${pad(day)}.${pad(month)}.$year";
}

bool isLeapYear(int year) {
  return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

int daysInMonth(int month, int year) {
  List<int> days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  if (month == 2 && isLeapYear(year)) return 29;
  return days[month - 1];
}

String pad(int value) => value.toString().padLeft(2, '0');

// TASK 3
int countVowels(String text) {
  int count = 0;
  for (String letter in text.toLowerCase().split('')) {
    if ("aeiou".contains(letter)) count++;
  }
  return count;
}

// TASK 4
int findMax(List<int> numbers) {
  int max = numbers[0];
  for (int n in numbers) {
    if (n > max) max = n;
  }
  return max;
}

int findMin(List<int> numbers) {
  int min = numbers[0];
  for (int n in numbers) {
    if (n < min) min = n;
  }
  return min;
}

// TASK 5
bool isPrime(int number) {
  if (number < 2) return false;
  for (int i = 2; i * i <= number; i++) {
    if (number % i == 0) return false;
  }
  return true;
}