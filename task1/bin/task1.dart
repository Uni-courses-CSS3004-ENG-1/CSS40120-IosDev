// Task 1 — Dart basics practice
// Source: main.dart (warm-up + 5 tasks)

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

// Warm-up from the original file: variables, null safety, loops.
void warmUp() {
  String name = "Bekzat";
  int age = 25;
  double gpa = 3.4;
  bool isStudent = false;

  print("name : $name\nage: $age y.o.\ngpa: $gpa\nis Teacher: ${!isStudent}");

  String text1 = "Hello";
  // String nullText = null; not works
  // ignore: avoid_init_to_null — the explicit null is the point of the line above
  String? text2 = null;
  print('text1: $text1');
  print('text2: $text2');

  int length1 = text1.length;
  int length2 = text2?.length ?? 0;
  print(length1);
  print(length2);

  String confirmedText = text2 ?? "default";
  print("confirmed $confirmedText length: ${confirmedText.length}");
}

// TASK 1
// Output multiplication table 1-10 for a given digit.
void printMultiplicationTable(int digit) {
  print("MULTIPLICATION TABLE for digit $digit");
  for (int i = 1; i <= 10; i++) {
    print("$digit * $i = ${digit * i}");
  }
}

// TASK 2
// Next day for a "dd.MM.yyyy" string, or "invalid date" if the input is wrong.
String nextDay(String date) {
  List<String> parts = date.split('.');
  if (parts.length != 3) return "invalid date";

  int? day = int.tryParse(parts[0]);
  int? month = int.tryParse(parts[1]);
  int? year = int.tryParse(parts[2]);
  if (day == null || month == null || year == null) return "invalid date";

  if (year < 1 || month < 1 || month > 12) return "invalid date";
  if (day < 1 || day > daysInMonth(month, year)) return "invalid date";

  int newDay = day + 1;
  int newMonth = month;
  int newYear = year;

  if (newDay > daysInMonth(month, year)) {
    newDay = 1;
    newMonth++;
    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }
  }

  return "${pad(newDay)}.${pad(newMonth)}.${newYear.toString().padLeft(4, '0')}";
}

// 2000 and 2400 are leap years, 2100 / 2200 / 2300 are not.
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
// Count the vowels in a string.
int countVowels(String text) {
  String vowels = "aeiou";
  int count = 0;
  for (int i = 0; i < text.length; i++) {
    if (vowels.contains(text[i].toLowerCase())) {
      count++;
    }
  }
  return count;
}

// TASK 4
// Manual min & max finder — no built-in reduce/min/max.
int findMax(List<int> numbers) {
  int max = numbers[0];
  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] > max) {
      max = numbers[i];
    }
  }
  return max;
}

int findMin(List<int> numbers) {
  int min = numbers[0];
  for (int i = 1; i < numbers.length; i++) {
    if (numbers[i] < min) {
      min = numbers[i];
    }
  }
  return min;
}

// TASK 5
// Prime number checker.
bool isPrime(int number) {
  if (number < 2) return false;
  for (int i = 2; i * i <= number; i++) {
    if (number % i == 0) return false;
  }
  return true;
}
