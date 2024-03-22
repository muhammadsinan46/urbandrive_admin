import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ud_admin/features/brands/bloc/brand_list_bloc/brand_list_bloc.dart';
import 'package:ud_admin/domain/brand_model.dart';



class DeleteBrandButton extends StatelessWidget {
  const DeleteBrandButton({
    super.key,
    required this.brandList,required this.index
  });

  final List<BrandModel> brandList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Delete "),
              content: Text(
                  "Are you sure you want to delete this brand?"),
              actions: [
                GestureDetector(
                  onTap: () {
                    FirebaseFirestore
                        .instance
                        .collection(
                            'brands')
                        .doc(brandList[
                                index]
                            .id)
                        .delete()
                        .then(
                            (value) {
                      context
                          .read<
                              BrandListBloc>()
                          .add(
                              BrandListLoadedEvent());
                              Navigator.pop(context);
                    });
                  },
                  child: Container(
                    color: Colors.red,
                    height: 40,
                    width: 100,
                    child: Center(
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors
                                .white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context);
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(
                      border: Border.all(
                          color: Colors
                              .black),
                      color: Colors
                          .white,
                    ),
                    height: 40,
                    width: 100,
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors
                                .black),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
          
                                         
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(
                    10),
            color: Colors.white,
            border: Border.all()),
        height: 30,
        width: 80,
        child: Center(
            child: FaIcon(
          FontAwesomeIcons.trashCan,
          color: Colors.black,
          size: 12,
        )),
      ),
    );
  }
}
