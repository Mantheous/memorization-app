import 'scripture_reference_model.dart';
import '../data/book_model.dart';

class FlashCard {
  static int availableId = 0;

  final int? id;
  // TODO: Create Reference Class. ScriptureReference should extend the reference class.
  final ScriptureReference ref;
  final int? targetRetention;
  final DateTime? dueDate;
  final DateTime? lastReview;
  final int? passingSplit;
  final int? chapterIndex;

  const FlashCard({
    this.id,
    required this.ref,
    this.targetRetention,
    this.dueDate,
    this.lastReview,
    this.passingSplit,
    this.chapterIndex,
  });

  factory FlashCard.fromJson(Map<String, dynamic> json) {
    return FlashCard(
      //id: availableId++, // It is probably better to have the database assign the id
      ref: ScriptureReference(
        book: Book.values[json['book']],
        chapter: json['chapter'] as int,
        verse: json['verse'] as int,
      ),
      targetRetention: json['targetRetention'] as int?,
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
      lastReview: json['lastReview'] != null
          ? DateTime.parse(json['lastReview'] as String)
          : null,
      passingSplit: json['passingSplit'] as int?,
      chapterIndex: json['index'] as int?,
    );

  }

  factory FlashCard.fromString(String ref) {
    final sRef = ScriptureReference.fromString(ref);
    return FlashCard(ref: sRef,
      targetRetention: 0,
      dueDate: DateTime.now(),
      lastReview: null,
      passingSplit: null,
  );}
}
