import "package:flutter/material.dart";

// ignore: must_be_immutable
class ItemCard extends StatelessWidget {
  final String title;
  final bool isDone;
  void Function(bool?)? toggleStatus;
  void Function(DismissDirection)? deleteItem;
  ItemCard(
      {super.key,
      required this.title,
      required this.isDone,
      required this.toggleStatus,
      required this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:UniqueKey(),
      onDismissed: deleteItem,
      child: Card(
        color: isDone ? Colors.green[100] : Colors.white,
        elevation: isDone ? 1 : 5,
        shadowColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: isDone ? const Icon(Icons.done) : const Icon(Icons.arrow_forward_ios),
          title: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                decoration:
                    isDone ? TextDecoration.lineThrough : TextDecoration.none),
          ),
          trailing: Checkbox(
            value: isDone,
            onChanged: toggleStatus,
            activeColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
