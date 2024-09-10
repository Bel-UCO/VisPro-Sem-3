import 'dart:io';

main() {
  var savedExpenses = <double>[];
  while (true) {
    print('\nReady to count your expenses?');
    print('Input Number To Add Expenses');
    print('Press 0 To Exit');
    var totalExpenses = 0.0;
    for (var e in savedExpenses) {
      totalExpenses += e;
    }
    print('Your Current Expenses: $totalExpenses');
    var inputExpenses = stdin.readLineSync();
    if (inputExpenses == Null) {
      print('\n --Invalid Input. Please Give An Input--');
      continue;
    } else if (inputExpenses == '0') {
      print('Your Total Expenses: $totalExpenses');
      print('Thank You');
      break;
    } else if (double.tryParse(inputExpenses!) != null &&
        double.parse(inputExpenses) > 0) {
      savedExpenses.add(double.parse(inputExpenses));
    } else {
      print('\n --Invalid Input. Numbers Only--');
    }
  }
}
