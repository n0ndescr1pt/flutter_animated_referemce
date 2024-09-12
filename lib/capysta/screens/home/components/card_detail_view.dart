import 'package:asdasdqweqweanimatin/capysta/constants.dart';
import 'package:asdasdqweqweanimatin/capysta/controllers/home_contoller.dart';
import 'package:asdasdqweqweanimatin/capysta/screens/home/components/cart_detailsview_card.dart';
import 'package:flutter/material.dart';

class CartDetailsView extends StatelessWidget {
  const CartDetailsView({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Cart", style: Theme.of(context).textTheme.bodyMedium),
          ...List.generate(
            controller.listProduct.length,
            (index) =>
                CartDetailsViewCard(productItem: controller.listProduct[index]),
          ),
          SizedBox(height: defaultPadding),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Next - \$30"),
            ),
          )
        ],
      ),
    );
  }
}
