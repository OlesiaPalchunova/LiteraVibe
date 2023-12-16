import '../../models/book.dart';
import '../../models/collection.dart';
import '../book_db.dart';

class CollectionInfo {
  static List<Book> savedCollection = [];
  static Set<int> savedId = {};
  static List<Book> readCollections = [];

  void initCollections() async {
    savedCollection = await BookDB().getLikedBook();
    for (var b in savedCollection) {
      savedId.add(b.id);
    }
    readCollections = await BookDB().getReadBook();
    print("savedCollection.length");
    print(savedCollection.length);
  }


  bool isSaved(int id) {
    return savedId.contains(id);
  }
}