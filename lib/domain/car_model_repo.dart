import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ud_admin/domain/car_model.dart';

class CarModelRepo{

  List<CarModel> carModel =[];
  final categoryCollection = FirebaseFirestore.instance.collection('category');
  final brandCollection = FirebaseFirestore.instance.collection('brands');

// Future<List<CarModel>> getModelData()async{



// }

Future<List<String>> uploadCategoryList()async{

final List<String>  categoryList = [];
try{
  final categorysnapshot = await categoryCollection.get();

categorysnapshot.docs.forEach((element) {
final data = element.get('name');

categoryList.add(data);
});

return categoryList;
}on FirebaseException catch(e){

  print(e.message);

  return categoryList;
}

}



Future<List<String>> uploadBrandList()async{
  final List<String> brandList =[];

  try{

  final brandsnapshot = await brandCollection.get();

  brandsnapshot.docs.forEach((element) {
    final data = element.get('name');
    brandList.add(data);

  });
    return brandList;
  }on FirebaseException catch(e){

    print(e.message);
     return brandList;
  }


}

}