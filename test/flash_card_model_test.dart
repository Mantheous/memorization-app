import 'package:test/test.dart';
import 'package:memorization_app/data/book_model.dart';
import 'package:memorization_app/models/scripture_reference_model.dart';
import 'package:memorization_app/models/flashcard_model.dart';
void main() {
  group('FlashCard Model', () {

    group('FlashCard from String', () {
      test('should correctly create a FlashCard from a string reference', () {
        // Act
        final card = FlashCard.fromString("1N3:7");

        // Assert
        
        expect(card.ref, ScriptureReference(book: Book.nephiOne, chapter: 3, verse: 7));
        expect(card.targetRetention, 0);
        expect(card.dueDate!.day, DateTime.now().day);
        expect(card.lastReview, null);
        expect(card.passingSplit, null);
      });

      test('should correctly create a FlashCard from a string reference from the Bible', () {
        // Act
        final card = FlashCard.fromString("Hos2:3");

        // Assert

        expect(card.ref, ScriptureReference(book: Book.hosea, chapter: 2, verse: 3));
        expect(card.targetRetention, 0);
        expect(card.dueDate!.day, DateTime.now().day);
        expect(card.lastReview, null);
        expect(card.passingSplit, null);
      });
    });
  });
}