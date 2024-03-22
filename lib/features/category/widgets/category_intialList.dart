import 'package:flutter/material.dart';
import 'package:ud_admin/domain/category_model.dart';


class CategoryInitialList extends StatelessWidget {
  const CategoryInitialList({
    super.key,
    required this.categoryList,
  });

  final List<CategoryModel> categoryList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              //    childAspectRatio: 1.2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 30.0),
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }
}
