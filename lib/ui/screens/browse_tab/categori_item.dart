import 'package:flutter/material.dart';
import '../../../models/category_model.dart';
import 'category_result.dart';
class CategoryItem extends StatelessWidget {
  Genres categoryModel;
  String image;

  CategoryItem(this.categoryModel, this.image, {super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryResult.routeName,arguments: categoryModel);
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        height: 200,
        width: 300,
        child: Stack(
          children: [  ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),

         child:    Image.asset(
              image,
              height: 200,
              width: 300,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
              color: Colors.grey,

            ),),
            Center(
              child: Text('${categoryModel.name}',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
