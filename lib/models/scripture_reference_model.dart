class ScriptureReference {
  final Publication? publication;
  final Book book;
  final int chapter;
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
    Book.bookofmoses: Publication.pearlOfGreatPrice,
    Book.bookofabraham: Publication.pearlOfGreatPrice,
    Book.josephsmithhistory: Publication.pearlOfGreatPrice,
    Book.articlesoffaith: Publication.pearlOfGreatPrice,
  };

 ScriptureReference({
    required this.book,
    required this.chapter,
  }) : publication = _bookPublicationMap[book];

  /*
  This would be really cool to implement, but I don't have the time right now.

  factory ScriptureReference.fromString(String ref) {
    const numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    if(numbers.contains(ref[2])) {
      final bookFrag = ref.substring(0,2);
      if (bookFrag == "En") {
        return ScriptureReference(publication: Publication.bookOfMormon, book: Book.enos, chapter: ref.substring(3) as int);
      }
      if (bookFrag == "4N") {
        return ScriptureReference(publication: Publication.bookOfMormon, book: Book.nephiFour, chapter: ref.substring(3) as int);
      }
    }
    return ScriptureReference(
      // 
    );
  }
  */
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
  bookofmoses,
  bookofabraham,
  josephsmithhistory,
  articlesoffaith,
}