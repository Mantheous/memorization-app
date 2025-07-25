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
      id: availableId++, // I don't know if this works
      ref: ScriptureReference(
        book: Book.values[json['book'] as int],
        chapter: json['chapter'] as int,
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
}
