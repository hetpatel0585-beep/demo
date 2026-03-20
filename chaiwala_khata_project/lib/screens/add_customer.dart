
import 'package:flutter/material.dart';
import '../db/db_helper.dart';

class AddCustomer extends StatelessWidget {
  final c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('नया ग्राहक')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextField(controller: c, decoration: InputDecoration(labelText: 'नाम')),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Save'),
            onPressed: () async {
              final db = await DBHelper.db;
              await db.insert('customers', {'name': c.text});
              Navigator.pop(context);
            },
          )
        ]),
      ),
    );
  }
}
