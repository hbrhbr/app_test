import 'package:app_test/view/base/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../util/color_constants.dart';

class CategoryWiseSearchScreen extends StatefulWidget {
  const CategoryWiseSearchScreen({Key? key}) : super(key: key);

  @override
  State<CategoryWiseSearchScreen> createState() => _CategoryWiseSearchScreenState();
}

class _CategoryWiseSearchScreenState extends State<CategoryWiseSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: kToolbarHeight + 50,
          width: context.width,
          padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
          child: CustomInputTextField(
            controller: TextEditingController(),
            readOnly: true,
            focusNode: null,
            context: context,
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColor.appBarDividerColor,),
      ],
    );
  }
}
