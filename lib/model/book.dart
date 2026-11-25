import './reading_progress.dart';
import './reading_activity.dart';

class Book {
    final String id;
    late String title;
    String author;
    late int totalPages;
    List<ReadingActivity> readingActivity = [];
    late ReadingProgress readingProgress = ReadingProgress(bookId: id);
    String? coverImagePath;
    bool isFavorite = false;

    Book({required this.id, required String title, required this.author, required int totalPages, this.coverImagePath}) {
      if (title.isEmpty) {
        throw Exception('Title must not be empty.');
      }
      this.title = title;

      if (totalPages <= 0) {
        throw Exception('Total Pages must be greater than zero.');
      }
      this.totalPages = totalPages;
    }

}