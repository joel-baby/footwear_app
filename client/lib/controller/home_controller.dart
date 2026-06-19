import 'package:client/model/product/product.dart';
import 'package:client/model/product_category/product_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;

  List<Product> products = [];
  List<Product> productShowInUi = [];
  List<ProductCategory> productCategories = [];

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');

    await fetchCategory();
    await fetchProducts();
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrivedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      products.clear();
      products.assignAll(retrivedProducts);
      productShowInUi.assignAll(products);
      Get.snackbar(
        'Success',
        'Product fetch successfully',
        colorText: Colors.green,
      );
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorynapshot = await categoryCollection.get();
      final List<ProductCategory> retrivedCategories = categorynapshot.docs
          .map(
            (doc) =>
                ProductCategory.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();

      productCategories.clear();
      productCategories.assignAll(retrivedCategories);
    } on Exception catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  filterByCategory(String category) {
    productShowInUi.clear();
    productShowInUi = products
        .where((product) => product.category == category)
        .toList();
    update();
  }

  filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productShowInUi = products;
    } else {
      List<String> lowerCaseBrands = brands
          .map((brand) => brand.toLowerCase())
          .toList();

      productShowInUi = products
          .where(
            (product) => lowerCaseBrands.contains(product.brand?.toLowerCase()),
          )
          .toList();
    }
    update();
  }

  sortByPrice({required bool ascending}) {
    List<Product> sortedProducts = List<Product>.from(productShowInUi);
    sortedProducts.sort(
      (a, b) => ascending
          ? a.price!.compareTo(b.price!)
          : b.price!.compareTo(a.price!),
    );
    productShowInUi = sortedProducts;
    update();
  }
}
