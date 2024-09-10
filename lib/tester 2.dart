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
        print('Please input the year');
        yearInput = stdin.readLineSync();
        if (functionIntChecker(yearInput) &&
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
        print('Please input the month');
        monthInput = stdin.readLineSync();
        if (functionIntChecker(monthInput) &&
            monthInput.length <= 2 &&
            int.parse(monthInput) > 0 &&
            int.parse(monthInput) <= 12) {
          break;
        } else {
          print('\n--Invalid Month. Please Check Your Input--');
        }
      }
      // DAY CHECKER
      while (true) {
        print('Please input the day');
        dayInput = stdin.readLineSync();
        if (monthInput == '1' || monthInput == '3' || monthInput == '5' ||
            monthInput == '7' || monthInput == '8' || monthInput == '10' || monthInput == '12') {
          if (functionIntChecker(dayInput) &&
              int.parse(dayInput) > 0 && int.parse(dayInput) <= 31) {
            break;
          } else {
            print('\n--Invalid Day. Please Check Your Input--');
          }
        } else if (monthInput == '4' || monthInput == '6' || monthInput == '9' || monthInput == '11') {
          if (functionIntChecker(dayInput) &&
              int.parse(dayInput) > 0 && int.parse(dayInput) <= 30) {
            break;
          } else {
            print('\n--Invalid Day. Please Check Your Input--');
          }
        } else if (monthInput == '2') {
          if (int.parse(yearInput) % 4 == 0) {
            if (functionIntChecker(dayInput) &&
                int.parse(dayInput) > 0 && int.parse(dayInput) <= 29) {
              break;
            } else {
              print('\n--Invalid Day. Please Check Your Input--');
            }
          } else {
            if (functionIntChecker(dayInput) &&
                int.parse(dayInput) > 0 && int.parse(dayInput) <= 28) {
              break;
            } else {
              print('\n--Invalid Day. Please Check Your Input--');
            }
          }
        }
      }
      formattedDate = '${yearInput}-${monthInput.padLeft(2, '0')}-${dayInput.padLeft(2, '0')}';
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
  List<Map<String, dynamic>> dataInputed = [];

  // MAIN MENU
  while (true) {
    print('\nWelcome to Expenses Counter App');
    print('Type "ADD" to add expenses');
    print('Type "SHOW" to show expenses');
    print('Type "EXIT" to exit the app');
    var menuMainInput = stdin.readLineSync();

    // ADD EXPENSES
    if (menuMainInput == 'ADD') {
      while (true) {
        print('\nWhat will this expense be categorized?');
        print('1. Food');
        print('2. Transport');
        print('3. Entertainment');
        print('4. Other');
        print('0. Back To Main Menu');
        var menuAddInput = stdin.readLineSync();

        // FOOD EXPENSES
        if (menuAddInput == '1' || menuAddInput == 'Food' || menuAddInput == '1. Food') {
          while (true) {
            print('\nPlease Input Your Expenses [Number Only. 0 = Back]');
            var expensesFood = stdin.readLineSync();

            if (expensesFood == '0') {
              break; // Exit food expense input
            } else if (expensesFood != null && double.tryParse(expensesFood) != null) {
              var expensesFoodDouble = double.parse(expensesFood);
              var category = 'FOOD';
              var expensesDate = functionDate();
              var expensesTime = functionTime();
              var expensesDateTime = '$expensesDate $expensesTime';
              print('Please add a note for your expense:');
              var expensesNote = stdin.readLineSync();

              // INPUT INTO STORAGE
              dataInputed.add({
                'dateTime': expensesDateTime,
                'category': category,
                'expenses': expensesFoodDouble,
                'note': expensesNote
              });

              break; // Exit food expense entry loop after adding
            } else {
              print('\n--Invalid Input. Please Check Your Input--');
            }
          }
          continue; // Return to main menu after adding
        }
        // TRANSPORT EXPENSES
        else if (menuAddInput == '2' || menuAddInput == 'Transport' || menuAddInput == '2. Transport') {
          while (true) {
            print('\nPlease Input Your Expenses [Number Only. 0 = Back]');
            var expensesTransport = stdin.readLineSync();

            if (expensesTransport == '0') {
              break; // Exit transport expense input
            } else if (expensesTransport != null && double.tryParse(expensesTransport) != null) {
              var expensesTransportDouble = double.parse(expensesTransport);
              var category = 'TRANSPORT';
              var expensesDate = functionDate();
              var expensesTime = functionTime();
              var expensesDateTime = '$expensesDate $expensesTime';
              print('Please add a note for your expense:');
              var expensesNote = stdin.readLineSync();

              // INPUT INTO STORAGE
              dataInputed.add({
                'dateTime': expensesDateTime,
                'category': category,
                'expenses': expensesTransportDouble,
                'note': expensesNote
              });

              break; // Exit transport expense entry loop after adding
            } else {
              print('\n--Invalid Input. Please Check Your Input--');
            }
          }
          continue; // Return to main menu after adding
        }
        // ENTERTAINMENT EXPENSES
        else if (menuAddInput == '3' || menuAddInput == 'Entertainment' || menuAddInput == '3. Entertainment') {
          while (true) {
            print('\nPlease Input Your Expenses [Number Only. 0 = Back]');
            var expensesEntertainment = stdin.readLineSync();

            if (expensesEntertainment == '0') {
              break; // Exit entertainment expense input
            } else if (expensesEntertainment != null && double.tryParse(expensesEntertainment) != null) {
              var expensesEntertainmentDouble = double.parse(expensesEntertainment);
              var category = 'ENTERTAINMENT';
              var expensesDate = functionDate();
              var expensesTime = functionTime();
              var expensesDateTime = '$expensesDate $expensesTime';
              print('Please add a note for your expense:');
              var expensesNote = stdin.readLineSync();

              // INPUT INTO STORAGE
              dataInputed.add({
                'dateTime': expensesDateTime,
                'category': category,
                'expenses': expensesEntertainmentDouble,
                'note': expensesNote
              });

              break; // Exit entertainment expense entry loop after adding
            } else {
              print('\n--Invalid Input. Please Check Your Input--');
            }
          }
          continue; // Return to main menu after adding
        }
        // OTHER EXPENSES
        else if (menuAddInput == '4' || menuAddInput == 'Other' || menuAddInput == '4. Other') {
          while (true) {
            print('\nPlease Input Your Expenses [Number Only. 0 = Back]');
            var expensesOther = stdin.readLineSync();

            if (expensesOther == '0') {
              break; // Exit other expense input
            } else if (expensesOther != null && double.tryParse(expensesOther) != null) {
              var expensesOtherDouble = double.parse(expensesOther);
              var category = 'OTHER';
              var expensesDate = functionDate();
              var expensesTime = functionTime();
              var expensesDateTime = '$expensesDate $expensesTime';
              print('Please add a note for your expense:');
              var expensesNote = stdin.readLineSync();

              // INPUT INTO STORAGE
              dataInputed.add({
                'dateTime': expensesDateTime,
                'category': category,
                'expenses': expensesOtherDouble,
                'note': expensesNote
              });

              break; // Exit other expense entry loop after adding
            } else {
              print('\n--Invalid Input. Please Check Your Input--');
            }
          }
          continue; // Return to main menu after adding
        }
        // BACK TO MAIN MENU
        else if (menuAddInput == '0' || menuAddInput == 'Back To Main Menu') {
          break; // Exit the add expenses loop
        } else {
          print('\n--Invalid Input. Please Check Your Input--');
        }
      }
    } 
    // SHOW EXPENSES
    else if (menuMainInput == 'SHOW') {
      print('Showing expenses...');
      for (var expense in dataInputed) {
        print(expense);
      }
    } 
    // EXIT APPLICATION
    else if (menuMainInput == 'EXIT') {
      break; // Exit the main loop
    } 
    // INVALID INPUT
    else {
      print('\n--Invalid Input. Please Check Your Input--');
    }
  }
}