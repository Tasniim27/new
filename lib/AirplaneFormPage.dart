import 'package:flutter/material.dart';
import 'airplane.dart';
import 'LocalizationService.dart'; // Import your localization service

class AirplaneFormPage extends StatefulWidget {
  final Function addOrUpdateAirplane;
  final Airplane? airplane;

  AirplaneFormPage({required this.addOrUpdateAirplane, this.airplane});

  @override
  _AirplaneFormPageState createState() => _AirplaneFormPageState();
}

class _AirplaneFormPageState extends State<AirplaneFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _type;
  late int _passengers;
  late int _maxSpeed;
  late int _range;

  @override
  void initState() {
    super.initState();
    if (widget.airplane != null) {
      _type = widget.airplane!.type;
      _passengers = widget.airplane!.passengers;
      _maxSpeed = widget.airplane!.maxSpeed;
      _range = widget.airplane!.range;
    } else {
      _type = '';
      _passengers = 0;
      _maxSpeed = 0;
      _range = 0;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newAirplane = Airplane(
        id: widget.airplane?.id ?? DateTime.now().toString(),
        type: _type,
        passengers: _passengers,
        maxSpeed: _maxSpeed,
        range: _range,
      );
      widget.addOrUpdateAirplane(newAirplane);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.airplane == null
            ? LocalizationService.translate('addAirplane') ?? 'Add Airplane'
            : LocalizationService.translate('editAirplane') ?? 'Edit Airplane'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _type,
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('airplaneType') ?? 'Type',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocalizationService.translate('typeRequired') ?? 'Please enter a type.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _type = value!;
                },
              ),
              TextFormField(
                initialValue: _passengers.toString(),
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('passengers') ?? 'Passengers',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || int.tryParse(value) == null) {
                    return LocalizationService.translate('validNumberRequired') ?? 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _passengers = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _maxSpeed.toString(),
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('maxSpeed') ?? 'Max Speed',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || int.tryParse(value) == null) {
                    return LocalizationService.translate('validNumberRequired') ?? 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _maxSpeed = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _range.toString(),
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('range') ?? 'Range',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty || int.tryParse(value) == null) {
                    return LocalizationService.translate('validNumberRequired') ?? 'Please enter a valid number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _range = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text(LocalizationService.translate('submit') ?? 'Submit'),
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
