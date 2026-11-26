import 'package:flutter_test/flutter_test.dart';
import 'package:project/model/book.dart';
import 'package:project/service/book_service.dart';

void main() {
  // ==========================================
  // BOOK MODEL TESTS
  // ==========================================

  group('Book Model Tests', () {
    test('Should create a book with valid information', () {
      final book = Book(
        id: 'b1',
        title: 'Dart Basics',
        author: 'A. Kim',
        totalPages: 100,
      );

      expect(book.id, 'b1');
      expect(book.title, 'Dart Basics');
      expect(book.author, 'A. lola');
      expect(book.totalPages, 100);
    });

    test('Should throw an exception when title is empty', () {
      expect(
        () => Book(
          id: 'b1',
          title: '',
          author: 'A. lola',
          totalPages: 100,
        ),
        throwsA(
          predicate(
            (e) => e.toString() == 'Exception: Title must not be empty.',
          ),
        ),
      );
    });

    test('Should throw an exception when total pages is zero', () {
      expect(
        () => Book(
          id: 'b1',
          title: 'Dart Basics',
          author: 'A. lola',
          totalPages: 0,
        ),
        throwsA(
          predicate(
            (e) =>
                e.toString() ==
                'Exception: Total Pages must be greater than zero.',
          ),
        ),
      );
    });

    test('Should throw an exception when total pages is negative', () {
      expect(
        () => Book(
          id: 'b1',
          title: 'Dart Basics',
          author: 'A. lola',
          totalPages: -10,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('Should initialize default values correctly', () {
      final book = Book(
        id: 'b1',
        title: 'Flutter Guide',
        author: 'John',
        totalPages: 200,
      );

      expect(book.isFavorite, false);
      expect(book.readingActivity, isEmpty);
      expect(book.readingProgress.bookId, 'b1');
      expect(book.readingProgress.currentpage, 0);
      expect(book.readingProgress.percentage, 0);
    });
  });

  // ==========================================
  // BOOK SERVICE TESTS
  // ==========================================

  group('BookService Tests', () {
    late BookService bookService;
    late Book book;

    setUp(() {
      bookService = BookService();

      book = Book(
        id: 'b1',
        title: 'Dart Basics',
        author: 'A. lola',
        totalPages: 100,
      );
    });

    test('Should add a book to the book list', () {
      bookService.addBook(book);

      expect(bookService.bookList.length, 1);
      expect(bookService.bookList.first.title, 'Dart Basics');
    });

    test('Should throw an exception when adding a duplicate book', () {
      bookService.addBook(book);

      expect(
        () => bookService.addBook(book),
        throwsA(
          predicate(
            (e) => e.toString() == 'Exception: Book already exists.',
          ),
        ),
      );

      expect(bookService.bookList.length, 1);
    });

    test('Should return all books', () {
      final book2 = Book(
        id: 'b2',
        title: 'Flutter Guide',
        author: 'John',
        totalPages: 200,
      );

      bookService.addBook(book);
      bookService.addBook(book2);

      final result = bookService.getAllBooks();

      expect(result.length, 2);
      expect(result[0].id, 'b1');
      expect(result[1].id, 'b2');
    });

    test('Should find a book by its ID', () {
      bookService.addBook(book);

      final result = bookService.getBookbyId('b1');

      expect(result, isNotNull);
      expect(result!.title, 'Dart Basics');
    });

    test('Should return null when book ID does not exist', () {
      final result = bookService.getBookbyId('b99');

      expect(result, isNull);
    });

    test('Should update an existing book', () {
      bookService.addBook(book);

      final updatedBook = Book(
        id: 'b1',
        title: 'Advanced Dart',
        author: 'David',
        totalPages: 150,
      );

      bookService.updateBook(updatedBook);

      final result = bookService.getBookbyId('b1');

      expect(result!.title, 'Advanced Dart');
      expect(result.author, 'David');
      expect(result.totalPages, 150);
    });

    test('Should throw an exception when updating a missing book', () {
      final newBook = Book(
        id: 'b99',
        title: 'New Book',
        author: 'David',
        totalPages: 100,
      );

      expect(
        () => bookService.updateBook(newBook),
        throwsA(
          predicate(
            (e) => e.toString() == 'Exception: Book cannot be found.',
          ),
        ),
      );
    });

    test('Should delete an existing book', () {
      bookService.addBook(book);

      bookService.deleteBook('b1');

      expect(bookService.bookList, isEmpty);
      expect(bookService.getBookbyId('b1'), isNull);
    });

    test('Should throw an exception when deleting a missing book', () {
      expect(
        () => bookService.deleteBook('b99'),
        throwsA(
          predicate(
            (e) => e.toString() == 'Exception: Book cannot be found.',
          ),
        ),
      );
    });
  });
}
