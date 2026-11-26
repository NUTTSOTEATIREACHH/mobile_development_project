import 'package:project/model/reading_progress.dart';

import '../model/book.dart';

class BookService {
  List<Book> bookList = [];

  void addBook(Book book) {
    Book? found = getBookbyId(book.id);
    if (found != null) {
      throw Exception('Book already exists.');
    }
    
    bookList.add(book);
  }

  void updateBook(Book book) {
    Book? found = getBookbyId(book.id);
    if (found == null) {
      throw Exception('Book cannot be found.');
    }

    found.title = book.title;
    found.author = book.author;

    if (found.readingProgress.currentpage > book.totalPages) {
      throw Exception('Book total page cannot be larger than current page');
    }

    // Recalculate Total Pages
    found.totalPages = book.totalPages;
    found.readingProgress.percentage = (found.readingProgress.currentpage / found.totalPages) * 100;
    if (book.readingProgress.percentage == 100) {
      found.readingProgress.currentStatus = status.finished;
    } else {
      found.readingProgress.currentStatus = status.finished;
    }

    bookList[bookList.indexWhere((p) => p.id == found.id)] = found;
  }

  void deleteBook(String bookId) {
    Book? found = getBookbyId(bookId);
    if (found == null) {
      throw Exception('Book cannot be found.');
    }

    bookList.removeWhere((b) => b.id == bookId);
  }

  List<Book> getAllBooks() {
    return bookList;
  }

  Book? getBookbyId(String bookId) {
    for (Book b in bookList) {
      if (b.id == bookId) {
        return b;
      }
    }

    return null;
  }
}