import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroceryListPage extends StatefulWidget {
  const GroceryListPage({super.key});

  @override
  State<GroceryListPage> createState() => _GroceryListPageState();
}

class _GroceryListPageState extends State<GroceryListPage> {
  final items = [
    {'name': 'Milk', 'qty': 2, 'checked': false},
    {'name': 'Bread', 'qty': 1, 'checked': false},
    {'name': 'Eggs', 'qty': 12, 'checked': false},
    {'name': 'Coffee', 'qty': 1, 'checked': false},
    {'name': 'Butter', 'qty': 1, 'checked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grocery List')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return CheckboxListTile(
                  title: Text(item['name'] as String),
                  subtitle: Text('Qty: ${item['qty']}'),
                  value: item['checked'] as bool,
                  onChanged: (val) {
                    setState(() {
                      items[index]['checked'] = val ?? false;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Send to Valet'),
                      content: const Text('Your grocery list has been sent to the valet service. They will shop for you!'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text('Send to Valet'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
