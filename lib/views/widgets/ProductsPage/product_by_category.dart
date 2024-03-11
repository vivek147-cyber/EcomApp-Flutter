import 'package:ecom_app/models/products_models.dart';
import 'package:ecom_app/responsive/responsive_layout.dart';
import 'package:ecom_app/views/shared/list_item.dart';
import 'package:flutter/material.dart';
import '../../../controllers/products_controllers.dart';
import '../ProductsDetail/product_details.dart';

class ProductByCategory extends StatefulWidget {
  const ProductByCategory({Key? key}) : super(key: key);

  @override
  _ProductByCategoryState createState() => _ProductByCategoryState();
}

class _ProductByCategoryState extends State<ProductByCategory> {
  final ProductController products = ProductController();

  @override
  void initState() {
    super.initState();
    products.fetchProductsData();
    products.fetchProductsByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FutureBuilder(
            future: products.fetchProductsData(),
            builder: (context, AsyncSnapshot<List<Products>?> snapshot) {
             
                List<Products>? prod = snapshot.data;

                return LayoutBuilder(builder: (context, Constraints) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      itemCount: prod != null ? prod.length : 0,
                      padding: EdgeInsets.only(bottom: 150.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 817 ? 3 : 2,
                        childAspectRatio: Responsive.isMobile(context)
                            ? MediaQuery.of(context).size.aspectRatio * 1.8
                            : 1.5,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    data: prod?[index],
                                  ),
                                ));
                          },
                          child: ListItem(prod?[index])),
                    ),
                  );
                });
              }
            ),
      ],
    );
  }

//   Widget _buildCategoryRow(List<Categories>? categories) {
//   return Container(
//     height: 50,
//     child:
//   );
// }
}
