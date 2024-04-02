import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ud_admin/features/dashboard/data/chart_model.dart';

class DonutChartRepo{


//Future<List<ChartModel>> 
 getChartStatusData()async{
  print("calling");

  //final String check= selectedDate.toString();

    List<ChartModel> chartStatusList=[];

    final collSnap = await FirebaseFirestore.instance.collection('bookings');

      

    // collSnap.docs.forEach((element) {

    //   final data = element.data();

    //   print(data['pickup-date']);
    //  });

    //.where('pickup-date', isEqualTo: check);





 // return chartStatusList;
  }

}