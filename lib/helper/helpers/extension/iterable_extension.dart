extension IterableExtension on Iterable {
  bool containsAny(Iterable<Object?> other) => other.any((element) => contains(element));
}
