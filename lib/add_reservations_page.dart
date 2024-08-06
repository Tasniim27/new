import 'package:flutter/material.dart';
import 'ReservationItem.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class AddReservationPage extends StatefulWidget {
  const AddReservationPage({super.key, required this.onAddReservation, required this.language, required this.languageSwitch});

  final void Function(ReservationItem) onAddReservation;
  final List<String> language;
  final bool languageSwitch;

  @override
  _AddReservationPageState createState() => _AddReservationPageState();
}

class _AddReservationPageState extends State<AddReservationPage> {
  final EncryptedSharedPreferences _storedData = EncryptedSharedPreferences();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerIDController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerPhoneController = TextEditingController();
  final TextEditingController _flightIDController = TextEditingController();
  final TextEditingController _flightDepartureCityController = TextEditingController();
  final TextEditingController _flightDestinationCityController = TextEditingController();
  final TextEditingController _flightDepartureDateController = TextEditingController();
  final TextEditingController _flightArrivalDateController = TextEditingController();
  final TextEditingController _reservationDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPreviousCustomerData();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _loadPreviousCustomerData() async {
    String? customerID = await _storedData.getString("customerID");
    String? customerName = await _storedData.getString("customerName");
    String? customerPhone = await _storedData.getString("customerPhone");
    String? flightID = await _storedData.getString("flightID");
    String? flightDepartureCity = await _storedData.getString("flightDepartureCity");
    String? flightDestinationCity = await _storedData.getString("flightDestinationCity");
    String? reservationDate = await _storedData.getString("reservationDate");

    if (customerID.isNotEmpty && customerName.isNotEmpty && customerPhone.isNotEmpty && flightID.isNotEmpty && flightDepartureCity.isNotEmpty && flightDestinationCity.isNotEmpty && reservationDate.isNotEmpty) {
      setState(() {
        _customerIDController.text = customerID;
        _customerNameController.text = customerName;
        _customerPhoneController.text = customerPhone;
        _flightIDController.text = flightID;
        _flightDepartureCityController.text = flightDepartureCity;
        _flightDestinationCityController.text = flightDestinationCity;
        _reservationDateController.text = reservationDate;
      });
    }
  }

  Future<void> _saveCustomerData() async {
    await _storedData.setString("customerID", _customerIDController.text);
    await _storedData.setString("customerName", _customerNameController.text);
    await _storedData.setString("customerPhone", _customerPhoneController.text);
    await _storedData.setString("flightID", _flightIDController.text);
    await _storedData.setString("flightDepartureCity", _flightDepartureCityController.text);
    await _storedData.setString("flightDestinationCity", _flightDestinationCityController.text);
    await _storedData.setString("reservationDate", _reservationDateController.text);
  }

  void _clearForm() {
    setState(() {
      _customerIDController.clear();
      _customerNameController.clear();
      _customerPhoneController.clear();
      _flightIDController.clear();
      _flightDepartureCityController.clear();
      _flightDestinationCityController.clear();
      _flightDepartureDateController.clear();
      _flightArrivalDateController.clear();
      _reservationDateController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.language[4]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _clearForm,
                    child: Text(widget.language[7]),
                  ),
                  ElevatedButton(
                    onPressed: _loadPreviousCustomerData,
                    child: Text(widget.language[8]),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _customerIDController,
                decoration: InputDecoration(labelText: widget.language[9]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[10];
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(labelText: widget.language[11]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[12];
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _customerPhoneController,
                decoration: InputDecoration(labelText: widget.language[13]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[14];
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _flightIDController,
                decoration: InputDecoration(labelText: widget.language[15]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[16];
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _flightDepartureCityController,
                decoration: InputDecoration(labelText: widget.language[17]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[18];
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _flightDestinationCityController,
                decoration: InputDecoration(labelText: widget.language[19]),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[20];
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _flightDepartureDateController,
                decoration: InputDecoration(labelText: widget.language[21]),
                readOnly: true,
                onTap: () => _selectDate(context, _flightDepartureDateController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[22];
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _flightArrivalDateController,
                decoration: InputDecoration(labelText: widget.language[23]),
                readOnly: true,
                onTap: () => _selectDate(context, _flightArrivalDateController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[24];
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _reservationDateController,
                decoration: InputDecoration(labelText: widget.language[25]),
                readOnly: true,
                onTap: () => _selectDate(context, _reservationDateController),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return widget.language[26];
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newReservation = ReservationItem(
                        ReservationItem.ID++,
                        int.parse(_customerIDController.text),
                        int.parse(_flightIDController.text),
                        _reservationDateController.text,
                        _customerNameController.text,
                        _customerPhoneController.text,
                        _flightDepartureCityController.text,
                        _flightDestinationCityController.text,
                        _flightDepartureDateController.text,
                        _flightArrivalDateController.text
                    );
                    widget.onAddReservation(newReservation);
                    _saveCustomerData();
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.language[27]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
