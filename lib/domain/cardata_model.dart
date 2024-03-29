class CarDataModel {
  String id;
  String? category;
  String? brand;
  String? model;
  String? transmit;
  String? fuel;
  String? baggage;
  String? price;
  String? seats;
  String? deposit;
  String? freekms;
  String? extrakms;
  String? carColor;
  List images;

  CarDataModel({
    required this.id,
    required this.category,
    required this.brand,
    required this.model,
    required this.transmit,
    required this.fuel,
    required this.baggage,
    required this.price,
    required this.seats,
    required this.deposit,
    required this.freekms,
    required this.extrakms,
    required this.images,
    required this.carColor,
  });
}
