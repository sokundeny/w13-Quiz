import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';

class GrocerySearch extends StatefulWidget {
  const GrocerySearch({super.key});

  @override
  State<GrocerySearch> createState() => _GrocerySearchState();
}

class _GrocerySearchState extends State<GrocerySearch> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    List<Grocery> filteredItems = dummyGroceryItems.where((grocery) {
      return grocery.name
          .toLowerCase()
          .startsWith(searchText.toLowerCase());
    }).toList();

    Widget content = const Center(child: Text('No items'));

    if (filteredItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) =>
            GroceryTile(grocery: filteredItems[index]),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
            },
          ),
        ),

        Expanded(child: content),
      ],
    );
  }
}


class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
