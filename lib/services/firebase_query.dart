import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

//////////////////////////STAŁE//////////////////////////
final FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
User _user = _auth.currentUser!;
CollectionReference expenses =
    firestore.collection('users/${_user.uid}/expenses');
CollectionReference earnings =
    firestore.collection('users/${_user.uid}/earnings');
CollectionReference budget = firestore.collection('users/${_user.uid}/budget');

String returnMonth() {
  return new DateFormat.M().format(DateTime.now());
}

/////////ZAPYTANIA DO UŻTYKWONIKA/////////////////

// Tworzenie użytkownika za pomocą loginu i hasła
Future<bool> createUser(String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return true;
  } catch (e) {
    return false;
  }
}

// Inicjalizacja użytkownika (dodanie pustego budżetu)
Future<void> initializationNewUser() {
  budget
      .doc('expenses')
      .set({
        'price': 1.1,
      })
      .then((value) => print("initialization"))
      .catchError((error) => print("Failed initialization: $error"));
  return budget
      .doc('earnings')
      .set({
        'value': 1.1,
      })
      .then((value) => print("initialization"))
      .catchError((error) => print("Failed initialization: $error"));
}

// Logowanie użytkownika
Future<bool> loginUser(String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    return false;
  }
}

// Wylogowanie użytkownika
void signOut() async {
  await _auth.signOut();
  print("Nastąpiło wylogowanie");
}

//Sprawdzenie UID użytkownika
void userId() {
  print(_user.uid);
}
///////////////////////////////////////////////////////

//////////////DODAWANIE DANYCH DO BAZY///////////////////////
// Dodawanie nowego wydatku do bazy WYDATKI
Future<void> addExpense(String category, String? name, double? price) {
  return expenses
      .add({
        'category': category,
        'name': name,
        'price': price,
        'time': Timestamp.now(),
        'month': returnMonth(),
      })
      .then((value) => print("Expense added"))
      .catchError((error) => print("Failed to add expense: $error"));
}

// PRZYCHODY
Future<void> addEarning(String category, String? name, double? price) {
  return earnings
      .add({
        'category': category,
        'name': name,
        'price': price,
        'time': Timestamp.now(),
        'month': returnMonth(),
      })
      .then((value) => print("Earning added"))
      .catchError((error) => print("Failed to add earning: $error"));
}

// Ustawienie budżetu miesięcznego na WYDATKI
Future<void> addExpenseBudget(double? price) {
  return budget
      .doc('expenses')
      .set({
        'price': price,
      })
      .then((value) => print("update"))
      .catchError((error) => print("updata error: $error"));
}
// PRZYCHODY
Future<void> addEarningBudget(double? price) {
  return budget
      .doc('earnings')
      .set({
        'value': price,
      })
      .then((value) => print("update"))
      .catchError((error) => print("updata error: $error"));
}

// Usuwanie danych z bazy WYDATKI
Future<void> deleteExpenses(String id) {
  return expenses
      .doc('$id')
      .delete()
      .then((value) => print("Expenses Deleted"))
      .catchError((error) => print("Failed to delete Expenses: $error"));
}

// WPŁATY
Future<void> deleteEarnings(String id) {
  return earnings
      .doc('$id')
      .delete()
      .then((value) => print("Expenses Deleted"))
      .catchError((error) => print("Failed to delete Expenses: $error"));
}
///////////////////////////////////////////////////

//////////////ODBIERANIE DANYCH Z BAZY/////////////

// Odbieranie snapshotu z danymi o WYDATKI
Stream<QuerySnapshot> getSnapshotData() async* {
  yield* expenses.orderBy('time', descending: true).snapshots();
}

// PRZYCHODY
Stream<QuerySnapshot> getSnapshotDataEarnings() async* {
  yield* earnings.snapshots();
}

// Liczenie kosztów łącznych poszczególnych kategorii WYDATKI
Future<double> coutExpenses(String name) async {
  double sum = 0;
  await expenses
      .where('category', isEqualTo: name)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      sum = sum + doc["price"];
    });
  });
  return sum;
}

// PRZYCHODY
Future<double> coutEarnings(String name) async {
  double sum = 0;
  await earnings
      .where('category', isEqualTo: name)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      sum = sum + doc["price"];
    });
  });
  return sum;
}

// liczenie sumy wszystkich kosztów WYDATKI
Future<double> coutAllExpenses() async {
  double sum = 0;
  await expenses.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      sum = sum + doc["price"];
    });
  });
  return sum;
}

// PRZYCHODY
Future<double> coutAllEarnings() async {
  double sum = 0;
  await earnings.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      sum = sum + doc["price"];
    });
  });
  return sum;
}

// Wyciągnięcie budżetu z bazy WYDATKI
Future<double> getExpensesBudget() async {
  double sum = 0;
  await firestore
      .collection('users/${_user.uid}/budget')
      .get()
      .then((QuerySnapshot querySnapshot) {
    sum = querySnapshot.docs.last.get('price');
  });
  return sum;
}

// PRZYCHODY
Future<double> getEarningsBudget() async {
  double sum = 0;
  await firestore
      .collection('users/${_user.uid}/budget')
      .get()
      .then((QuerySnapshot querySnapshot) {
    sum = querySnapshot.docs.first.get('value');
  });
  return sum;
}


// Odbieranie pojedyńczego rekordu z bazy
// Stream<DocumentSnapshot> getData() async* {
//   yield* expenses.doc('ryXmLTDwDIvMDmeKc9JW').snapshots();
// }