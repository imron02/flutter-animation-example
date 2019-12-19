import 'package:flutter/material.dart';
import 'package:flutter_animation/screen/animated_list/models/list.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final Duration _duration = const Duration(seconds: 1);
  ListModel<int> _list;
  int _selectedItem;
  int _nextItem;

  @override
  void initState() {
    super.initState();
    _list = ListModel<int>(
        listKey: listKey,
        initialItems: <int>[0, 1, 2],
        removedItemBuilder: _buildRemovedItem);
    _nextItem = 3;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _insert() {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);

    _list.insert(index, _nextItem++, _duration);
  }

  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem), _duration);
      setState(() {
        _selectedItem = null;
      });
    }
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
        animation: animation,
        item: _list[index],
        selected: _selectedItem == _list[index],
        onTap: () {
          setState(() {
            _selectedItem = _selectedItem == _list[index] ? null : _list[index];
          });
        });
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(animation: animation, item: item, selected: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'insert a new item',
            onPressed: _insert,
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: _remove,
            tooltip: 'remove the selected item',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedList(
          key: listKey,
          initialItemCount: _list.length,
          itemBuilder: _buildItem,
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected = false})
      : assert(animation != null),
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;

    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);

    return Padding(
      padding: const EdgeInsets.all(2),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeIn),
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 128,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(child: Text('Item $item', style: textStyle)),
            ),
          ),
        ),
      ),
    );
  }
}
