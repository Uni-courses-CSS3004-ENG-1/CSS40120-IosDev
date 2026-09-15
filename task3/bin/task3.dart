// Homework 2 — Safe ATM Banking Terminal Simulator
// Functions, named parameters, arrow syntax (=>) and sound null safety (?, ??, !).

const int correctPin = 1234;

// Remembers the last successful withdrawal of the session. It is a top-level
// nullable, and Dart does not promote those, so reading it needs `!`.
double? lastWithdrawal;

void main() {
  String name = "Bekzat";
  double balance = 20000.0;

  print("===== SAFE ATM BANKING TERMINAL =====\n");
  checkBalance(name: name, balance: balance);

  print("\n--- DEPOSIT 5000 ---");
  balance = deposit(currentBalance: balance, amount: 5000.0);

  print("\n--- DEPOSIT (no amount entered) ---");
  balance = deposit(currentBalance: balance);

  print("\n--- WITHDRAW 3000 with wrong PIN ---");
  balance = withdraw(
    name: name,
    currentBalance: balance,
    amount: 3000.0,
    pinCode: 9999,
  );

  print("\n--- WITHDRAW 3000 with no PIN entered ---");
  balance = withdraw(name: name, currentBalance: balance, amount: 3000.0);

  print("\n--- WITHDRAW 999999 (insufficient funds) ---");
  balance = withdraw(
    name: name,
    currentBalance: balance,
    amount: 999999.0,
    pinCode: 1234,
  );

  print("\n--- WITHDRAW 7000 with correct PIN ---");
  balance = withdraw(
    name: name,
    currentBalance: balance,
    amount: 7000.0,
    pinCode: 1234,
  );

  print("\n===== SESSION END =====");
  checkBalance(name: name, balance: balance);
  printLastWithdrawal();
}

// 1. checkBalance — arrow function, prints the available balance.
void checkBalance({required String name, required double balance}) =>
    print("$name, your available balance is $balance ₸");

// 2. deposit — a missing amount falls back to 0.0 via ??, which is not a
// valid deposit, so the balance is returned untouched.
double deposit({required double currentBalance, double? amount}) {
  double value = amount ?? 0.0;

  if (value <= 0) {
    print("DEPOSIT DECLINED: no valid amount entered.");
    print("balance unchanged: $currentBalance ₸");
    return currentBalance;
  }

  double updatedBalance = currentBalance + value;
  print("RECEIPT - DEPOSIT");
  print("deposited: $value ₸");
  print("new balance: $updatedBalance ₸");
  return updatedBalance;
}

// 3. withdraw — checks the PIN, then the amount, then the balance.
double withdraw({
  required String name,
  required double currentBalance,
  double? amount,
  int? pinCode,
}) {
  int enteredPin = pinCode ?? 0000;
  if (enteredPin != correctPin) {
    print("TRANSACTION DECLINED: incorrect PIN code.");
    print("balance unchanged: $currentBalance ₸");
    return currentBalance;
  }

  double value = amount ?? 0.0;
  if (value <= 0) {
    print("TRANSACTION DECLINED: no valid amount entered.");
    print("balance unchanged: $currentBalance ₸");
    return currentBalance;
  }

  if (value > currentBalance) {
    print("TRANSACTION DECLINED: insufficient funds.");
    print("requested: $value ₸, available: $currentBalance ₸");
    return currentBalance;
  }

  double updatedBalance = currentBalance - value;
  lastWithdrawal = value;

  print("RECEIPT - WITHDRAWAL");
  print("client: $name");
  print("withdrawn: $value ₸");
  print("new balance: $updatedBalance ₸");
  return updatedBalance;
}

// `!` tells Dart the top-level variable is definitely not null here.
void printLastWithdrawal() {
  if (lastWithdrawal == null) {
    print("no withdrawals in this session");
    return;
  }
  print("last withdrawal: ${lastWithdrawal!} ₸");
}
