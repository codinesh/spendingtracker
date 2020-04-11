import 'package:spending_tracker/models/category.dart';

class SpendingEntity {
  final String id;
  final String note;
  final String title;
  final SpendingCategory category;
  final PurchaseType purchaseType;

  SpendingEntity(
      this.id, this.note, this.title, this.category, this.purchaseType);

  @override
  int get hashCode =>
      id.hashCode ^
      note.hashCode ^
      title.hashCode ^
      category.hashCode ^
      purchaseType.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpendingEntity &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          note == other.note &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      'title': title,
      'note': note,
      'id': id,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{complete: title: $title, note: $note, id: $id}';
  }

  static SpendingEntity fromJson(Map<String, Object> json) {
    return SpendingEntity(
      json['id'] as String,
      json['note'] as String,
      json['title'] as String,
      json['category'] as SpendingCategory,
      json['PurchaseType'] as PurchaseType,
    );
  }
}
