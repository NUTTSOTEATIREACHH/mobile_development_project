import 'package:project/model/reading_activity.dart';
import 'package:project/service/book_service.dart';
import '../model/book.dart';

class ReadingStreakService extends BookService{
  int currentStreak = 0;
  int longestStreak = 0;
  List<DateTime> readingDays = [];

  void recordReadingActivity(Book book, DateTime date, int pagesRead) {
    book.readingActivity.add(ReadingActivity(id: (book.readingActivity.length + 1).toString(), bookId: book.id, activityDate: date, pagesRead: pagesRead));

    // Convert DateTime to just only the DMY
    // Then add the dmy to reading days if it's not already there
    DateTime dmy = DateTime.utc(date.year, date.month, date.day);
    for (DateTime dt in readingDays) {
      if (dt != dmy) {
        readingDays.add(dmy);
      }
    }
  }

  int getCurrentStreak() {
    return currentStreak;
  }

  int getLongestStreak() {
    return longestStreak;
  }

  List<DateTime> getReadingDays(DateTime start, DateTime end) {
    DateTime startdmy = DateTime.utc(start.year, start.month, start.day - 1);
    DateTime enddmy = DateTime.utc(start.year, start.month, start.day + 1);

    List<DateTime> result = [];
    for (DateTime dt in readingDays) {
      if (dt.isAfter(startdmy) && dt.isBefore(enddmy)) {
        result.add(dt);
      }
    }

    return result;
  }

  void recalculateStreaks() {
    int recordedStreak = 0;

    if (readingDays.length == 1) {
      recordedStreak = 0;
    } else {
      for (int i = 0; i < readingDays.length - 1; i++) {
        if (readingDays[i + 1].difference(readingDays[i]) == Duration(days: 1)) {
          recordedStreak++;
        } else {
          recordedStreak = 0;
        }
      }
    }

    currentStreak = recordedStreak;

    if (currentStreak < longestStreak) {
      longestStreak = currentStreak;
    }
  }

}