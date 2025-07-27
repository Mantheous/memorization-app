import 'scripture_reference_model.dart';

class FlashCard {
  static int availableId = 0;

  final int? id;
  final ScriptureReference ref;
  final int? targetRetention;
  final DateTime? dueDate;
  final DateTime? lastReview;
  final int? passingSplit;
  final int? index;

  const FlashCard({
    this.id,
    required this.ref,
    this.targetRetention,
    this.dueDate,
    this.lastReview,
    this.passingSplit,
    this.index,
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
      index: json['index'] as int?,
    );

  }

  factory FlashCard.fromString(String ref) {
    // TODO: Make FlashCard.fromString
    return FlashCard(ref: ScriptureReference(
      book: Book.nephiOne, // Placeholder, implement logic to parse ref
      chapter: 1, // Placeholder, implement logic to parse ref
      verse: 1, // Placeholder, implement logic to parse ref
    ));
  }
}
