import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/domain/customers_model.dart';

class CustomersRepo {
  Future<List<CustomersModel>> getcustomersList() async {
    List<CustomersModel> customerslist = [];

    try {
      final collection =
          await FirebaseFirestore.instance.collection('users').get();

      collection.docs.forEach((element) {
        final data = element.data();

        final customerData = CustomersModel(
            id: data['uid'],
            name: data['name'],
          //  profile: data['profile'],
            email: data['email'],
            mobile: data['mobile'],
            
            );

        customerslist.add(customerData);
      });

      return customerslist;
    } on FirebaseException catch (e) {
      print("failed to fetch the users list ${e.message}");
      return customerslist;
    }
  }
}
