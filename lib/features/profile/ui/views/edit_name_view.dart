import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/functions/build_app_bar.dart';
import '../../../../core/widgets/custom_e_btn.dart';
import '../../../../core/resources/constans.dart';
import 'package:flutter/material.dart';

class EditNameView extends StatelessWidget {
  const EditNameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(context, Constans.editNameText),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              labelText: Constans.nameHintText,
              kayboardTybe: TextInputType.text,
            ),
            const SizedBox(height: 20),
            CustomEBtn(
              onPressed: () {
                Navigator.pop(context);
              },
              hintText: Constans.updateText,
            ),
          ],
        ),
      ),
    );
  }
}
