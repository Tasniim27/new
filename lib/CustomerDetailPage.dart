import 'package:flutter/material.dart';

class CustomerDetailPage extends StatefulWidget {
  final Map<String, dynamic> customer;

  CustomerDetailPage({required this.customer});

  @override
  _CustomerDetailPageState createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _addressController;
  late TextEditingController _birthdayController;

  @override
  void initState() {
    super.initState();
    final customer = widget.customer;
    _firstNameController = TextEditingController(text: customer['firstName']);
    _lastNameController = TextEditingController(text: customer['lastName']);
    _addressController = TextEditingController(text: customer['address']);
    _birthdayController = TextEditingController(text: customer['birthday']);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void _updateCustomer() {
    final updatedCustomer = {
      'id': widget.customer['id'],
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'address': _addressController.text,
      'birthday': _birthdayController.text,
    };
    Navigator.pop(context, updatedCustomer);
  }

  void _deleteCustomer() {
    Navigator.pop(context, {'id': widget.customer['id'], 'delete': true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _birthdayController,
              decoration: InputDecoration(labelText: 'Birthday (YYYY-MM-DD)'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _updateCustomer,
                  child: Text('Update'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _deleteCustomer,
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
