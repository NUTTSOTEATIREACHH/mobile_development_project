import 'package:project/model/reading_progress.dart';
import 'package:project/service/reading_streak_service.dart';

import '../model/book.dart';

class ReadingProgressService extends ReadingStreakService{
  void updateCurrentPage(String bookId, int page) {
    Book? found = getBookbyId(bookId);
    if (found == null) {
      throw Exception('Book cannot be found.');
    }

    if (page > 0 || page > found.readingProgress.currentpage || page > found.totalPages) {
      found.readingProgress.currentpage = page;
      calculateProgress(found);
      recordReadingActivity(found, DateTime.now(), page);
    } else {
      throw Exception('Invaild Page Change');
    }

    bookList[bookList.indexWhere((p) => p.id == found.id)] = found;
  }

  void calculateProgress(Book book) {
    book.readingProgress.percentage = (book.readingProgress.currentpage / book.totalPages) * 100;
    if (book.readingProgress.percentage == 100) {
      _setReadingStatus(book, status.finished);
    } else {
      _setReadingStatus(book, status.reading);
    }
  }

  void _setReadingStatus(Book book, status newStatus) {
    book.readingProgress.currentStatus = newStatus;
  }

  String getProgressText(String bookId) {
    for (Book b in bookList) {
      if (b.id == bookId) {
        return "Reading Percentage" + b.readingProgress.percentage.round().toString() + "%";
      }
    }

    throw Exception('Book cannot be found');
  }
}