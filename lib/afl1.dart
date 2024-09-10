import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Global Var
var readingSkillLevel;
int averageReaderReadingSkill = 25; //pages per hour
int casualReaderReadingSkill = 40; //pages per hour
int speedReaderReadingSkill = 75; //pages per hour

int functionToughness(int numberInputed) {
  if (numberInputed <= 3) {
    print(
        "\nI guess you are an average reader.\nLet's find something for you.");
    return 1;
  } else if (numberInputed > 3 && numberInputed <= 6) {
    print(
        "\nHey, I guess that makes you a casual reader~\nLet's find something for you.");
    return 2;
  } else {
    print(
        "\nWow, I guess you are such a speed reader\nWe'll definitely find something for you.");
    return 3;
  }
}

void functionExit() {
  print("\n--Thank You For Using Rookie Book Club--");
  exit(0);
}

Future<void> showWaitingMessages(
    List<String> waitingMessages, Completer<void> completer) async {
  for (var message in waitingMessages) {
    if (completer.isCompleted) break; // Stop if the completer is completed
    print(message);
    await Future.delayed(
        Duration(seconds: 3)); // Wait before showing the next message
  }
}

Future<void> functionFetchBook(Map<String, dynamic> selectedBook) async {
  Future<void> functionFetchBook(Map<String, dynamic> selectedBook) async {}

  List<String> waitingMessages = [
    "\nPlease wait, we'll check this specific title of ${selectedBook["title"]}",
    "\nHmm.. ${selectedBook["title"]} is this it?",
    "\nOkay, or is it this one?",
    "\nWait, let me check the inside. Don't peek",
    "\nOkay, not this one :[",
    "\nOkay, this is embarrassing. We couldn't find it",
    "\nWait. Behold- This is the one, the truth, the-",
    "\nOkay, yeah, I get nothing. You got me :["
  ];

  // Create a Completer to control the waiting messages
  var completer = Completer<void>();

  // Start showing waiting messages
  showWaitingMessages(waitingMessages, completer);

  // Complete the completer when the waiting messages are done
  completer.complete();

  // Show details of the selected book
  await showBookDetails(selectedBook);
}

Future<void> showBookDetails(Map<String, dynamic> book) async {
  // Display detailed information about the selected book
  int readingHour;
  var recommendationComment;
  var upperComment;
  var title = book["title"];
  var authors = book["author_name"]?.join(", ") ?? "Unknown author";
  var numberOfPages = book["number_of_pages_median"] ?? 0;
  var printedNumberOfPages;
  var publishDate = book["first_publish_year"] ?? "Unknown year";
  if (numberOfPages > 0) {
    if (readingSkillLevel == 1) {
      readingHour = (numberOfPages / averageReaderReadingSkill).round();
      if (readingHour <= 6) {
        recommendationComment = "This will be a good start. Let's go~";
      } else if (readingHour <= 16) {
        recommendationComment =
            "This may be kinda tough, but a pro reader need to start somewhere, yea? *wink wink*";
      } else {
        recommendationComment =
            "It will be tough, but the journey gonna be worth it. I believe in you ;]";
      }
      upperComment =
          "So, by my calculation, this book will be finished in roughly $readingHour hours.";
    } else if (readingSkillLevel == 2) {
      readingHour = (numberOfPages / casualReaderReadingSkill).round();
      if (readingHour <= 6) {
        recommendationComment =
            "This might be a breeze to you. Very recommended if you wanna have something light~";
      } else if (readingHour <= 16) {
        recommendationComment = "This is fine. You'll power through it ;]";
      } else {
        recommendationComment =
            "If you wanna toughen up, go ahead. It might be a challenge tho~";
      }
      upperComment =
          "So, by my calculation, this book will be finished in roughly $readingHour hours.";
    } else {
      readingHour = (numberOfPages / speedReaderReadingSkill).round();
      if (readingHour <= 6) {
        recommendationComment = "This definitely will be a breeze for you~";
      } else if (readingHour <= 16) {
        recommendationComment =
            "Eh~ Aren't you a tough one? Surely this will be an easy one?";
      } else {
        recommendationComment =
            "Oh boi, do I have question to ask. Are you really wanna do this? You aren't a masochist, right?\nWait, don't answer me. What do I know. Just proceed,sir.";
      }
      upperComment =
          "So, by my calculation, this book will be finished in roughly $readingHour hours.";
    }
    printedNumberOfPages = numberOfPages.toString();
  } else {
    printedNumberOfPages = "Not Available";
    readingHour = 0;
    upperComment =
        "I can't compute reading time because the pages isn't giving me the number of pages :[";
    recommendationComment = "Sorry, maybe in another title? :[";
  }

  print("\n--- Book Details ---");
  print("Title: $title");
  print("Authors: $authors");
  print("Number of Pages: $numberOfPages");
  print("First Published: $publishDate");
  print("--------------------\n");
  print(upperComment);
  print(recommendationComment);
}

Future<void> functionAuthor(String authorName) async {
  List<String> waitingMessages = [
    "\nPlease wait, we'll check $authorName's room",
    "\nHmm.. $authorName doesn't seem to want to answer :[",
    "\nOkay, we can do this without $authorName",
    "\nOoof.. I don't think that $authorName wrote any book. Or maybe...",
    "\nWaiittt....",
    "\nOkay, this is embarrassing. We couldn't find it",
    "\nWait- Maybe this is theirs?",
    "\nOkay, yeah, I get nothing :["
  ];

  // Create a Completer to control the waiting messages
  var completer = Completer<void>();

  // Start showing waiting messages
  showWaitingMessages(waitingMessages, completer);

  try {
    var url =
        "https://openlibrary.org/search.json?author=${Uri.encodeComponent(authorName)}";
    var response = await http.get(Uri.parse(url));

    // Complete the completer when the API response is received
    completer.complete();

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var books = data["docs"];
      print("Books found: ${books.length}");

      for (int i = 0; i < books.length; i++) {
        print("${i + 1}. ${books[i]["title"]}");
      }

      print(
          "\nDo you want to fetch one of these books?\nType the number of the book you want to fetch the info of\nOr 'BACK' to search another one");

      while (true) {
        var input = stdin.readLineSync();
        if (input?.toUpperCase() == "EXIT") {
          functionExit();
        } else if (input?.toUpperCase() == "BACK") {
          break;
        } else {
          try {
            int bookIndex = int.parse(input!) - 1;
            if (bookIndex >= 0 && bookIndex < books.length) {
              var selectedBook = books[bookIndex];
              await functionFetchBook(selectedBook);
              break;
            } else {
              print("Please provide a valid number.");
            }
          } catch (e) {
            print("Please give a valid input :[");
          }
        }
      }
    } else {
      print("Failed to load data.");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}

Future<void> functionTitle(String titleName) async {
  List<String> waitingMessages = [
    "\nPlease wait, we'll check $titleName in our collection",
    "\nHmm.. Are you sure that $titleName exists?",
    "\nOkay, we'll search manually if you insist *pout*",
    "\nWait, this is close enough...",
    "\nWaiittt.... Let me check the inside",
    "\nOkay, this isn't it",
    "\nWait- Maybe this is $titleName?",
    "\nOkay, yeah, I get nothing :["
  ];
  // Create a Completer to control the waiting messages
  var completer = Completer<void>();

  // Start showing waiting messages
  showWaitingMessages(waitingMessages, completer);

  try {
    var url =
        "https://openlibrary.org/search.json?title=${Uri.encodeComponent(titleName)}";
    var response = await http.get(Uri.parse(url));

    // Complete the completer when the API response is received
    completer.complete();

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var books = data["docs"];
      print("Books found: ${books.length}");

      for (int i = 0; i < books.length; i++) {
        print("${i + 1}. ${books[i]["title"]}");
      }

      print(
          "\nDo you want to fetch one of these books?\nType the number of the book you want to fetch the info of\nOr 'BACK' to search another author");

      while (true) {
        var input = stdin.readLineSync();
        if (input?.toUpperCase() == "EXIT") {
          functionExit();
        } else if (input?.toUpperCase() == "BACK") {
          break;
        } else {
          try {
            int bookIndex = int.parse(input!) -
                1; // Convert input to int and adjust for zero-based index
            if (bookIndex >= 0 && bookIndex < books.length) {
              var selectedBook = books[bookIndex];
              await functionFetchBook(selectedBook);
              break;
            } else {
              print(
                  "Please provide a valid number."); // This will trigger if input is out of range
            }
          } catch (e) {
            print(
                "Please give a valid input :["); // This will trigger if parsing fails
          }
        }
      }
    } else {
      print("Failed to load data.");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}

// Suggested code may be subject to a license. Learn more: ~LicenseLog:3129574488.
void main() async {
  print(
      'Welcome to Rookie Book Club\nHow tough are you? In reading of course~ *wink wink* (1-10)\nThis app will help you to count the time you may need to finish the book\nYou can type "EXIT" to exit the app anytime you want');
  var toughness = stdin.readLineSync();
  if (toughness?.toUpperCase() == "EXIT") {
    functionExit();
  } else if (toughness != null &&
      int.tryParse(toughness) != null &&
      int.parse(toughness) > 0 &&
      int.parse(toughness) <= 10) {
    readingSkillLevel = functionToughness(int.parse(toughness));
  } else {
    print("I'll take it as you are excited. Yay.");
    readingSkillLevel = 1;
  }
  print(
      "\nDo you wanna start by author or title? Type 'AUTHOR' or 'TITLE' to continue");
  while (true) {
    var authorOrTitle = stdin.readLineSync();
    if (authorOrTitle?.toUpperCase() == "EXIT") {
      functionExit();
    } else if (authorOrTitle?.toUpperCase() == "AUTHOR") {
      print("\nWhat's the author's name? Type 'BACK' to go back");
      while (true) {
        var authorName = stdin.readLineSync();
        if (authorName?.toUpperCase() == "EXIT") {
          functionExit();
        } else if (authorName?.toUpperCase() == "BACK") {
          break;
        } else if (authorName != null) {
          await functionAuthor(authorName!);
          print("\nHow about another author?\nOr 'BACK' to go back");
        } else {
          print("Please give an input :[");
        }
      }
    } else if (authorOrTitle?.toUpperCase() == "TITLE") {
      print("\nWhat's the title? Type 'BACK' to go back");
      while (true) {
        var titleName = stdin.readLineSync();
        if (titleName?.toUpperCase() == "EXIT") {
          functionExit();
        } else if (titleName?.toUpperCase() == "BACK") {
          break;
        } else if (titleName != null) {
          await functionTitle(titleName!);
          print("\nHow about another title?");
        } else {
          print("Please give an input :[");
        }
      }
    }
    print(
        "\nHow about another title or author? Type 'AUTHOR' or 'TITLE' to continue");
  }
}
