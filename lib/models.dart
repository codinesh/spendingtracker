// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:spending_tracker/core/uuid.dart';
import 'package:spending_tracker/models/category.dart';
import 'package:spending_tracker/models/spending_entity.dart';

enum AppTab { todos, stats }

enum ExtraAction { toggleAllComplete, clearCompleted }

class Spending {
  final String id;
  final String note;
  final String title;
  final SpendingCategory category;
  final PurchaseType purchaseType;

  Spending(this.title,
      {this.note = "",
      this.category = SpendingCategory.Electronics,
      this.purchaseType = PurchaseType.FullPay,
      id})
      : id = id ?? Uuid().generateV4();

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
      other is Spending &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          note == other.note &&
          id == other.id;

  @override
  String toString() {
    return 'Todo{complete: task: $title, note: $note, id: $id}';
  }

  SpendingEntity toEntity() {
    return SpendingEntity(id, note, title, category, purchaseType);
  }

  static Spending fromEntity(SpendingEntity entity) {
    return Spending(entity.title,
        note: entity.note,
        id: entity.id,
        category: entity.category,
        purchaseType: entity.purchaseType);
  }

  Spending copy(
      {String title,
      String note,
      String id,
      SpendingCategory category,
      PurchaseType purchasType}) {
    return Spending(title ?? this.title,
        note: note ?? this.note,
        id: id ?? this.id,
        category: category ?? this.category,
        purchaseType: purchaseType ?? this.purchaseType);
  }
}
