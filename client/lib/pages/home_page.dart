import 'package:client/controller/home_controller.dart';
import 'package:client/pages/login_page.dart';
import 'package:client/pages/product_description_page.dart';
import 'package:client/widget/drop_down_btn.dart';
import 'package:client/widget/multi_select_dropdown.dart';
import 'package:client/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Footwear Store',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase();
                  Get.offAll(LoginPage());
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Chip(label: Text('Category')),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                      items: ['Rs Low to High', 'Rs High to Low'],
                      selectedItemText: 'Sort items',
                      onSelected: (selected) {},
                    ),
                  ),
                  Flexible(
                    child: MultiSelectDropdown(
                      items: ['item1', 'item2', 'item3'],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: ctrl.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      name: ctrl.products[index].name ?? 'No name',
                      imageUrl:
                          ctrl.products[index].image ?? 'url',
                      price: ctrl.products[index].price ?? 00,
                      offerTag: '30% off',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDescriptionPage(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
