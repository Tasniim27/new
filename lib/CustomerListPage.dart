import 'package:flutter/material.dart';
import 'customerFormPage.dart';
import 'customerDetailPage.dart';
import 'localization_service.dart';

class CustomerListPage extends StatefulWidget {
  final Function(Locale) changeLanguage;
  final Locale locale;

  CustomerListPage({required this.changeLanguage, required this.locale});

  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  List<Map<String, dynamic>> _customers = [];

  void _showCustomerDetails(Map<String, dynamic> customer) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerDetailPage(customer: customer),
      ),
    );

    if (result != null) {
      if (result.containsKey('delete') && result['delete']) {
        setState(() {
          _customers.removeWhere((c) => c['id'] == result['id']);
        });
      } else if (result.containsKey('id')) {
        setState(() {
          final index = _customers.indexWhere((c) => c['id'] == result['id']);
          if (index != -1) {
            _customers[index] = result;
          }
        });
      }
    }
  }

  void _addCustomer() async {
    final newCustomer = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomerFormPage(
          onCustomerAdded: (customer) {
            setState(() {
              _customers.add(customer);
            });
          },
        ),
      ),
    );

    if (newCustomer != null) {
      setState(() {
        _customers.add(newCustomer as Map<String, dynamic>);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = LocalizationService.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('customer_list')),
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (locale) {
              widget.changeLanguage(locale);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: Locale('en', 'US'),
                child: Text(localization.translate('english')),
              ),
              PopupMenuItem(
                value: Locale('es', 'ES'),
                child: Text(localization.translate('spanish')),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(localization.translate('instructions')),
                  content: Text(localization.translate('instructions_content')),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _addCustomer,
              child: Text(localization.translate('add_customer')),
            ),
          ),
          Expanded(
            child: _customers.isEmpty
                ? Center(child: Text(localization.translate('no_customers')))
                : ListView.builder(
              itemCount: _customers.length,
              itemBuilder: (context, index) {
                final customer = _customers[index];
                return ListTile(
                  title: Text('${customer['firstName']} ${customer['lastName']}'),
                  subtitle: Text(customer['address']),
                  onTap: () => _showCustomerDetails(customer),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
