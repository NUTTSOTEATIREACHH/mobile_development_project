import './book_service.dart';
import '../model/book.dart';

class FavoriteService extends BookService {
  void addFavorite(String bookId) {
    Book? found = getBookbyId(bookId);
    if (found == null) {
      throw Exception('Book cannot be found.');
    }

    if (found.isFavorite == true) {
      throw Exception('Book is already favorited.');
    }

    found.isFavorite = true;
    bookList[bookList.indexWhere((p) => p.id == found.id)] = found;
  }

  void removeFavorite(String bookId) {
    Book? found = getBookbyId(bookId);
    if (found == null) {
      throw Exception('Book cannot be found.');
    }

    if (found.isFavorite == false) {
      throw Exception('Book is already not favorited.');
    }

    found.isFavorite = false;
    bookList[bookList.indexWhere((p) => p.id == found.id)] = found;
  }

  List<Book> getFavoriteBooks() {
    List<Book> result = [];
    for (Book b in bookList) {
      if (b.isFavorite == true) {
        result.add(b);
      }
    }

    return result;
  }

  bool isFavorite(String bookId) {
    Book? found = getBookbyId(bookId);
    if (found == null) {
      throw Exception('Book cannot be found.');
    }

    return found.isFavorite;
  }
}