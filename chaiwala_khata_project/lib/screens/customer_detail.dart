
import 'package:flutter/material.dart';
import '../db/db_helper.dart';

class CustomerDetail extends StatefulWidget {
  final Map c;
  CustomerDetail(this.c);

  @override
  State<CustomerDetail> createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  List<Map<String, dynamic>> list = [];
  double bal = 0;

  load() async {
    final db = await DBHelper.db;
    list = await db.query('khata', where: 'customerId=?', whereArgs: [widget.c['id']]);
    bal = 0;
    for (var x in list) {
      bal += x['type'] == 'SALE' ? x['amount'] : -x['amount'];
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  add(String t) async {
    final db = await DBHelper.db;
    await db.insert('khata', {
      'customerId': widget.c['id'],
      'type': t,
      'amount': 10,
      'date': DateTime.now().toString()
    });
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.c['name'])),
      body: Column(children: [
        Padding(padding: EdgeInsets.all(16), child: Text('Balance ₹$bal', style: TextStyle(fontSize: 22))),
        Expanded(child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(list[i]['type']),
            trailing: Text('₹${list[i]['amount']}'),
          ),
        ))
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(heroTag: 's', child: Text('+'), onPressed: () => add('SALE')),
          SizedBox(height: 10),
          FloatingActionButton(heroTag: 'p', child: Text('-'), onPressed: () => add('PAYMENT')),
        ],
      ),
    );
  }
}
