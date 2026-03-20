
import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import 'add_customer.dart';
import 'customer_detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> list = [];

  load() async {
    final db = await DBHelper.db;
    list = await db.query('customers');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('☕ Chaiwala Khata')),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, i) => ListTile(
          title: Text(list[i]['name']),
          onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => CustomerDetail(list[i]))
          ).then((_) => load()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => AddCustomer())
        ).then((_) => load()),
      ),
    );
  }
}
