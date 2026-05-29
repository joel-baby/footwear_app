import 'package:admin/controller/home_controller.dart';
import 'package:admin/pages/add_product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(title: Text("Footwear admin")),
          body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('title'),
                subtitle: Text('Price : 100'),
                trailing: IconButton(
                  onPressed: () {
                    print('delete');
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(AddProductPage());
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
