import 'package:client/pages/login_page.dart';
import 'package:client/widget/drop_down_btn.dart';
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
              DropDownBtn(
                items: ['Rs Low to High', 'Rs High to Low'],
                selectedItemText: 'Sort items',
                onSelected: (selected) {},
              ),
            ],
          ),

        ],
      ),
    );
  }
}
