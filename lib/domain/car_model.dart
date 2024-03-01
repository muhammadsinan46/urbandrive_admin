import 'dart:typed_data';

class CarModel {
  String category;
  String brand;
  String model;
  String fuel;
  String baggage;
  String price;
  String seats;
  List<Uint8List> images;

  CarModel(
      {required this.category,
      required this.brand,
      required this.model,
      required this.fuel,
      required this.baggage,
      required this.price,
      required this.seats,
      required this.images});
}
