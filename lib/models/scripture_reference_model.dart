import '../data/book_model.dart';
import '../data/publication_map.dart';

class ScriptureReference {
  final Publication? publication;
  final Book book;
  final int chapter;
  final int verse;

 ScriptureReference({
    required this.book,
    required this.chapter,
    required this.verse,
  }) : publication = bookPublicationMap[book];
  // Publication is always determined by the book

  factory ScriptureReference.fromString(String ref) {
    // Correct format is "1N3:7" or "En15"
    // Should throw FormatException if the format is incorrect

    final tRef = ref.trim();
    if (tRef.isEmpty) {
      throw FormatException("Input string cannot be empty.", tRef);
    }
    final bookAbbr = Book.bookMap.keys.firstWhere(
    (key) => tRef.startsWith(key),
      orElse: () => throw FormatException("Unknown book abbreviation.", tRef),
    );
    final numbersPart = tRef.substring(bookAbbr.length);

    if(numbersPart.contains(":")) {
      return ScriptureReference(
        book: Book.bookMap[bookAbbr]!,
        chapter: int.parse(numbersPart.split(":")[0]),
        verse: int.parse(numbersPart.split(":")[1]),
      );
    }else {
      return ScriptureReference(book: Book.bookMap[bookAbbr]!, chapter: 1, verse: int.parse(numbersPart));
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScriptureReference &&
          runtimeType == other.runtimeType &&
          publication == other.publication &&
          book == other.book &&
          chapter == other.chapter &&
          verse == other.verse;

  @override
  int get hashCode =>
      publication.hashCode ^ book.hashCode ^ chapter.hashCode ^ verse.hashCode;

  // Also useful for debugging tests:
  @override
  String toString() {
    return 'ScriptureReference{book: $book, chapter: $chapter, verse: $verse, publication: $publication}';
  }
}

