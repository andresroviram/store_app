import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/product_list.dart';

class HomeMobile extends StatelessWidget {
  const HomeMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Text(
                'product_list'.tr(),
                textAlign: TextAlign.left,
              ),
            ),
            const ProductListWidget(),
          ],
        ),
      ),
    );
  }
}
