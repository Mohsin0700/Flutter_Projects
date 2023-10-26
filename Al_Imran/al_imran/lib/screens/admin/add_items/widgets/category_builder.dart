import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/admin/add_items/widgets/add_items_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryBuilder extends StatefulWidget {
  const CategoryBuilder({super.key});

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (context, snapshot) {
        List<DropdownMenuItem> categoryItems = [];
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          final allCategories = snapshot.data!.docs.toList();
          categoryItems.add(const DropdownMenuItem(
            value: '0',
            child: Text('Select A Category'),
          ));
          for (var category in allCategories) {
            categoryItems.add(DropdownMenuItem(
              // value: category.id,
              value: category['name'],
              child: Text(
                category['name'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ));
          }
        }
        return Container(
          width: MediaQuery.of(context).size.width * 0.95,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: AlImran.baseColor)),
          child: DropdownButton(
            onTap: () => setState(() {
              AddItemConst.categorySelected = !AddItemConst.categorySelected;
            }),
            items: categoryItems,
            iconEnabledColor: AlImran.baseColor,
            onChanged: (valueRecievingFromTheListAttachedAbove) {
              setState(
                () {
                  AddItemConst.selectedCategory =
                      valueRecievingFromTheListAttachedAbove;
                  AddItemConst.categorySelected =
                      !AddItemConst.categorySelected;
                },
              );
            },
            icon: AddItemConst.categorySelected
                ? const RotatedBox(
                    quarterTurns: 3, child: Icon(Icons.arrow_back_ios))
                : const Icon(Icons.arrow_back_ios),
            isExpanded: true,
            value: AddItemConst.selectedCategory,
          ),
        );
      },
    );
  }
}
