import 'package:flutter/material.dart';

class ListModel<E> {
  ListModel(
      {@required this.listKey,
      @required this.removedItemBuilder,
      Iterable<E> initialItems})
      : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = initialItems?.toList() ?? <E>[];

  final GlobalKey<AnimatedListState> listKey;
  final Widget Function(
          E item, BuildContext context, Animation<double> animation)
      removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item, Duration duration) {
    _items.insert(index, item);
    _animatedList.insertItem(index, duration: duration);
  }

  E removeAt(int index, Duration duration) {
    final E removedItem = _items.removeAt(index);

    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
        duration: duration,
      );
    }

    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}