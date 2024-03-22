import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/domain/car_detail_model.dart';

class CarDetailsRepo {
  final collection = FirebaseFirestore.instance.collection('models');

  Future<List<Map<String, String>>> getCarModelDetails() async {
    List<Map<String, String>> carModelList = [];

    try {
      final modelSnapshot = await collection.get();
      modelSnapshot.docs.forEach((element) {
        final data = element.data();

        if (data.containsKey('brand') && data.containsKey('model')) {
          final brand = data['brand'] as String;
          final model = data['model'] as String;

          final brandAndModel = {brand: model};

          carModelList.add(brandAndModel);
        }
      });

      return carModelList;
    } on FirebaseException catch (e) {
      print(e.message);
      return carModelList;
    }
  }

  Future<List<CarDetails>> getCarDetails() async {
    List<CarDetails> cardetailsList = [];
    try {
      final collection =
          await FirebaseFirestore.instance.collection('fleets').get();

      collection.docs.forEach((element) {
        final data = element.data();


        print("model is :${data['model']}");
        print("color is ${data['color-name']}");
        print("car number is ${data['car-number']}");

        final cardetailsdata = CarDetails(
            model: data['model'],
            color: data['color-name'],
            carnumber: data['car-number']);

        cardetailsList.add(cardetailsdata);
      });

      return cardetailsList;
    } on FirebaseException catch (e) {
      print(e.message);

      return cardetailsList;
    }
  }
}
