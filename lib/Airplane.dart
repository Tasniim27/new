class Airplane {
  final String id;
  final String type;
  final int passengers;
  final int maxSpeed;
  final int range;

  Airplane({
    required this.id,
    required this.type,
    required this.passengers,
    required this.maxSpeed,
    required this.range,
  });

  // Convert Airplane to a map (for database storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'passengers': passengers,
      'maxSpeed': maxSpeed,
      'range': range,
    };
  }

  // Convert a map to an Airplane instance
  factory Airplane.fromMap(Map<String, dynamic> map) {
    return Airplane(
      id: map['id'],
      type: map['type'],
      passengers: map['passengers'],
      maxSpeed: map['maxSpeed'],
      range: map['range'],
    );
  }
}
