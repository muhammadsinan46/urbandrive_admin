import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/domain/brand_model.dart';

class BrandRepo{

  

Future<List<BrandModel>> getbrandData()async{

  List<BrandModel> brandlist =[];

try{
    final brandcollection = await FirebaseFirestore.instance.collection('brands').get();

  brandcollection.docs.forEach((element) { 

   final  data  = element.data();
   final brand = BrandModel(
    id: data['id'],
    name: data['name'], description: data['description'], logo: data['logo']);
   
   brandlist.add(brand);
  });
  return brandlist;
}on FirebaseException catch(e){
   print("error is ${e.message}");

   return brandlist;
}

}
}   