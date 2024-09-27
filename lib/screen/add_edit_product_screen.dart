import 'package:flutter/material.dart';

class AddEditProductScreen extends StatelessWidget {
  const AddEditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8.0,
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {},
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Insert Title';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Insert Some Text';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}