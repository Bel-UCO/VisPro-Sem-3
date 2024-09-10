import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

Future<void> fetchBooksByTitle(String title) async {
  try {
    var url =
        "https://openlibrary.org/search.json?title=${Uri.encodeComponent(title)}";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var books = data['docs'];

      if (books.isNotEmpty) {
        print("Books found:");
        for (var book in books) {
          String bookTitle = book['title'] ?? "Unknown Title";
          dynamic numberOfPages =
              book['isbn'] ?? 0; // Use a default value if not present

          print(
              "Title: $bookTitle, Number of Pages: ${numberOfPages > 0 ? numberOfPages : 'N/A'}");
        }
      } else {
        print("No books found matching the title '$title'.");
      }
    } else {
      print("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {
    print("An error occurred: $e");
  }
}

void main() async {
  print("Enter a book title to search:");
  String? titleToSearch = stdin.readLineSync();

  if (titleToSearch != null && titleToSearch.isNotEmpty) {
    await fetchBooksByTitle(titleToSearch);
  } else {
    print("Please enter a valid title.");
  }
}
