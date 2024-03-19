import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/domain/cardata_model.dart';

 
class CarDataModelRepo{




      Future<List<CarDataModel>>getCarDataModels()async{

      final List<CarDataModel> carmodelslist = [];
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
            images: data['carImages'],
            carColor:data['color']
            );
    
          

        carmodelslist.add(carmodel);
    
      });

      return carmodelslist;
    } on FirebaseException catch (e) {
      print("error is ${e.message}");
      return carmodelslist;
    }
      }


}