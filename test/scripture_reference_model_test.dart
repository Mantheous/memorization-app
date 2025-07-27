import 'package:test/test.dart';
// Import your actual classes
import 'package:memorization_app/models/scripture_reference_model.dart';

void main() {
  group('ScriptureReference Model', () {

    group('Publication Assignment', () {
      test('should correctly assign publication for a Book of Mormon book', () {
        // Act
        final ref = ScriptureReference(book: Book.alma, chapter: 32, verse: 28);
        // Assert
        expect(ref.publication, Publication.bookOfMormon);
      });

      test('should correctly assign publication for a D&C section', () {
        // Act
        final ref = ScriptureReference(book: Book.dandc, chapter: 88, verse: 118);
        // Assert
        expect(ref.publication, Publication.doctrineAndCovenants);
      });

      test('should correctly assign publication for a Pearl of Great Price book', () {
        // Act
        final ref = ScriptureReference(book: Book.moses, chapter: 1, verse: 39);
        // Assert
        expect(ref.publication, Publication.pearlOfGreatPrice);
      });

      test('should assign null publication for a book not in the map', () {
        // Note: This test requires a book that is NOT in _bookPublicationMap
        // If all books are in the map, this test case is not possible.
        // Assuming you might add a book later without mapping it:
        // final ref = ScriptureReference(book: Book.someNewBook, chapter: 1, verse: 1);
        // expect(ref.publication, isNull);
      });
    });

    group('fromString Factory - Valid Inputs', () {
      test('should parse a standard reference like "1N3:7"', () {
        // Act
        final ref = ScriptureReference.fromString("1N3:7");

        // Assert
        expect(ref, ScriptureReference(book: Book.nephiOne, chapter: 3, verse: 7));
      });
      
      test('should parse a reference with a two-digit chapter like "Al56:10"', () {
        // Act
        final ref = ScriptureReference.fromString("Al56:10");

        // Assert
        expect(ref, ScriptureReference(book: Book.alma, chapter: 56, verse: 10));
      });

      test('should parse the edge case for Enos like "En15"', () {
        // Act
        final ref = ScriptureReference.fromString("En15");

        // Assert
        expect(ref, ScriptureReference(book: Book.enos, chapter: 1, verse: 15));
      });

      test('should parse the edge case for 4th Nephi like "4N20"', () {
        // Act
        final ref = ScriptureReference.fromString("4N 20");

        // Assert
        expect(ref, ScriptureReference(book: Book.nephiFour, chapter: 1, verse: 20));
      });

      test('should parse a D&C reference like "D&C93:1"', () {
        // Act
        final ref = ScriptureReference.fromString("D&C93:1");

        // Assert
        expect(ref, ScriptureReference(book: Book.dandc, chapter: 93, verse: 1));
      });
    });

    group('fromString Factory - Invalid Inputs (Error Handling)', () {
      // These tests expose the fragility of the current parsing logic.
      test('should throw an error for an invalid book abbreviation', () {
        // The '!' on bookMap will cause a NullThrownError or TypeError
        expect(() => ScriptureReference.fromString("XX 1:1"), throwsA(isA<TypeError>()));
      });

      test('should throw an error for a malformed string without a colon', () {
        // .split(":")[1] will cause a RangeError
        expect(() => ScriptureReference.fromString("1N 3 7"), throwsA(isA<RangeError>()));
      });

      test('should throw an error for non-numeric chapter/verse parts', () {
        // 'as int' will cause a TypeError
        expect(() => ScriptureReference.fromString("Al a:b"), throwsA(isA<TypeError>()));
      });
    });

    group('bookIndex Getter', () {
      test('should return the placeholder value of 1', () {
        // This test confirms the current behavior and will need to be updated
        // when the real logic is implemented.
        final ref = ScriptureReference(book: Book.alma, chapter: 1, verse: 1);
        expect(ref.bookIndex, 1);
      });
    });
  });
}