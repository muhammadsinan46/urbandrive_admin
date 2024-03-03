import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/domain/cardata_model.dart';

 
class CarDataModelRepo{


      final List<CarDataModel> carmodelslist = [];


      Future<List<CarDataModel>>getCarDataModels()async{

    try {
      final carDataModelCollection =
          await FirebaseFirestore.instance.collection('models').get();

      carDataModelCollection.docs.forEach((element) {
        final data = element.data();

        final carmodel = CarDataModel(
            id: data['id'],
            category: data['category'],
            brand: data['brand'],
            model: data['model'],
            transmit: data['transmit'],
            fuel: data['fuel'],
            baggage: data['baggage'],
            price: data['price'],
            seats: data['seats'],
            deposit: data['deposit'],
            freekms: data['freekms'],
            extrakms: data['extrakms'],
            images: data['carImages']);

        carmodelslist.add(carmodel);
        print(carmodelslist);
      });

      return carmodelslist;
    } on FirebaseException catch (e) {
      print("error is ${e.message}");
      return carmodelslist;
    }
      }


}