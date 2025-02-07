class Hospital {
  final String id;
  final String name;
  final String address;
  final String? telefono; 
  final String? horario; 


  Hospital({
    required this.id,
    required this.name,
    required this.address,
    this.telefono,
    this.horario,
  });
}