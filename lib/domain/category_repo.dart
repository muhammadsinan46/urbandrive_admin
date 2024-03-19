import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/domain/category_model.dart';

class CategoryRepo {
  Future<List<CategoryModel>>getCategoryData() async {
    List<CategoryModel> categoryList = [];

   

    try {
        
      final cateCollection =
          await FirebaseFirestore.instance.collection('category').get();
     
      cateCollection.docs.forEach((element) {
        final data = element.data();
       
        final category = CategoryModel(
          id: data['id'],
            name: data['name'],
            description: data['description'],
            image: data['image']);
        
        categoryList.add(category);
          
      });
   
      return categoryList;
    } on FirebaseException catch (e) {
      print("error is ${e.message}");

      return categoryList;
    }
  }
}
