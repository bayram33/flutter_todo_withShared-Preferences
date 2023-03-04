import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo2/item_card.dart';
import 'package:todo2/models/items_data.dart';
import 'package:todo2/settings_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  ));
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
        title: const Text("TO DO 2"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            context: context,
            // ignore: avoid_unnecessary_containers
            builder: (context) => Container(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      minLines: 1,
                      maxLines: 3,
                      controller: textController,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Add New Item",
                          labelText: "Click Here"),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<ItemData>(context, listen: false)
                            .addItem(textController.text);
                        Navigator.pop(context);
                        textController.clear();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green[500]),
                      child: const Text(
                        "Add",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "${Provider.of<ItemData>(context).items.length} Items",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<ItemData>(
                    builder: (context, data, child) => Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: data.items.length,
                        itemBuilder: (context, index) => ItemCard(
                          title: data.items[index].title,
                          isDone: data.items[index].isDone,
                          toggleStatus: (_) {
                            data.toggleStatus(index);
                          },
                          // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                          deleteItem: (DismissDirection) {
                            data.deleteItem(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
