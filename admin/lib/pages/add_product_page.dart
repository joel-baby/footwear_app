import 'package:admin/controller/home_controller.dart';
import 'package:admin/widgets/drop_down_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      initState: (_) {},
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(title: Text('Add product')),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.maxFinite,
              child: Column(
                children: [
                  Text(
                    'Add new product',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.indigoAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Product name'),
                      hintText: 'Enter your product name',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Product description'),
                      hintText: 'Enter your product description',
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Image url'),
                      hintText: 'Enter your image url',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Product price'),
                      hintText: 'Enter your product price',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: DropDownBtn(
                          items: ['Cate1', 'Cate2', 'Cate3'],
                          selectedItemText: 'Category',
                          onSelected: (selectedValue) {
                            print(selectedValue);
                          },
                        ),
                      ),
                      Flexible(
                        child: DropDownBtn(
                          items: ['Brand1', 'Brand2', 'Brand3'],
                          selectedItemText: 'Brand',
                          onSelected: (selectedValue) {
                            print(selectedValue);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Other procuct ?'),
                  SizedBox(height: 10),
                  DropDownBtn(
                    items: ['True', 'False'],
                    selectedItemText: 'Offer ?',
                    onSelected: (selectedValue) {
                      print(selectedValue);
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: Text('Add product'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
