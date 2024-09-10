import 'dart:io';

//By : Belinda Poetri Dhanti - 0706012314007 (Sesi 2)

// INT CHECKER
bool functionIntChecker(String? inputedSaidInteger) {
  return (inputedSaidInteger != null &&
      int.tryParse(inputedSaidInteger) != null &&
      int.parse(inputedSaidInteger) > 0);
}

// GET DATE
String functionDate() {
  // VAR
  var yearInput;
  var monthInput;
  var dayInput;

  DateTime now = DateTime.now();
  String formattedDate =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

  while (true) {
    print('Is this the right date? $formattedDate (Y/N)');
    var dateInput = stdin.readLineSync();

    if (dateInput == 'Y' || dateInput == 'y') {
      return formattedDate;
    } else if (dateInput == 'N' || dateInput == 'n') {
      // YEAR CHECKER
      while (true) {
        print('Please Input The Year');
        yearInput = stdin.readLineSync();
        if (functionIntChecker(yearInput) == true &&
            yearInput.length == 4 &&
            int.parse(yearInput) > 0 &&
            int.parse(yearInput) <= DateTime.now().year) {
          break;
        } else {
          print('\n--Invalid Year. Please Check Your Input--');
        }
      }
      // MONTH CHECKER
      while (true) {
        print('Please Input The Month');
        monthInput = stdin.readLineSync();
        if (functionIntChecker(monthInput) == true &&
            monthInput!.length <= 2 &&
            int.parse(monthInput) > 0 &&
            int.parse(monthInput) <= 12) {
          break;
        } else {
          print('\n--Invalid Month. Please Check Your Input--');
        }
      }
      // DAY CHECKER
      while (true) {
        print('Please Input The Day');
        dayInput = stdin.readLineSync();
        if (monthInput == '1' ||
            monthInput == '3' ||
            monthInput == '5' ||
            monthInput == '7' ||
            monthInput == '8' ||
            monthInput == '10' ||
            monthInput == '12') {
          if (functionIntChecker(dayInput) == true &&
              dayInput!.length <= 2 &&
              int.parse(dayInput) > 0 &&
              int.parse(dayInput) <= 31) {
            break;
          } else {
            print('\n--Invalid Day. Please Check Your Input--');
          }
        } else if (monthInput == '4' ||
            monthInput == '6' ||
            monthInput == '9' ||
            monthInput == '11') {
          if (functionIntChecker(dayInput) == true &&
              dayInput!.length <= 2 &&
              int.parse(dayInput) > 0 &&
              int.parse(dayInput) <= 30) {
            break;
          } else {
            print('\n--Invalid Day. Please Check Your Input--');
          }
        } else if (monthInput == '2') {
          if (int.parse(yearInput) % 4 == 0) {
            if (functionIntChecker(dayInput) == true &&
                dayInput!.length <= 2 &&
                int.parse(dayInput) > 0 &&
                int.parse(dayInput) <= 29) {
              break;
            } else {
              print('\n--Invalid Day. Please Check Your Input--');
            }
          } else {
            if (functionIntChecker(dayInput) == true &&
                dayInput!.length <= 2 &&
                int.parse(dayInput) > 0 &&
                int.parse(dayInput) <= 28) {
              break;
            } else {
              print('\n--Invalid Day. Please Check Your Input--');
            }
          }
        }
      }
      formattedDate =
          '${yearInput}-${monthInput.toString().padLeft(2, '0')}-${dayInput.toString().padLeft(2, '0')}';
    }
  }
}

// GET TIME
String functionTime() {
  DateTime now = DateTime.now();
  return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
}

void main() {
  // VARIABLES FOR ARRAY STORAGE
  List dataInputed = <Map<String, dynamic>>[];

  // MAIN MENU
  while (true) {
    print('\nWelcome to Expenses Counter App');
    print('Type "ADD" to add expenses');
    print('Type "SHOW" to show expenses');
    print('Type "EXIT" to exit the app');
    var menuMainInput = stdin.readLineSync();

    //ADD EXPENSES
    if (menuMainInput.toString().toUpperCase() == 'ADD') {
      while (true) {
        print('\nWhat will this expenses be categorized?');
        print('1. Food');
        print('2. Transport');
        print('3. Entertainment');
        print('4. Other');
        print('0. Back To Main Menu');
        var menuAddInput = stdin.readLineSync();

        // FOOD EXPENSES
        if (menuAddInput == '1' ||
            menuAddInput.toString().toUpperCase() == 'FOOD' ||
            menuAddInput == '1. Food') {
          while (true) {
            print('\nPlease Input Your Expenses [Number Only. 0 = Back]');
            var expenses = stdin.readLineSync();

            // FOOD EXPENSES INPUT CHECKER
            if (expenses == '0') {
              break;
            } else if (expenses != null && double.tryParse(expenses) != null) {
              var expensesDouble = double.parse(expenses);
              var category = 'FOOD';
              var expensesDate = functionDate();
              var expensesTime = functionTime();
              var expensesDateTime = '$expensesDate $expensesTime';
              print('Input Your Expenses Note Here');
              String? expensesNote = stdin.readLineSync();

              // INPUT INTO STORAGE
              dataInputed.add({
                'dateTime': expensesDateTime,
                'category': category,
                'expenses': expensesDouble,
                'note': expensesNote
              });
              break; // EXIT FOOD EXPENSES LOOP
            } else {
              print('\n--Invalid Input. Please Check Your Input--');
            }
          }
          break; // EXIT ADD EXPENSES LOOP
        }
        // TRANSPORT EXPENSES
        else if (menuAddInput == '2' ||
            menuAddInput.toString().toUpperCase() == 'TRANSPORT' ||
            menuAddInput == '2. Transport') {
          while (true) {
            print('\nPlease Input Your Expenses [Number Only. 0 = Back]');
            var expenses = stdin.readLineSync();

            // TRANSPORT EXPENSES INPUT CHECKER
            if (expenses == '0') {
              break;
            } else if (expenses != null && double.tryParse(expenses) != null) {
              var expensesDouble = double.parse(expenses);
              var category = 'TRANSPORT';
              var expensesDate = functionDate();
              var expensesTime = functionTime();
              var expensesDateTime = '$expensesDate $expensesTime';
              print('Input Your Expenses Note Here');
              var expensesNote = stdin.readLineSync();

              // INPUT INTO STORAGE
              dataInputed.add({
                'dateTime': expensesDateTime,
                'category': category,
                'expenses': expensesDouble,
                'note': expensesNote
              });
              break; // EXIT TRANSPORT EXPENSES LOOP
            } else {
              print('\n--Invalid Input. Please Check Your Input--');
            }
          }
          break;
        } else if (menuAddInput == '3' ||
            menuAddInput.toString().toUpperCase() == 'ENTERTAINMENT' ||
            menuAddInput == '3. Entertainment') {
          while (true) {
            print('\nPlease Input Your Expenses [Number Only. 0 = Back]');
            var expenses = stdin.readLineSync();

            // ENTERTAINMENT EXPENSES INPUT CHECKER
            if (expenses == '0') {
              break;
            } else if (expenses != null && double.tryParse(expenses) != null) {
              var expensesDouble = double.parse(expenses);
              var category = 'ENTERTAINMENT';
              var expensesDate = functionDate();
              var expensesTime = functionTime();
              var expensesDateTime = '$expensesDate $expensesTime';
              print('Input Your Expenses Note Here');
              var expensesNote = stdin.readLineSync();

              // INPUT INTO STORAGE
              dataInputed.add({
                'dateTime': expensesDateTime,
                'category': category,
                'expenses': expensesDouble,
                'note': expensesNote
              });
              break; // EXIT ENTERTAINMENT EXPENSES LOOP
            } else {
              print('\n--Invalid Input. Please Check Your Input--');
            }
          }
          break;
        } else if (menuAddInput == '4' ||
            menuAddInput.toString().toUpperCase() == 'OTHER' ||
            menuAddInput == '4. Other') {
          while (true) {
            print('\nPlease Input Your Expenses [Number Only. 0 = Back]');
            var expenses = stdin.readLineSync();

            // OTHER EXPENSES INPUT CHECKER
            if (expenses == '0') {
              break;
            } else if (expenses != null && double.tryParse(expenses) != null) {
              var expensesDouble = double.parse(expenses);
              var category = 'OTHER';
              var expensesDate = functionDate();
              var expensesTime = functionTime();
              var expensesDateTime = '$expensesDate $expensesTime';
              print('Input Your Expenses Note Here');
              var expensesNote = stdin.readLineSync();

              // INPUT INTO STORAGE
              dataInputed.add({
                'dateTime': expensesDateTime,
                'category': category,
                'expenses': expensesDouble,
                'note': expensesNote
              });
              break; // EXIT OTHER EXPENSES LOOP
            } else {
              print('\n--Invalid Input. Please Check Your Input--');
            }
          }
          break;
        } else if (menuAddInput == '0' ||
            menuAddInput == 'Back To Main Menu' ||
            menuAddInput == '0. Back To Main Menu' ||
            menuAddInput == 'Back') {
          break;
        } else {
          print('\n--Invalid Input. Please Check Your Input--');
        }
      }
      continue;
    } else if (menuMainInput.toString().toUpperCase() == 'SHOW') {
      while (true) {
        print('\nShow By:');
        print('1. Month');
        print('2. Last 30 Days');
        print('0. Back To Main Menu');
        print('Type "EXIT" to exit the app');
        var menuShowInput = stdin.readLineSync();
        if (menuShowInput == '1' ||
            menuShowInput.toString().toUpperCase() == 'MONTH' ||
            menuShowInput == '1. Month') {
          // VAR
          var monthInput;
          var yearInput;

          // INPUT
          while (true) {
            print('Input Month');
            monthInput = stdin.readLineSync();
            if (functionIntChecker(monthInput) == true &&
                monthInput!.length <= 2 &&
                int.parse(monthInput) > 0 &&
                int.parse(monthInput) <= 12) {
              break;
            } else {
              print('\n--Invalid Month. Please Check Your Input--');
            }
          }
          while (true) {
            print('Input Year');
            yearInput = stdin.readLineSync();
            if (functionIntChecker(yearInput) == true &&
                yearInput!.length == 4 &&
                int.parse(yearInput) > 0 &&
                int.parse(yearInput) <= DateTime.now().year) {
              break;
            } else {
              print('\n--Invalid Year. Please Check Your Input--');
            }
          }
          var searchByMonth =
              yearInput + '-' + monthInput.toString().padLeft(2, '0');
          var filteredData = dataInputed
              .where((item) => item['dateTime'].startsWith(searchByMonth))
              .toList();
          filteredData.sort((a, b) => a['dateTime'].compareTo(b['dateTime']));
          print('\nMonth Expenses Report');
          var monthName = [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ];
          print(
              '\nMonth: ${monthName[int.parse(monthInput) - 1]} Year:$yearInput');
          print(
              '\n    Date    |    Category    |   Expenses   |           Note           ');
          print(
              '------------|----------------|--------------|--------------------------');
          for (var item in filteredData) {
            print(
                ' ${item['dateTime'].toString().substring(0, 10)} | ${item['category'].toString().padLeft(14, ' ')} | ${item['expenses'].toString().padLeft(12, ' ')} | ${item['note']}');
          }
          var totalExpenses = 0.0;
          for (var item in filteredData) {
            totalExpenses += item['expenses'];
          }
          print('\nTotal Expenses                 : ' +
              totalExpenses.toString().padLeft(38, ' '));
          var searchByFood =
              filteredData.where((item) => item['category'] == 'FOOD').toList();
          var totalExpensesFood = 0.0;
          for (var item in searchByFood) {
            totalExpensesFood += item['expenses'];
          }
          print('\nMore Info:');
          print('Total Expenses On Food         : ' +
              totalExpensesFood.toString().padLeft(38, ' '));
          var searchByTransport = filteredData
              .where((item) => item['category'] == 'TRANSPORT')
              .toList();
          var totalExpensesTransport = 0.0;
          for (var item in searchByTransport) {
            totalExpensesTransport += item['expenses'];
          }
          print('Total Expenses On Transport    : ' +
              totalExpensesTransport.toString().padLeft(38, ' '));
          var searchByEntertainment = filteredData
              .where((item) => item['category'] == 'ENTERTAINMENT')
              .toList();
          var totalExpensesEntertainment = 0.0;
          for (var item in searchByEntertainment) {
            totalExpensesEntertainment += item['expenses'];
          }
          print('Total Expenses On Entertainment: ' +
              totalExpensesEntertainment.toString().padLeft(38, ' '));
          var searchByOther = filteredData
              .where((item) => item['category'] == 'OTHER')
              .toList();
          var totalExpensesOther = 0.0;
          for (var item in searchByOther) {
            totalExpensesOther += item['expenses'];
          }
          print('Total Expenses On Other        : ' +
              totalExpensesOther.toString().padLeft(38, ' '));
          break;
        } else if (menuShowInput == '2' ||
            menuShowInput.toString().toUpperCase() == 'LAST 30 DAYS' ||
            menuShowInput == '2. Last 30 Days') {
          var startDate = DateTime.now().subtract(Duration(days: 30));
          var filteredData = dataInputed
              .where(
                  (item) => DateTime.parse(item['dateTime']).isAfter(startDate))
              .toList();
          filteredData.sort((a, b) => a['dateTime'].compareTo(b['dateTime']));
          print('\nLast 30 Days Expenses Report');
          print(
              '\n    Date    |    Category    |   Expenses   |           Note           ');
          print(
              '------------|----------------|--------------|--------------------------');
          for (var item in filteredData) {
            print(
                ' ${item['dateTime'].toString().substring(0, 10)} | ${item['category'].toString().padLeft(14, ' ')} | ${item['expenses'].toString().padLeft(12, ' ')} | ${item['note']}');
          }
          var totalExpenses = 0.0;
          for (var item in filteredData) {
            totalExpenses += item['expenses'];
          }
          print('\nTotal Expenses                 : ' +
              totalExpenses.toString().padLeft(38, ' '));
          var searchByFood =
              filteredData.where((item) => item['category'] == 'FOOD').toList();
          var totalExpensesFood = 0.0;
          for (var item in searchByFood) {
            totalExpensesFood += item['expenses'];
          }
          print('\nMore Info:');
          print('Total Expenses On Food         : ' +
              totalExpensesFood.toString().padLeft(38, ' '));
          var searchByTransport = filteredData
              .where((item) => item['category'] == 'TRANSPORT')
              .toList();
          var totalExpensesTransport = 0.0;
          for (var item in searchByTransport) {
            totalExpensesTransport += item['expenses'];
          }
          print('Total Expenses On Transport    : ' +
              totalExpensesTransport.toString().padLeft(38, ' '));
          var searchByEntertainment = filteredData
              .where((item) => item['category'] == 'ENTERTAINMENT')
              .toList();
          var totalExpensesEntertainment = 0.0;
          for (var item in searchByEntertainment) {
            totalExpensesEntertainment += item['expenses'];
          }
          print('Total Expenses On Entertainment: ' +
              totalExpensesEntertainment.toString().padLeft(38, ' '));
          var searchByOther = filteredData
              .where((item) => item['category'] == 'OTHER')
              .toList();
          var totalExpensesOther = 0.0;
          for (var item in searchByOther) {
            totalExpensesOther += item['expenses'];
          }
          print('Total Expenses On Other        : ' +
              totalExpensesOther.toString().padLeft(38, ' '));
          break;
        } else if (menuShowInput == '0' ||
            menuShowInput == 'Back To Main Menu' ||
            menuShowInput == '0. Back To Main Menu' ||
            menuShowInput == 'Back') {
          break;
        } else {
          print('\n--Invalid Input. Please Check Your Input--');
        }
      }
    } else if (menuMainInput.toString().toUpperCase() == 'EXIT') {
      break;
    } else {
      print('\n--Invalid Input. Please Check Your Input--');
    }
  }
}
