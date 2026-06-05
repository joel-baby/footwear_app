import 'package:client/pages/login_page.dart';
import 'package:client/pages/product_description_page.dart';
import 'package:client/widget/drop_down_btn.dart';
import 'package:client/widget/multi_select_dropdown.dart';
import 'package:client/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Footwear Store',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(LoginPage());
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
                child: MultiSelectDropdown(items: ['item1', 'item2', 'item3']),
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
              itemCount: 10,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: 'Puma footwear',
                  imageUrl:
                      'https://images.unsplash.com/photo-1542291026-7eec264c27ff?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  price: 200,
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
  }
}
