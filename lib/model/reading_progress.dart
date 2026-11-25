enum status {unread, reading, finished}

class ReadingProgress {
  String bookId;
  int currentpage = 0;
  double percentage = 0;
  status currentStatus = status.unread;

  ReadingProgress({required this.bookId});
}