class Item {
  final String title;
  bool isDone;

  Item({required this.title, this.isDone = false});

  void toggleStatus() {
    isDone = !isDone;
  }

  // Named Consructure
  Item.fromMap(Map<String, dynamic> map)
      : title = map["title"],
        isDone = map["isDone"];

  // Convert to Map Function
  Map<String, dynamic> toMap() {
    return {"title": title, "isDone": isDone};
  }
}
