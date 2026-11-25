import '../lib/service/book_service.dart';
import 'package:test/test.dart';

void main() {
  test('normal case 1 (add book to favorites)', () {
    final n = bookService();
    n.addBook(title: '1984', author: 'Orwell', totalPage: 256);
    n.AddBooktoFavorites(title: '1984');

    expect(n.favorites.first.title, '1984');
    expect(n.books.first.title, '1984'); // Should Pass
  });

  test('normal case 2 (remove book from libary, also remove book from favorties)', () {
    final n = bookService();
    n.addBook(title: '1984', author: 'Orwell', totalPage: 256);
    n.AddBooktoFavorites(title: '1984');
    n.removeBook(title: '1984');

    expect(n.favorites.length, 0);
    expect(n.books.length, 0); // Should Pass
  });

  test('normal case 3 (daily streak increment when recording book progress)', () {
    final n = bookService();
    n.addBook(title: '1984', author: 'Orwell', totalPage: 256);

    n.changeBookStatus(title: '1984', currentPage: 10);
    
    expect(n.streak.currentStreak, 1); // Should Pass
  });

  test('invaild case 1 (try to add two of the same books)', () {
    final n = bookService();
    n.addBook(title: '1984', author: 'Orwell', totalPage: 256);
    n.addBook(title: '1984', author: 'Orwell', totalPage: 256);
    // Should Fail
  });

  test('invaild case 2 (try to remove a non existent book)', () {
    final n = bookService();
    n.removeBook(title: '1984'); // Should Fail
  });

  test('invaild case 3 (try to remove a non existent book from favorites)', () {
    final n = bookService();
    n.addBook(title: '1984', author: 'Orwell', totalPage: 256);

    expect(n.favorites.first.title, '1984');
    n.removeBookfromFavorites(title: '1984');
  });

  test('invaild case 4 (try to add non existent book to favorites)', () {
    final n = bookService();
    n.AddBooktoFavorites(title: '1984');
  });
}