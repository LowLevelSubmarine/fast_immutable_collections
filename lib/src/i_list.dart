import 'l1.dart';
import 'l2.dart';
import 'l3.dart';

// /////////////////////////////////////////////////////////////////////////////////////////////////

extension IListExtension<T> on Iterable<T> {
  IList<T> get lock => IList<T>(this);
}

// /////////////////////////////////////////////////////////////////////////////////////////////////

class IList<T> implements Iterable<T> {
  L<T> _l;

  factory IList([Iterable<T> iterable]) =>
      (iterable is IList) ? (iterable as IList) : IList._(iterable);

  IList._([Iterable<T> iterable])
      : _l = (iterable is IList)
            ? (iterable as IList)._l
            : L1(iterable == null ? const [] : List.of(iterable));

  IList.__(this._l);

  List<T> get unlock => List.of(_l);

  @override
  Iterator<T> get iterator => _l.iterator;

  bool get isEmpty => _l.isEmpty;

  bool get isNotEmpty => !isEmpty;

  // --- IList methods: ---------------

  /// Compacts the list.
  void flush() {
    if (!isFlushed) _l = L1(List.of(_l));
  }

  bool get isFlushed => _l is L1;

  IList add(T item) => IList.__(_l.add(item));

  IList addAll(Iterable<T> items) => IList.__(_l.addAll(items));

  // --- Iterable methods: ---------------

  @override
  bool any(bool Function(T) test) => _l.any(test);

  @override
  IList<R> cast<R>() => _l.cast<R>();

  @override
  bool contains(Object element) => _l.contains(element);

  @override
  elementAt(int index) => _l.elementAt(index);

  @override
  bool every(bool Function(T) test) => _l.every(test);

  @override
  IList<E> expand<E>(Iterable<E> Function(T) f) => _l.expand(f);

  @override
  int get length => _l.length;

  @override
  get first => _l.first;

  @override
  T get last => _l.last;

  @override
  T get single => _l.single;

  @override
  firstWhere(bool Function(T) test, {Function() orElse}) => _l.firstWhere(test, orElse: orElse);

  @override
  E fold<E>(E initialValue, E Function(E previousValue, T element) combine) =>
      _l.fold(initialValue, combine);

  @override
  IList<T> followedBy(Iterable<T> other) => _l.followedBy(other);

  @override
  void forEach(void Function(T element) f) => _l.forEach(f);

  @override
  String join([String separator = ""]) => _l.join(separator);

  @override
  T lastWhere(bool Function(T element) test, {T Function() orElse}) =>
      _l.lastWhere(test, orElse: orElse);

  @override
  IList<E> map<E>(E Function(T e) f) => _l.map(f);

  @override
  T reduce(T Function(T value, T element) combine) => _l.reduce(combine);

  @override
  T singleWhere(bool Function(T element) test, {T Function() orElse}) =>
      _l.singleWhere(test, orElse: orElse);

  @override
  IList<T> skip(int count) => _l.skip(count);

  @override
  IList<T> skipWhile(bool Function(T value) test) => _l.skipWhile(test);

  @override
  IList<T> take(int count) => _l.take(count);

  @override
  IList<T> takeWhile(bool Function(T value) test) => _l.takeWhile(test);

  @override
  List<T> toList({bool growable = true}) => _l.toList(growable: growable);

  @override
  Set<T> toSet() => _l.toSet();

  @override
  IList<T> where(bool Function(T element) test) => _l.where(test);

  @override
  IList<E> whereType<E>() => _l.whereType<E>();
}

// /////////////////////////////////////////////////////////////////////////////////////////////////

abstract class IterableL<T> implements Iterable<T> {
  //
  @override
  bool any(bool Function(T) test);

  @override
  IList<R> cast<R>();

  @override
  bool contains(Object element);

  @override
  elementAt(int index);

  @override
  bool every(bool Function(T) test);

  @override
  IList<E> expand<E>(Iterable<E> Function(T) f);

  @override
  int get length;

  @override
  get first;

  @override
  T get last;

  @override
  T get single;

  @override
  firstWhere(bool Function(T) test, {Function() orElse});

  @override
  E fold<E>(E initialValue, E Function(E previousValue, T element) combine);

  @override
  IList<T> followedBy(Iterable<T> other);

  @override
  void forEach(void Function(T element) f);

  @override
  String join([String separator = ""]);

  @override
  T lastWhere(bool Function(T element) test, {T Function() orElse});

  @override
  IList<E> map<E>(E Function(T e) f);

  @override
  T reduce(T Function(T value, T element) combine);

  @override
  T singleWhere(bool Function(T element) test, {T Function() orElse});

  @override
  IList<T> skip(int count);

  @override
  IList<T> skipWhile(bool Function(T value) test);

  @override
  IList<T> take(int count);

  @override
  IList<T> takeWhile(bool Function(T value) test);

  @override
  List<T> toList({bool growable = true});

  @override
  Set<T> toSet();

  @override
  IList<T> where(bool Function(T element) test);

  @override
  IList<E> whereType<E>();
}

// /////////////////////////////////////////////////////////////////////////////////////////////////

abstract class L<T> implements IterableL<T> {
  //
  /// The [L] class provides the default fallback methods of Iterable, but
  /// ideally all of its methods are implemented in all of its subclasses.
  /// Note these fallback methods need to calculate the flushed list, but
  /// because that's immutable, we cache it.
  List<T> _flushed;

  List<T> get _getFlushed {
    _flushed ??= unlock;
    return _flushed;
  }

  /// Returns a regular Dart (mutable) List.
  List<T> get unlock => List.of(this);

  @override
  Iterator<T> get iterator;

  bool get isNotEmpty => !isEmpty;

  L add(T item) => L2(this, item);

  L addAll(Iterable<T> items) => L3(this, items);

  bool get isEmpty => _getFlushed.isEmpty;

  @override
  bool any(bool Function(T) test) => _getFlushed.any(test);

  @override
  IList<R> cast<R>() => throw UnsupportedError('cast');

//  IList<R> cast<R>() => _getFlushed.cast<R>();

  @override
  bool contains(Object element) => _getFlushed.contains(element);

  @override
  elementAt(int index) => _getFlushed.elementAt(index);

  @override
  bool every(bool Function(T) test) => _getFlushed.every(test);

  @override
  IList<E> expand<E>(Iterable<E> Function(T) f) => IList._(_getFlushed.expand(f));

  @override
  int get length => _getFlushed.length;

  @override
  get first => _getFlushed.first;

  @override
  T get last => _getFlushed.last;

  @override
  T get single => _getFlushed.single;

  @override
  firstWhere(bool Function(T) test, {Function() orElse}) =>
      _getFlushed.firstWhere(test, orElse: orElse);

  @override
  E fold<E>(E initialValue, E Function(E previousValue, T element) combine) =>
      _getFlushed.fold(initialValue, combine);

  @override
  IList<T> followedBy(Iterable<T> other) => IList._(_getFlushed.followedBy(other));

  @override
  void forEach(void Function(T element) f) => _getFlushed.forEach(f);

  @override
  String join([String separator = ""]) => _getFlushed.join(separator);

  @override
  T lastWhere(bool Function(T element) test, {T Function() orElse}) =>
      _getFlushed.lastWhere(test, orElse: orElse);

  @override
  IList<E> map<E>(E Function(T e) f) => IList._(_getFlushed.map(f));

  @override
  T reduce(T Function(T value, T element) combine) => _getFlushed.reduce(combine);

  @override
  T singleWhere(bool Function(T element) test, {T Function() orElse}) =>
      _getFlushed.singleWhere(test, orElse: orElse);

  @override
  IList<T> skip(int count) => IList._(_getFlushed.skip(count));

  @override
  IList<T> skipWhile(bool Function(T value) test) => IList._(_getFlushed.skipWhile(test));

  @override
  IList<T> take(int count) => IList._(_getFlushed.take(count));

  @override
  IList<T> takeWhile(bool Function(T value) test) => IList._(_getFlushed.takeWhile(test));

  @override
  IList<T> where(bool Function(T element) test) => IList._(_getFlushed.where(test));

  @override
  IList<E> whereType<E>() => IList._(_getFlushed.whereType<E>());

  @override
  List<T> toList({bool growable = true}) => List.of(this, growable: growable);

  @override
  Set<T> toSet() => Set.of(this);
}

// /////////////////////////////////////////////////////////////////////////////////////////////////