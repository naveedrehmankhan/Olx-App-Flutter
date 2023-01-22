import 'package:firebase/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginUserProductScreen extends StatefulWidget {
  const LoginUserProductScreen({Key? key}) : super(key: key);

  @override
  State<LoginUserProductScreen> createState() => _LoginUserProductScreenState();
}

class _LoginUserProductScreenState extends State<LoginUserProductScreen> {
  final DataController controller = Get.find();

  final editPriceValue = TextEditingController();

  editProduct(productID, produtPrice) {
    editPriceValue.text = produtPrice.toString();
    Get.bottomSheet(
      ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Enter new price"),
                  controller: editPriceValue,
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    controller.editProduct(productID, editPriceValue.text);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getLoginUserProduct();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('My Product'),
      ),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.loginUserData.isEmpty
            ? Center(
                child: Text('😔 NO DATA FOUND PLEASE ADD DATA 😔'),
              )
            : ListView.builder(
                itemCount: controller.loginUserData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: Image.network(
                            controller.loginUserData[index].productimage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Product Name: ${controller.loginUserData[index].productname}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Price: ${controller.loginUserData[index].productprice.toString()}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  editProduct(
                                      controller.loginUserData[index].productId,
                                      controller
                                          .loginUserData[index].productprice);
                                },
                                child: Text('Edit'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  controller.deleteProduct(controller
                                      .loginUserData[index].productId);
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
