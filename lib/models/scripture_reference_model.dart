class ScriptureReference {
  final Publication? publication;
  final Book book;
  final int chapter;
  final int verse;
  static const Map<Book, Publication> _bookPublicationMap = {
    Book.nephiOne: Publication.bookOfMormon,
    Book.nephiTwo: Publication.bookOfMormon,
    Book.jacob: Publication.bookOfMormon,
    Book.enos: Publication.bookOfMormon,
    Book.jarom: Publication.bookOfMormon,
    Book.omni: Publication.bookOfMormon,
    Book.wordsofmormon: Publication.bookOfMormon,
    Book.mosiah: Publication.bookOfMormon,
    Book.alma: Publication.bookOfMormon,
    Book.helaman: Publication.bookOfMormon,
    Book.nephiThree: Publication.bookOfMormon,
    Book.nephiFour: Publication.bookOfMormon,
    Book.mormon: Publication.bookOfMormon,
    Book.ether: Publication.bookOfMormon,
    Book.moroni: Publication.bookOfMormon,
    Book.dandc: Publication.doctrineAndCovenants,
    Book.moses: Publication.pearlOfGreatPrice,
    Book.abraham: Publication.pearlOfGreatPrice,
    Book.josephsmithhistory: Publication.pearlOfGreatPrice,
    Book.articlesoffaith: Publication.pearlOfGreatPrice,
  };

 ScriptureReference({
    required this.book,
    required this.chapter,
    required this.verse,
  }) : publication = _bookPublicationMap[book];
  // Publication is always determined by the book

  factory ScriptureReference.fromString(String ref) {
    // Correct format is "1N3:7" or "En15"
    // Should throw FormatException if the format is incorrect

    const numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    final tRef = ref.trim();

    if(numbers.contains(tRef[2])) {
      final bookFrag = tRef.substring(0,2);

      // Handle rare edge cases in my format
      if (bookFrag == "En") {
        return ScriptureReference(book: Book.enos, chapter: 1, verse: tRef.substring(3) as int);
      } else if (bookFrag == "4N") {
        return ScriptureReference(book: Book.nephiFour, chapter: 1, verse: tRef.substring(3) as int);
      } else {
        final chapterVerse = tRef.substring(2).split(":");
        return ScriptureReference(book: Book.bookMap[bookFrag]!, chapter: chapterVerse[0] as int, verse: chapterVerse[1] as int);
      }
    }

    return ScriptureReference(
      book: Book.bookMap[tRef.substring(0, 2)]!,
      chapter: tRef.substring(3).split(":")[0] as int,
      verse: tRef.substring(3).split(":")[1] as int,
    );
  }
  
  int get bookIndex {
    // TODO: Determine book index
    return 1; // Placeholder
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

enum Publication {
  oldTestament,
  newTestament,
  bookOfMormon,
  doctrineAndCovenants,
  pearlOfGreatPrice,
}

enum Book{
  nephiOne,
  nephiTwo,
  jacob,
  enos,
  jarom,
  omni,
  wordsofmormon,
  mosiah,
  alma,
  helaman,
  nephiThree,
  nephiFour,
  mormon,
  ether,
  moroni,
  dandc,
  moses,
  abraham,
  josephsmithhistory,
  articlesoffaith;

  // TODO: When inputing a ref we need to do input validation.
  static const Map<String, Book> bookMap = {
    "1N": Book.nephiOne,
    "2N": Book.nephiTwo,
    "Jc": Book.jacob,
    "En": Book.enos,
    "Jrm": Book.jarom,
    "Om": Book.omni,
    "PdM": Book.wordsofmormon,
    "WoM": Book.wordsofmormon,
    "Msh": Book.mosiah,
    "Al": Book.alma,
    "He": Book.helaman,
    "3N": Book.nephiThree,
    "4N": Book.nephiFour,
    "Mrm": Book.mormon,
    "Et": Book.ether,
    "Mri": Book.moroni,
    "D&C": Book.dandc,
    "Mos": Book.moses,
    "Ab": Book.abraham,
    "JSH": Book.josephsmithhistory,
    "AoF": Book.articlesoffaith
  };
}