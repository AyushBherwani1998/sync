import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Item<T> {
  String title;
  T? data;

  Item({
    required this.title,
    this.data,
  });
}

class ItemList<T> extends StatefulWidget {
  final List<Item<T>> itemList;
  final void Function(Item<T>) onItemSelect;
  final String title;

  const ItemList({
    required this.onItemSelect,
    required this.itemList,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  State<ItemList<T>> createState() => _ItemListState<T>();
}

class _ItemListState<T> extends State<ItemList<T>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          12.heightBox,
          ListTile(
            title: widget.title.text.size(20).semiBold.make(),
          ),
          4.heightBox,
          Expanded(
            child: ListView.builder(
              itemCount: widget.itemList.length,
              itemBuilder: (context, index) {
                return OutlinedButton(
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 28,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    widget.onItemSelect.call(widget.itemList[index]);
                  },
                  child: widget.itemList[index].title.text
                      .size(16)
                      .color(Colors.white)
                      .make(),
                ).p8();
              },
            ),
          ),
        ],
      ),
    );
  }
}
